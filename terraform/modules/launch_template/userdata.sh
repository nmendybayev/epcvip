#!/bin/bash

# Updating packages:
yum update -y

# Installing and start Apache HTTP Server:
yum install -y httpd
systemctl enable httpd
systemctl start httpd

# Creating a simple homepage:
echo "Hello, DevOps Test!" > /var/www/html/index.html

# Installing CloudWatch Agent:
yum install -y amazon-cloudwatch-agent

# Creating CloudWatch Agent configuration file with custom log group names:
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "agent": {
    "metrics_collection_interval": 60,
    "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
    "run_as_user": "root"
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/devops-test/ec2/system/messages",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%b %d %H:%M:%S"
          },
          {
            "file_path": "/var/log/httpd/access_log",
            "log_group_name": "/devops-test/ec2/httpd/access",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%d/%b/%Y:%H:%M:%S %z"
          },
          {
            "file_path": "/var/log/httpd/error_log",
            "log_group_name": "/devops-test/ec2/httpd/error",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%a %b %d %H:%M:%S.%f %Y"
          },
          {
            "file_path": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
            "log_group_name": "/devops-test/ec2/cloudwatch-agent",
            "log_stream_name": "{instance_id}"
          }
        ]
      }
    }
  }
}
EOF

# Starting CloudWatch Agent with the above config:
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s


yum install -y stress && sleep 180 && nohup stress --cpu 1 --io 1 --vm 1 --vm-bytes 64M --timeout 600 &

# # Uncomment this block when need to stress VMs to check scalability
# # Run 'terraform init' and 'terraform apply' to implement the code
# # Check CloudWatch CPU metrics to observe increasing load
# # Comment out this block after the successful implementation

# # Installing stress tool for load testing:
# yum install -y stress

# # Delaying stress start to allow instance to stabilize:
# sleep 180

# # Running stress tool in the background for 400 seconds (6.5 mins) to generate CPU load:
# nohup stress --cpu 2 --timeout 600 &


