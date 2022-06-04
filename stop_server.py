import boto3
import requests
import json

with open('meta_data.json') as file:
    data = json.load(file)

region=data['region']
instance_id=data['instance_id']
ec2_resource=boto3.resource('ec2',region_name=region)

webhook=data['webhook']

instance=ec2_resource.Instance(instance_id)

ip_address=instance.public_ip_address

instance.stop()

print(f'Stopping EC2 instance: {instance.id}')
    
instance.wait_until_stopped()

print(f'EC2 instance "{instance.id}" has been stopped')

message=f'Masters, Vrising server ({instance.id}) with ip-{ip_address} has stopped.'

data = {
    "content" : message,
    
    "username" : "VServant"
    
}


result = requests.post(webhook, json = data)

try:
    result.raise_for_status()
except requests.exceptions.HTTPError as err:
    print(err)