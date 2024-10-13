import boto3

ec2_instance = boto3.resources('lambda')

def start_ec2_instance():
    response = ec2_instance.create_instances(
        ImageId='ami-0abcdef1234567890',
        MinCount=1,
        MaxCount=1,
        InstanceType='t2.micro',
        KeyName='my-key-pair',
        SecurityGroupIds=['sg-0abcdef1234567890']
    )
    return response[0].id
