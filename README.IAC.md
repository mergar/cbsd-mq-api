# CBSD RESTFull API

1)
cbsd module mode=install puppet
echo 'puppet.d' >> ~cbsd/etc/modules.conf
cbsd initenv

2)
cbsd jcreate jname=cbsdpuppet1 jprofile=cbsdpuppet astart=0

3)
cp -a cbsd-mq-api-apply /usr/local/bin/
