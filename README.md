# home-sweet-home

This project assumes that you performed a minial Debian installation.

If you set a password for the `root` during the installation, follow [this wiki page to configure `sudo`](https://wiki.debian.org/sudo/). Don't forget to log out and log back in before procceeding.

Download the raw version of the `bootstrap.sh` file, grant   it execution permissions, and run it.

> Optionally, you can pass a branch name to the bootstrap.sh command.
> This is ,mainly used for testing something before merging it into the main branch.

```bash
wget https://raw.githubusercontent.com/giulianisanches/home-sweet-home/main/bootstrap.sh
chmod u+x bootstrap.sh
./bootstrap.sh
```

After you finish your setup, if you used your wireless connection, you can face issues with NetworkManager not being able to manage your connections.

You will need to change two files to get it fixed:

`sudo vim /etc/network/interfaces`

Locate the following block and delete it:

```shell
iface <your wireless interface> <additional options>
    wpa-(...) <ssid of your wireless>
    wpa-(...) <plain text password of your wireless>
```

`sudo vim /etc/NetworkManager/NetworkManager.conf`

Locate the `[ifupdown]` section and change the value `managed=false` to `managed=true`.

After that, restart your PC.

If you're still having issues, consult the [official documentation](https://wiki.debian.org/WiFi).

## License

MIT License

## Author Information

Giuliani Deon Sanches
