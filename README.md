# Gettings Started

FUSE in docker requires extra privledges:
* ```--cap-add SYS_ADMIN```
* ```--device /dev/fuse```

```bash
docker run ... --device /dev/fuse gcsfuse --cap-add SYS_ADMIN IMAGE BUCKET_NAME
```

# Environment Variable Options:
* ```GOOGLE_APPLICATION_CREDENTIALS```: ```key-file```
* ```GCSFUSE_USER```:
* ```GCSFUSE_MOUNTPOINT```:
* ```GCSFUSE_DEBUG```: Sets ```--debug_fuse --debug_gcs --debug_http --debug_invariants```
* ```GCSFUSE_DEBUG_FUSE```: ```--debug_fuse```
* ```GCSFUSE_DEBUG_GCS```: ```--debug_gcs```
* ```GCSFUSE_DEBUG_HTTP```: ```--debug_http```
* ```GCSFUSE_DEBUG_INVARIANTS```: ```--debug_invariants```
* ```GCSFUSE_DIR_MODE```: ```dir-mode```
* ```GCSFUSE_FILE_MODE```: ```file-mode```
* ```GCSFUSE_LIMIT_BPS```: ```limit-bytes-per-sec```
* ```GCSFUSE_LIMIT_OPS```: ```limit-ops-per-sec```
* ```GCSFUSE_CACHE_STAT_TTL```: ```stat-cache-ttl```
* ```GCSFUSE_CACHE_TYPE_TTL```: ```type-cache-ttl```
