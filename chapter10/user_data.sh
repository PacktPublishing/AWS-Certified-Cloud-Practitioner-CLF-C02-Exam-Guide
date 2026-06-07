#!/bin/bash
# Update the system
sudo dnf update -y

# Install Apache
sudo dnf install -y httpd

# Install PHP and required extensions
sudo dnf install -y php php-cli php-common php-mysqlnd php-pdo php-gd php-mbstring php-xml php-opcache php-bcmath php-json

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Install AWS CLI (if not already installed)
sudo dnf install -y awscli

# Clear existing content in /var/www/html (optional)
sudo rm -rf /var/www/html/*

# Pull application code from S3 (replace <YOUR_BUCKET_NAME> and <YOUR_APP_FOLDER_OR_FILE> accordingly)
aws s3 cp s3://[YOUR S3 App Source Code Bucket]/bellybrew /var/www/html/ --recursive

# Adjust permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
