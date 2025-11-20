[
  {
    "name": "${container_name}",
    "image": "${image_url}",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 5000
      }
    ]
  }
]
