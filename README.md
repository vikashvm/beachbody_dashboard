##SETUP

install ruby 2.2.2 on your system

clone settings.yml.example as settings.yml in the same directory.

fill all the settings values i.e. url, username, password etc for splunk server

to install all the dependencies run following command

```bash
bundle install
```

##START SERVER

from root directory of code

```bash
dashing start -E production -p {port_number}
```

e.g. to run server on port 8080 run
dashing start -E production -p 8080

##Log

from root directory of code

```bash
tail -f log/thin.log
```
