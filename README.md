![logo](https://assets.supergood.work/logo.png)

# supergood-web
This is the source for [supergood.work](https://supergood.work). This site is built and deployed with [Middleman](https://middlemanapp.com/).

## Install
Install the necessary gems with bundler. To avoid messing up your dev environment you can do `bundle install --deployment` to install gems relative to this directory. If you don't care (you should care), omit the `--deployment`.

```bash
$ cd supergood-web
$ bundle install --deployment
```

## Build
Build and run locally like this:

```bash
# Build
$ bundle exec middleman build

# Serve. Server is listening on localhost:4567
$ bundle exec middleman
```

## Deploy
The site is deployed to an S3 bucket sitting behind Cloudflare. To deploy, you must have the appropriate credentials. Set the following environment variables:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `CLOUDFLARE_CLIENT_API_KEY`
* `CLOUDFLARE_EMAIL`

There is a convenience script to build and push:

```bash
$ cd supergood-web
$ ./deploy.sh
```
