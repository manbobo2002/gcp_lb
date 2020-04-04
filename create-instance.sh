# create an instance template
gcloud compute instance-templates create nginx-template \
         --metadata-from-file startup-script=startup.sh

# create a target pool
gcloud compute target-pools create nginx-pool

# create a managed instance group using the template
gcloud compute instance-groups managed create nginx-group \
         --base-instance-name nginx \
         --size 2 \
         --template nginx-template \
         --target-pool nginx-pool

# show all the created instances
echo "Here are all the created instances"
gcloud compute instances list

# open port 80
gcloud compute firewall-rules create www-firewall --allow tcp:80