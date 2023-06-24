#!/bin/bash

make-cadir /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
rm -rf pki
./easyrsa init-pki
echo 'rasvpn' | ./easyrsa build-ca nopass
echo 'rasvpn' | ./easyrsa gen-req server2 nopass
./easyrsa gen-dh
echo 'yes' | ./easyrsa sign-req server server2
cp pki/dh.pem pki/ca.crt pki/issued/server2.crt pki/private/server2.key /etc/openvpn/
echo 'myclient' | ./easyrsa gen-req myclient nopass
echo 'yes' | ./easyrsa sign-req client myclient
cp pki/issued/myclient.crt pki/private/myclient.key /etc/openvpn
cd ..
openvpn --genkey --secret ta.key
#echo 'iroute 10.2.2.0 255.255.255.0' > /etc/openvpn/client/client
touch /etc/openvpn/playbook2.done 