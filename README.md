
Linux Motd [![Build Status](https://travis-ci.org/lucasmaurice/ansible-role-linux-motd.svg?branch=master)](https://travis-ci.org/lucasmaurice/ansible-role-linux-motd)
=========

Install a standardized welcome message on a **Debian** or a **RedHat** host.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml):

```yaml
---
MOTD_CONTACT: sysadmin@lanets.ca

# Name of the interfaces to read the Ip address.
MOTD_PRIVATE_INTERFACE: x
MOTD_PUBLIC_INTERFACE: x

# Welcome message and font. Select a font here: http://www.figlet.org/fontdb.cgi
MOTD_WELCOME_FONT: banner3
MOTD_WELCOME: DHMTL

# Users to disable default motd
users: []
```

- `MOTD_CONTACT`: The contact email address to show.

- `MOTD_PRIVATE_INTERFACE`: Network interface you want to read the private Ip address to show.

- `MOTD_PUBLIC_INTERFACE`: Network interface you want to read the public Ip address to show.

> Set the network interface to *x* or do not set it for no interface.

- `MOTD_WELCOME_FONT`: The font of the welcome word. (Select a font on the [Figlet Website](http://www.figlet.org/fontdb.cgi))

- `MOTD_WELCOME`: The welcome word.

- `users`: Global variable containing all the users. Will disable the default motd on all listed users.

Example Playbook
----------------

This is an example of how to use this role:

```yaml
    - hosts: servers
        roles:
            - { role: linux-motd,
                MOTD_CONTACT: sysadmin@dhmtl.ca,
                MOTD_PRIVATE_INTERFACE: eth0,
                MOTD_WELCOME_FONT: banner3,
                MOTD_WELCOME: DHMTL
                }
```

This is the example result, **without colorization**:

```text
Welcome to DJLS-DOMOTIC managed by sysadmin@lanets.ca

Running on Debian GNU/Linux 9 with kernel 4.15.17-1-pve


########  ##     ## ##     ## ######## ##
##     ## ##     ## ###   ###    ##    ##
##     ## ##     ## #### ####    ##    ##
##     ## ######### ## ### ##    ##    ##
##     ## ##     ## ##     ##    ##    ##
##     ## ##     ## ##     ##    ##    ##
########  ##     ## ##     ##    ##    ########

 █ System date.........: Mon May 27 17:35:06 EDT 2019
 █ Uptime..............: 5d 17h 30m 31s
 █ CPU usage...........: 0.52, 0.39, 0.40
 █ Memory used.........: 257 MB / 1024 MB
 █ Swap in use.........: 0 MB 
 █ IP on Internet......: 189.178.145.123
 █ Private IP..........: 192.168.1.123/24 / 192.168.1.255

 ____________________________________
/ First Law of Bicycling:            \
|                                    |
| No matter which way you ride, it's |
\ uphill and against the wind.       /
 ------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

root@djls-domotic:~$
```

License
-------

WTFPL
