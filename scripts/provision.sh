#!/bin/bash
set -e
BASEDIR=$(dirname "$0")
source $BASEDIR/common.sh

bold "Validating Environment..."
echo ""

enforce_arg "KONG_GATEWAY" "The full URL to the Kong gateway"
enforce_arg "KONG_USER" "The Kong admin username"
enforce_arg "KONG_PASSWORD" "The Kong admin password"
enforce_arg "CONTACT_EMAIL" "The email address to register the LetsEncrypt certificate"
enforce_arg "FQDN" "The FQDN to generate certificates for" 

bold "Generating LetsEncrypt certificates for $FQDN..."
echo ""

source config
mkdir -p $CERTDIR
mkdir -p $ACCOUNTDIR
mkdir -p $CHAINCACHE

dehydrated --register --accept-terms
dehydrated -d $FQDN -c 

bold "Uploading certificates to $KONG_GATEWAY..."
echo ""

curl -i -X POST $KONG_GATEWAY/certificates \
	-F "cert=@/app/data/certs/$FQDN/fullchain.pem" \
	-F "key=@/app/data/certs/$FQDN/privkey.pem" \
	-F "snis=$FQDN"
