#!/bin/bash
cd /etc/openvpn/
rm -rf pki
/usr/share/easy-rsa/3.0.8/easyrsa init-pki
echo 'rasvpn' | /usr/share/easy-rsa/3.0.8/easyrsa build-ca nopass
echo 'rasvpn' | /usr/share/easy-rsa/3.0.8/easyrsa gen-req server nopass
echo 'yes' | /usr/share/easy-rsa/3.0.8/easyrsa sign-req server server
/usr/share/easy-rsa/3.0.8/easyrsa gen-dh
openvpn --genkey --secret ta.key
echo 'client' | /usr/share/easy-rsa/3/easyrsa gen-req client nopass
echo 'yes' | /usr/share/easy-rsa/3/easyrsa sign-req client client
echo 'iroute 10.2.2.0 255.255.255.0' > /etc/openvpn/client/client 