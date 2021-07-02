# RF-WORDPRESS

## Task Description 

As a DevOps, you’re deploying a PHP application to a Kubernetes cluster running on a public cloud provider. 

Application: WordPress 5.7.2. 

## Requirements 
- Write Kubernetes manifests or Helm charts to run the application on Kubernetes with high availability support. 
    - By default the application is stateful and requires storage. Your implementation should handle this. 
    - Run the database required by the application on Kubernetes. 
    - make the application available over HTTPS. 
- Document your work so other engineers can understand and maintain it. 

## TL;DR
Change directory to `helm`
```bash
$ helm dep up
$ helm install my-release rf-wordpress
```
## Prerequisites Details
The chart has an optional dependency on the mariadb chart.

## Configuration

The following table lists the configurable parameters of the rf-wordpress chart and their default values.

Parameter | Description | Default
--- | --- | ---
`mysql.enabled` | enable mysql dependecy | `true`
`mysql.config.MYSQL_DATABASE` | initial db | `wp-database`
`mysql.config.MYSQL_ROOT_PASSWORD` | Root Password | `password`
`mysql.config.MYSQL_USER` | mysql user | `root`
`mysql.config.MYSQL_PASSWORD` | mysql password | `password1`
`wordpress.image.repository` | wordpress image | `tocinoatbprabbit-devops`  
`wordpress.image.pullPolicy` | image pull policy |  `Always`
`wordpress.image.tag` | wordpress image tag |  `"5.7.1-fpm-alpine"`
`wordpress.database.WORDPRESS_DB_HOST` | wordpress database host  | `""`
`wordpress.database.WORDPRESS_DB_NAME` | wordpress database | `""`
`wordpress.database.WORDPRESS_DB_USER` | wordpress database user | `""`
`wordpress.database.WORDPRESS_DB_PASSWORD` | wordpress database | `""`
`wordpress.database.WORDPRESS_CONFIG_EXTRA` |  Extra configs | `/* Multisite */  define('WP_ALLOW_MULTISITE', true );` |
`wordpress.config.WORDPRESS_TABLE_PREFIX`| DB prefix | `shop_`
`wordpress.config.WORDPRESS_DEBUG` | Enable Debug | `1`
`wordpress.service.type` | service type | `ClusterIP`
`wordpress.service.port` | service port | `9000`
`nginx.enabled` | enable nginx sidecar | `true` 
`nginx.enabled.ssl` | enable ssl | `false`
`nginx.enabled.service.port` | nginx port | `80`
`storage.storageClass.name` | Storage Class for RWX support | `""`
`storage.size` | Storage Size | `""`

## Manual Steps

When pods are ready, install wordpress app, access the app via port-forwarding to the nginx side car

```bash
kubectl port-forward <release name pod> nginx 8080:80
```

