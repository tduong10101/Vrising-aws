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

instance.start()

print(f'Starting EC2 instance: {instance.id}')
    
instance.wait_until_running()

print(f'EC2 instance "{instance.id}" has been started')

message=f'Masters, Vrising server has started and the new IP Address is {instance.public_ip_address}'

data = {
    "content" : message,
    
    "username" : "VServant"
    
}


result = requests.post(webhook, json = data)

try:
    result.raise_for_status()
except requests.exceptions.HTTPError as err:
    print(err)