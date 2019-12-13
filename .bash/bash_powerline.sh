#!/usr/bin/env bash

# disable git info
# POWERLINE_GIT=0

__powerline() {
    # Colorscheme
    reset='\[\033[m\]'

    COLOR_CWD="${COLOR_CWD:-\[\033[0;34m\]}" #  default: blue
    COLOT_GIT="${COLOT_GIT:-\[\033[0;36m\]}" # default: cyan
    COLOR_SUCCESS="${COLOR_SUCCESS:-\[\033[0;32m\]}" # default: green
    COLOR_FAILURE="${COLOR_FAILURE:-\[\033[0;31m\]}" # default: red
    COLOR_USER="${COLOR_USER:-\[\e[0;36m\]}"
    COLOR_HOST="${COLOR_HOST:-\[\e[0;36m\]}"
    COLOR_VIRTUAL_ENV="${COLOR_VIRTUAL_ENV:-\[\033[0;34m\]}"

    SYMBOL_GIT_BRANCH="${SYMBOL_GIT_BRANCH:-⑂}"
    SYMBOL_GIT_MODIFIED="${SYMBOL_GIT_MODIFIED:-*}"
    SYMBOL_GIT_PUSH="${SYMBOL_GIT_PUSH:-↑}"
    SYMBOL_GIT_PULL="${SYMBOL_GIT_PULL:-↓}"

    PYTHON_SYMBOL="${PYTHON_SYMBOL:-ƨ}"

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='\$';;
          *)        PS_SYMBOL='%';;
      esac
    fi

    __git_info() { 
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref="$($git_eng symbolic-ref --short HEAD 2>/dev/null)"

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref="$SYMBOL_GIT_BRANCH $ref"
        else
            # get tag name or short unique hash
            ref="$($git_eng describe --tags --always 2>/dev/null)"
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf "$ref$marks"
    }
 
    __virtualenv() {
        if [ -z "${VIRTUAL_ENV}" ] ; then
            return
        else
            local virtualenv="$(basename $VIRTUAL_ENV)"
            printf "$PYTHON_SYMBOL $virtualenv"
        fi
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local symbol="$COLOR_SUCCESS$PS_SYMBOL $reset"
        else
            local symbol="$COLOR_FAILURE$PS_SYMBOL $reset"
        fi

        local cwd="$COLOR_CWD\w$reset"
        local virtualenv="$COLOR_VIRTUAL_ENV$(__virtualenv)$reset"
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="$COLOT_GIT\${__powerline_git_info}$reset"
        else
            # promptvars is disabled. Avoid creating unnecessary env var.
            local git="$COLOT_GIT$(__git_info)$reset"
        fi

        PS1="${COLOR_USER}\u${COLOR_HOST}@\h $cwd $virtualenv $git\n$symbol"
    }

    PROMPT_COMMAND="ps1${prompt_command:+; $prompt_command}"
}

__powerline
unset __powerline
