# create L4 load balancer
gcloud compute forwarding-rules create nginx-lb \
         --region us-central1 \
         --ports=80 \
         --target-pool nginx-pool

# show the forwarding rule
echo "Here are all the forwarding rule"
gcloud compute forwarding-rules list