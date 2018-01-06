#!/bin/bash
source $BASEDIR/common.sh

bold "Generating LetsEncrypt certificates for $FQDN..."
echo ""

source config
mkdir -p $CERTDIR
mkdir -p $ACCOUNTDIR
mkdir -p $CHAINCACHE

dehydrated --register --accept-terms
dehydrated -d $FQDN -c
