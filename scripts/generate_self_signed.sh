#!/bin/bash
source $BASEDIR/common.sh

mkdir -p /app/data/certs/$FQDN
cd /app/data/certs/$FQDN

bold "Generating self signed certificate for $FQDN"
openssl req \
	-new \
	-newkey rsa:2048 \
	-days 90 \
	-nodes \
	-x509 \
	-subj "/C=UK/ST=SelfSigned/L=UK/O=SelfSigned/CN=$FQDN" \
	-keyout privkey.pem \
	-out fullchain.pem
