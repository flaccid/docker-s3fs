# docker-s3fs

## Run

```
docker run -it \
  -e AWSACCESSKEYID=abc \
  -e AWSSECRETACCESSKEY=xyz \
  --device=/dev/fuse \
  --cap-add SYS_ADMIN \
    flaccid/s3fs my-bucket /mnt
```

## Build

    $ make

## Push to Docker Hub

    $ make push
