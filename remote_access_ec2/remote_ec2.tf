terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
    }
  }
}

resource "null_resource" "docker_on_existing_ec2" {     // Define a null resource to run commands on an existing EC2 instance   
  provisioner "remote-exec" {       // Use remote-exec to run commands on the EC2 instance
    inline = [  
        // docker already installed, so we just pull and run the container
      "sudo docker pull httpd:latest",  // Pull the latest HTTPD image
      "sudo docker run -d -p 8098:80 httpd:latest" // Run the HTTPD container in detached mode, mapping port 8098 on the host to port 80 in the container
    ]

    connection {
      type        = "ssh"      // Use SSH to connect to the EC2 instance
      user        = "ubuntu"        // Replace with your EC2 instance's username
      host        = "40.192.18.233" // Replace with your EC2 instance's public IP or DNS
      private_key = file("~/.ssh/3july.pem") // Path to your private key file
    }
  }
}

