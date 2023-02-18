#!/bin/bash
sudo yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
sudo yum-builddep -y rpmbuild/SPECS/nginx.spec

