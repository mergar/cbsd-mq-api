all: deb

fetch:
	wget https://cbsd-mq-api.tar.xz

deb:
	dpkg-deb -b root .

clean:
	@rm -f *.xz *.deb
	@rm -f root/usr/local/sbin/cbsd-mq-api
	@mkdir -p root/usr/local/sbin
	@rm -f root/DEBIAN/control
	@rm -rf root/etc root/lib root/usr root/var

.PHONY: deb
