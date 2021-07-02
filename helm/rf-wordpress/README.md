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

Go to your web browser and access `localhost:8080`

Configure necessary details

<img width="1669" alt="Screen Shot 2021-07-02 at 11 28 03 AM" src="https://user-images.githubusercontent.com/54875593/124216645-4f915a00-db29-11eb-9fd8-bd0e00764b36.png">

Change directory to `../helm`, Install phpmyadmin to update site url and other fields required.

```bash
helm install phpmyadmin phpmyadmin --set config.PMA_HOST=<WORDPRESS_DB> --set config.PMA_USER=<WORDPRESS_USER> --set config.PMA_PASSWORD=<WORDPRESS_PASSWORD>
```

port-forward to phpmyadmin pod.

```bash
kubectl port-forward phpmyadmin-xxxxx 8080:80
```

![Screen Shot 2021-07-02 at 11 44 13 AM](https://user-images.githubusercontent.com/54875593/124217688-5ae58500-db2b-11eb-89c0-d79a0aa44b8f.png)

![Screen Shot 2021-07-02 at 11 44 13 AM](https://user-images.githubusercontent.com/54875593/124218024-fd056d00-db2b-11eb-8944-0a1966d1cfa8.png)
![Screen Shot 2021-07-02 at 11 51 58 AM](https://user-images.githubusercontent.com/54875593/124218035-0098f400-db2c-11eb-9daf-205ad1e5d51c.png)

## Access website

![Screen Shot 2021-07-01 at 8 04 49 PM](https://user-images.githubusercontent.com/54875593/124218107-2625fd80-db2c-11eb-9faf-997bff4376dd.png)


## Clean up

Delete Helm Charts

```bash
$ helm list

NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION     
phpmyadmin      rabbit-app      3               2021-07-02 10:39:15.13188 +0800 PST     deployed        phpmyadmin-0.1.0        latest          
rf-wordpress    rabbit-app      1               2021-07-02 11:25:38.019873 +0800 PST    deployed        rf-wordpress-0.1.0      5.7.1-fpm-alpine

$ helm delete phpmyadmin
$ helm delete rf-wordpress


