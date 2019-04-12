
Steps:

1. Create an API token for your digital ocean account.

2. Create an ssh key for the droplet

3. Run the script with the -p (path)' and -a (action) arguments':
./run_tf.sh -p </path/to/your/ssh_keys> -a <terraform_action: init/plan/apply/destroy>


When ready you can connect with ssh (droplet IP is printed as output to termial):
ssh -i </path/to/your/id_rsa> root@<droplet-public-ip>


Note:
Make sure you take the relevant CPU and RAM for your needs - List of all digital ocean and the cost of droplets:
https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/
