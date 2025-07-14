import boto3
import os
import json

ec2 = boto3.client('ec2')
elbv2 = boto3.client('elbv2')

INSTANCE_IDS = os.environ['INSTANCE_IDS'].split(',')
TARGET_GROUP_ARN = os.environ['TARGET_GROUP_ARN']

def lambda_handler(event, context):
    action = event.get("action")

    # Define scale groups
    always_on = INSTANCE_IDS[:3]
    scale_group = INSTANCE_IDS[3:]

    if action == "scale_out":
        print("Scaling out: Starting scale_group instances.")
        ec2.start_instances(InstanceIds=scale_group)

        # Register to Target Group
        for instance_id in scale_group:
            elbv2.register_targets(
                TargetGroupArn=TARGET_GROUP_ARN,
                Targets=[{"Id": instance_id, "Port": 80}]
            )
        return {"status": "scaled_out"}

    elif action == "scale_in":
        print("Scaling in: Stopping scale_group instances.")
        ec2.stop_instances(InstanceIds=scale_group)

        # Deregister from Target Group
        for instance_id in scale_group:
            elbv2.deregister_targets(
                TargetGroupArn=TARGET_GROUP_ARN,
                Targets=[{"Id": instance_id}]
            )
        return {"status": "scaled_in"}

    else:
        return {"status": "unknown_action", "input": event}
