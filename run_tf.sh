#!/bin/bash


get_SSH_fingerprint(){
    local __postfix=id_rsa.pub
    ssh-keygen -E md5 -lf $SSH_PATH_ARG/$__postfix | awk '{print $2}'
}


user=$(whoami)


while getopts p:a: option
do
 case "${option}"
 in
 p) SSH_PATH_ARG=${OPTARG};;
 a) ACTION_ARG=${OPTARG};;
 esac
done


SSH_FINGERPRINT="$(get_SSH_fingerprint)"

##Remove "MD5: prefix (start from char 4)"
SSH_FINGERPRINT_NO_MD5_PREFIX=${SSH_FINGERPRINT:4}

echo "Performing action with terraform..."
echo "please make sure you've added: export DO_PAT={YOUR_PERSONAL_ACCESS_TOKEN} .."

sleep 3

##echo $SSH_FINGERPRINT


terraform $ACTION_ARG \
    -var do_token=${DO_PAT} \
    -var pub_key=$SSH_PATH_ARG/id_rsa.pub \
    -var pvt_key=$SSH_PATH_ARG/id_rsa \
    -var ssh_fingerprint=$SSH_FINGERPRINT_NO_MD5_PREFIX
