# Please prepare your own domain
domain="hkrevolution.ddns.net"

# create ssl cert
gcloud beta compute ssl-certificates create ssl-web \
    --description="for demo" \
    --domains=$domain \
    --global

# create a target HTTPs proxy to route request to URL map
gcloud compute target-https-proxies create https-lb-proxy \
    --ssl-certificates=ssl-web \
    --url-map web-map

# create a global forwarding rule to handle and route incoming requests
gcloud compute forwarding-rules create https-content-rule \
        --global \
        --target-https-proxy https-lb-proxy \
        --ports 80

# show the forwarding rule
echo "Here are all the forwarding rule"
gcloud compute forwarding-rules list