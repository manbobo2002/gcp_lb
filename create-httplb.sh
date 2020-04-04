# create health check
gcloud compute http-health-checks create http-basic-check

# map a port name to relevant port for instance group
gcloud compute instance-groups managed \
       set-named-ports nginx-group \
       --named-ports http:80

# create backend-service which contains configuration values for Google Cloud Platform load balancing services
gcloud compute backend-services create nginx-backend \
      --protocol HTTP --http-health-checks http-basic-check --global

# add the instance group into the backend service
gcloud compute backend-services add-backend nginx-backend \
    --instance-group nginx-group \
    --instance-group-zone us-central1-a \
    --global

# create default URL map which directs all incoming requests to our instances
gcloud compute url-maps create web-map \
    --default-service nginx-backend

# create a target HTTP proxy to route request to URL map
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map

# create a global forwarding rule to handle and route incoming requests
gcloud compute forwarding-rules create http-content-rule \
        --global \
        --target-http-proxy http-lb-proxy \
        --ports 80

# show the forwarding rule
echo "Here are all the forwarding rule"
gcloud compute forwarding-rules list
