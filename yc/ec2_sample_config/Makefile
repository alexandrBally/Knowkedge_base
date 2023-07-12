yc compute instance create \
  --name gpu-instance \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts-gpu,size=50 \
	--metadata-from-file user-data=/Users/aleksandrelefteriadi/Desktop/DevOps/Knowkedge_base/yc/ec2_sample_config/install.sh \
  --metadata ssh-keys=my-key.pub
	# --ssh-key ~/.ssh/id_rsa.pub
