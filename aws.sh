#amazon web service command line interface
#aws

#user ec2 info + instance limit
#full output
aws ec2 describe-account-attributes

#handy table format
attributes="max-instances max-elastic-ips vpc-max-elastic-ips"
aws ec2 describe-account-attributes --region us-west-2 --attribute-names $attributes --output table --query 'AccountAttributes[*].[AttributeName,AttributeValues[0].AttributeValue]'

#limit vary by region
regions=$(aws ec2 describe-regions --output text --query 'Regions[*].RegionName')
attributes="max-instances max-elastic-ips vpc-max-elastic-ips"
for region in $regions; do
  echo; echo "region=$region"
  aws ec2 describe-account-attributes --region $region --attribute-names $attributes --output text --query 'AccountAttributes[*].[AttributeName,AttributeValues[0].AttributeValue]' |
    tr '\t' '=' | sort
done

