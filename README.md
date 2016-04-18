# Gettings Started

FUSE in docker requires extra privledges:
* ```--cap-add SYS_ADMIN```
* ```--device /dev/fuse```

Environment Variable Options:
* ```GCS_KEYFILE```
* ```fsdf```


```bash
docker run ... --device /dev/fuse gcsfuse --cap-add SYS_ADMIN IMAGE BUCKET_NAME
```
