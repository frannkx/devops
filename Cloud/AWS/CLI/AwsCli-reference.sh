#AWS Cloudwatch get Metrics Statistics

aws cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2014-04-08T23:18:00Z --end-time 2014-04-09T23:18:00Z --period 3600 --namespace AWS/EC2 --statistics Maximum --dimensions Name=InstanceId,Value=i-04ca5cd53c57c26fc



aws cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2022-03-01T23:18:00Z --end-time 2022-06-021T23:18:00Z --period 3600 --namespace AWS/EC2 --statistics Maximum --dimensions Name=InstanceId,Value=i-04ca5cd53c57c26fc

aws cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2022-01-03T23:00:00Z --end-time 2022-21-06T23:00:00Z --period 3600 --namespace AWS/EC2 --statistics Maximum --dimensions Name=InstanceId,Value=i-04ca5cd53c57c26fc

aws cloudwatch get-metric-statistics --metric-name CPUUtilization --start-time 2022-06-08T23:18:00Z --end-time 2022-06-09T23:18:00Z --period 3600 --namespace AWS/EC2 --statistics Maximum --dimensions Name=InstanceId,Value=i-04ca5cd53c57c26fc

https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/get-metric-statistics.html

https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/mon-scripts.html
