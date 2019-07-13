Steps to setup

```
bundle install
rake db:create
rake db:migrate
```

Copy `.env` to root directory with the following content

```
USERNAME = 'app store user name'
PASSWORD = 'app store password'
APP_NAME = 'io.transporterapp.test1'
```

What can be improved on:

1) Async loading of partials
2) Make it work for all apps in the account, right now I reduced the scope
to single app by passing in ENV
3) Rspec tests for controller

Demo here: https://infinite-peak-54103.herokuapp.com/
