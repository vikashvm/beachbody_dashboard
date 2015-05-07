#SETUP

install ruby 2.2.2 on your system

clone settings.yml.example as settings.yml in the same directory.

fill all the settings values i.e. url, username, password etc for splunk server

```bash
bundle install
```

#START SERVER

```bash
dashing start -E production -p {port_number}
```

#Log

from root directory of code

```bash
tail -f log/thin.log
```
