#amazon web service command line interface

aws configure set default.region us-west-2 # oregon
aws configure set default.region ap-southeast-1  # singapuro

#aws
#IAM
# get my user data
aws iam get-user

# get list user
aws iam list-users

# list access key dari aplikasi
aws iam list-access-keys


#EC2
# Instance Limit
#user ec2 info + instance limit
#full output
aws ec2 describe-account-attributes
aws ec2 describe-account-attributes --output json
aws ec2 describe-account-attributes --output table

# instance limit handy table format
attributes="max-instances max-elastic-ips vpc-max-elastic-ips"
aws ec2 describe-account-attributes --region us-west-2 --attribute-names $attributes --output table --query 'AccountAttributes[*].[AttributeName,AttributeValues[0].AttributeValue]'

# instance limit vary by region
regions=$(aws ec2 describe-regions --output text --query 'Regions[*].RegionName')
attributes="max-instances max-elastic-ips vpc-max-elastic-ips"
for region in $regions; do
  echo; echo "region=$region"
  aws ec2 describe-account-attributes --region $region --attribute-names $attributes --output text --query 'AccountAttributes[*].[AttributeName,AttributeValues[0].AttributeValue]' |
    tr '\t' '=' | sort
done

# Key Pair
# list key pair
aws ec2 describe-key-pairs
aws ec2 describe-key-pairs --region us-west-2
aws ec2 describe-key-pairs --key-name richasdyaws

# create key pair
aws ec2 create-key-pair --key-name richasdyaws

# delete key pair
aws ec2 delete-key-pair --key-name richasdyaws

# Instance Option
ami defined by region
ami-6b8cef13 --> oregon, amazon linux ami 
ami-4e79ed36 --> oregon, ubuntu 16.04
ami-5c97f024 --> oregon, ubuntu 16.04
ami-e4ceeb98 --> singapore, ubuntu 16.04 --> non virtualization
ami-82c9ecfe --> singapore, ubuntu 16.04 --> virtualization
ami-ca89eeb2 --> oregon, ubuntu 16.04 --> virtualization

# list instance
aws ec2 describe-instances
aws ec2 describe-instances --region us-west-2 # oregon
aws ec2 describe-instances --region us-west-2 --output json
aws ec2 describe-instances --region us-west-2 --output text
aws ec2 describe-instances --region us-west-2 --output table
aws ec2 describe-instances --region ap-southeast-1 # singapore

# list instance in all region 
for region in `aws ec2 describe-regions --output text | cut -f3`
do
     echo -e "\nListing Instances in region:'$region'..."
     aws ec2 describe-instances --region $region
done

# list security group
aws ec2 describe-security-groups
aws ec2 describe-security-groups --region us-west-2

# run instance ubuntu 16.04 oregon
aws ec2 run-instances \
--image-id ami-ca89eeb2 \
--instance-type t2.nano \
--key-name richasdyawsideapad

aws ec2 stop-instances --instance-ids i-0c5b87332e00cdc9e
aws ec2 terminate-instances --instance-ids i-0c5b87332e00cdc9e

aws ec2 run-instances \
--image-id ami-4e79ed36 \
--count 1 \
--instance-type t2.nano \
--key-name richasdyawsideapad \
--security-group-ids XXXX \

# Spot Instance
aws ec2 request-spot-instances \
--block-duration-minutes 60 \
--spot-price "0.03" \
--instance-type t2.nano \
--type "one-time" \
--instance-count 1 \
--launch-specification file://aws-spot-instance-specification.json

# Spot Instance
aws ec2 request-spot-instances \
--block-duration-minutes 60 \
--spot-price "0.03" \
--launch-specification file://aws-spot-instance-specification.json


