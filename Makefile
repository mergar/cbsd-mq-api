UNAME_S := $(shell uname -s)
APP_VER := $(shell cat version )

all: 
	@./build.sh

clean:
	rm -f cbsd-mq-api *.deb
	rm -rf src
	make -C deb clean


install: all
	install cbsd-mq-api /usr/local/sbin
ifeq ($(UNAME_S),Linux)
	install systemd/cbsd-mq-api.service /lib/systemd/system/cbsd-mq-api.service
	install deb/root/lib/systemd/system/cbsd-mq-api.service /lib/systemd/system/cbsd-mq-api.service
	systemctl daemon-reload
	@test -d /var/log/cbsdmq || mkdir -m 0755 /var/log/cbsdmq
	@test -d /var/log/cbsd_mq_api || mkdir -m 0755 /var/log/cbsd_mq_api
	@chown cbsd:cbsd /var/log/cbsdmq /var/log/cbsd_mq_api
	@test -r /etc/cbsd-mq-api.json || sed 's:/dev/stdout:/var/log/cbsd_mq_api/cbsd_mq_api.log:g' etc/cbsd-mq-api.json > /etc/cbsd-mq-api.json
else
	install rc.d/cbsd-mq-api /usr/local/etc/rc.d/cbsd-mq-api
endif

uninstall:
ifeq ($(UNAME_S),Linux)
	rm -f /usr/local/sbin/cbsd-mq-api /lib/systemd/system/cbsd-mq-api.service
else
	rm -f /usr/local/sbin/cbsd-mq-api /usr/local/etc/rc.d/cbsd-mq-api
endif

deb: all
	make -C deb clean
	@test -d deb/root/usr/local/sbin || mkdir -p -m 0755 deb/root/usr/local/sbin
	install cbsd-mq-api deb/root/usr/local/sbin/cbsd-mq-api
	@test -d deb/root/lib/systemd/system || mkdir -p -m 0755 deb/root/lib/systemd/system
	install systemd/cbsd-mq-api.service deb/root/lib/systemd/system/cbsd-mq-api.service
	@test -d deb/root/var/log/cbsdmq || mkdir -m 0755 -p deb/root/var/log/cbsdmq
	@test -d deb/root/var/log/cbsd_mq_api || mkdir -m 0755 -p deb/root/var/log/cbsd_mq_api
	@chown cbsd:cbsd deb/root/var/log/cbsdmq deb/root/var/log/cbsd_mq_api
	@test -d deb/root/etc || mkdir -m 0755 deb/root/etc
	sed 's:/dev/stdout:/var/log/cbsd_mq_api/cbsd_mq_api.log:g' etc/cbsd-mq-api.json > deb/root/etc/cbsd-mq-api.json
	sed 's:%%VER%%:${APP_VER}:g' deb/root/DEBIAN/control_tpl > deb/root/DEBIAN/control
	make -C deb
	mv deb/*.deb .
	make -C deb clean

