import boto3

ec2_instance = boto3.client('ec2')

def start_ec2_instance():
   ec2_instance.start_instances()

def stop_ec2_instance():
   ec2_instance.stop_instances()