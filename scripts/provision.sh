#!/bin/bash
set +e
export BASEDIR=$(dirname "$0")
source $BASEDIR/common.sh

bold "Validating Environment..."
echo ""

enforce_arg "CONTACT_EMAIL" "The email address to register the LetsEncrypt certificate"
enforce_arg "FQDN" "The FQDN to generate certificates for" 

$BASEDIR/generate_le.sh 
if [ $? -ne 0 ]; then
	bold "LetsEncrypt generation failed!  Will generate a Self Signed certificate instead..."
	$BASEDIR/generate_self_signed.sh
fi

bold "Uploading certificates to secret..."
kubectl create secret tls --dry-run ingress-tls --key /app/data/certs/$FQDN/privkey.pem --cert /app/data/certs/$FQDN/fullchain.pem -o yaml | kubectl apply -f -

bold "All done!"
