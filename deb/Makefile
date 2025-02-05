all: deb

fetch:
	wget https://cbsd-mq-api.tar.xz

deb:
	dpkg-deb -b root .

clean:
	@rm -f *.xz *.deb
	@rm -f root/DEBIAN/control
	@rm -rf root/etc root/lib root/usr root/var

.PHONY: deb
