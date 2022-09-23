# Enable auto snapshots on aws lightsail
aws lightsail enable-add-on --region us-east-1 --resource-name WordPress-1 --add-on-request addOnType=AutoSnapshot,autoSnapshotAddOnRequest={snapshotTimeOfDay=18:00}

# Disable auto snapshots on aws lightsail
aws lightsail disable-add-on --region us-east-1 --resource-name WordPress-1 --add-on-type AutoSnapshot

