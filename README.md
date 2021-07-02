# Wordpress Bootstrap

## Idea

The idea of this is to provide a way to build docker images that contain a wordpress setup that is configured by composer.

## Free Plugins and Themes

Using composer you add plugins and themes using the wpackagist service. This allows fetching plugins from wordpress svn using composer.

## Custom/Paid Plugins and Themes

These would need to be stored in the repo, they should not be possible to change on the site itself. 

If changes are required then they must be done in repo and the site rebuilt.

These plugins or themes should be stored in the `wp-content/plugins` and `wp-content/themes` folders. They need to also be excluded from the gitignore so they are stored in git.

## Dockerfile

The dockerfile is multi stage and setup to first fetch all the plugins/themes using composer and then copy the wordpress to a wordpress docker image that will copy the rest of wordpress into place.


## Create kubernetes cluster

```bash
eksctl create cluster -f eksctl/cluster.yaml 
```

## Checklist

- [x] cert-manager
- [x] nginx sidecar/ingress controller
- [x] mariadb
- [x] wordpress-app
- [x] phpmyadmin

## Screenshot 

![Screen Shot 2021-07-01 at 8 04 49 PM](https://user-images.githubusercontent.com/54875593/124129930-d5bd8a00-dab0-11eb-81d6-45489a916ecd.png)