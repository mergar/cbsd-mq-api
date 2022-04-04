# CBSD RESTFull API

Copyright (c) 2013-2022, The CBSD Development Team

Homepage: https://bsdstore.ru/
Homepage: https://github.com/cbsd/

## Description

Provides a simplified API for creating and manage CBSD virtual environments.

#### Table of Contents

1. [Project Description - What does the project do?](#project-description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Contributing - Contribute to the project](#contributing)
4. [Support - Mailing List, Talks, Contacts](#support)

## Usage

Init:

set GOPATH

go get
go run ./cbsd-mq-api [ -l listen]

# Install

mkdir -p /var/db/cbsd-api /usr/jails/var/db/api/map
chown -R cbsd:cbsd /var/db/cbsd-api /usr/jails/var/db/api/map

Install broker/router and CBSD api.d module:

```
pkg install -y beanstalkd cbsd-mq-router cbsd-mq-api
cbsd module mode=install api
echo 'api.d' >> ~cbsd/etc/modules.conf
cbsd initenv
```

Enable and launch broker/router:

```
service beanstalkd enable
service cbsd-mq-router enable
service cbsd-mq-api enable
service beanstalkd start
service cbsd-mq-router start
service cbsd-mq-api start
```

Setup api.d module: make sure

    "recomendation": "/usr/local/cbsd/modules/api.d/misc/recomendation.sh",
    "freejname": "/usr/local/cbsd/modules/api.d/misc/freejname.sh",

script works (from cbsd user):

```
chown cbsd:cbsd ~cbsd/etc/api.conf
```

Correct 'server_url' in /usr/local/etc/cbsd-mq-api.json

# On host

1) pkg install -y sysutils/cbsd-mq-router

2) setup cbsd-mq-router.json, e.g:

```
{
    "cbsdenv": "/usr/jails",
    "cbsdcolor": false,
    "broker": "beanstalkd",
    "logfile": "/dev/stdout",
    "beanstalkd": {
      "uri": "127.0.0.1:11300",
      "tube": "cbsd_host1_example_com",
      "reply_tube_prefix": "cbsd_host1_example_com_result_id",
      "reconnect_timeout": 5,
      "reserve_timeout": 5,
      "publish_timeout": 5,
      "logdir": "/var/log/cloudmq"
    }
}
```

3) service cbsd-mq-router enable
4) service cbsd-mq-router start

## Usage

# Via curl, valid endpoints:

```
curl -H "cid:<cid>" http://127.0.0.1:65531/images
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/cluster
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/create/<env>
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/status/<env>
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/start/<env>
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/stop/<env>
curl -H "cid:<cid>" http://127.0.0.1:65531/api/v1/destroy/<env>
```

Examples:

cat > debian11.json <<EOF
{
  "type": "bhyve",
  "imgsize": "10g",
  "ram": "1g",
  "cpus": "2",
  "img": "debian11",
  "pubkey": "ssh-ed25519 AAAAC.. yourname@your.host"
}
EOF

curl --no-progress-meter -X POST -H "Content-Type: application/json" -d @debian11.json http://127.0.0.1:65531/api/v1/create/debian11

# Via nubectl:



## Contributing

* Fork me on GitHub: [https://github.com/cbsd/cbsd-mq-api.git](https://github.com/cbsd/cbsd-mq-api.git)
* Switch to 'develop' branch
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push`)
* Create new Pull Request

## Get Support

* GitHub: https://github.com/cbsd/cbsd-mq-api/issues
* For CBSD-related support, discussion and talks, please join to Telegram CBSD usergroup channel: @cbsdofficial
* Telegram Web link: https://t.me/cbsdofficial

## Support Us

* https://www.patreon.com/clonos
