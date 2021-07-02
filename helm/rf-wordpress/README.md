# RF-WORDPRESS

## TL;DR
```bash
$ helm install my-release . 
```

## Task Description 

As a DevOps, you’re deploying a PHP application to a Kubernetes cluster running on a public cloud provider. 

Application: WordPress 5.7.2. 


## Requirements 
- Write Kubernetes manifests or Helm charts to run the application on Kubernetes with high availability support. 
    - By default the application is stateful and requires storage. Your implementation should handle this. 
    - Run the database required by the application on Kubernetes. 
    - make the application available over HTTPS. 
- Document your work so other engineers can understand and maintain it. 
