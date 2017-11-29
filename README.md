# Kong LetsEncrypt SSL Generation
The purpose of this repository is to generate LetsEncrypt certificates using [dehydrated](https://github.com/lukas2511/dehydrated) and then post the updated certificate to a [Kong](https://getkong.org/) api gateway.

You could quite easily fork this and [change this part](scripts/provision.sh#29) of the script to send the certificates to something other than Kong, like some shared storage your NGINX server uses, or a Kubernetes secret used on ingress termination.

## Use
You need to specify the following environment variables when running the container:

  - KONG_GATEWAY
  - KONG_USER
  - KONG_PASSWORD
  - CONTACT_EMAIL
  - FQDN

From there, do run locally, just do `docker-compose run --rm letsencrypt`.

## Use on Kubernetes
As LetsEncrypt certs need periodically updating, you could run this container as a scheduled job.  The following example would run this image once per month.

```
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "0 0 1 * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: letsencypt
            image: eu.gcr.io/your-project/your-image-name
```
