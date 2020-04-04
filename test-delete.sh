# get the first instance
instance_name=$(gcloud compute instances list --limit 1 | sed -n '2p' | head -n1 | awk '{print $1;}')

# delete the first instance
gcloud compute instances delete $instance_name -q