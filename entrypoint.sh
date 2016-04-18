#!/bin/sh
set -e

if [ $# -eq 1 ] ; then
    GCSFUSE_FLAGS="--foreground"
    if [ -n "$GCSFUSE_USER" ]; then
        adduser $GCSFUSE_USER -D -H
    fi

    if [ -n "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
        if [ ! -f "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
            echo "File for GOOGLE_APPLICATION_CREDENTIALS does not exist: $GOOGLE_APPLICATION_CREDENTIALS";
            exit 1;
        fi
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --key-file $GOOGLE_APPLICATION_CREDENTIALS"
    fi

    mkdir -p $GCSFUSE_MOUNTPOINT
    chown $GCSFUSE_USER $GCSFUSE_MOUNTPOINT


    if [ -n "$GCSFUSE_DEBUG" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --debug_fuse --debug_gcs --debug_http --debug_invariants"
    else
        if [ -n "$GCSFUSE_DEBUG_FUSE" ]; then
            GCSFUSE_FLAGS="$GCSFUSE_FLAGS --debug_fuse"
        fi
        if [ -n "$GCSFUSE_DEBUG_GCS" ]; then
            GCSFUSE_FLAGS="$GCSFUSE_FLAGS --debug_gcs"
        fi
        if [ -n "$GCSFUSE_DEBUG_HTTP" ]; then
            GCSFUSE_FLAGS="$GCSFUSE_FLAGS --debug_http"
        fi
        if [ -n "$GCSFUSE_DEBUG_INVARIANTS" ]; then
            GCSFUSE_FLAGS="$GCSFUSE_FLAGS --debug_invariants"
        fi
    fi

    if [ -n "$GCSFUSE_TEMP_DIR" ]; then
        if [ ! -d "$GCSFUSE_TEMP_DIR" ]; then
            echo "Directory for GOOGLE_APPLICATION_CREDENTIALS does not exist: $GOOGLE_APPLICATION_CREDENTIALS";
            exit 1;
        fi
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --temp-dir $GCSFUSE_TEMP_DIR"
    fi

    if [ -n "$GCSFUSE_DIR_MODE" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --dir-mode $GCSFUSE_DIR_MODE"
    fi

    if [ -n "$GCSFUSE_file_MODE" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --file-mode $GCSFUSE_FILE_MODE"
    fi

    if [ -n "$GCSFUSE_LIMITS_BPS" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --limit-bytes-per-sec $GCSFUSE_LIMIT_BPS"
    fi

    if [ -n "$GCSFUSE_LIMITS_OPS" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --limit-ops-per-sec $GCSFUSE_LIMIT_OPS"
    fi

    if [ -n "$GCSFUSE_CACHE_STAT_TTL" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --stat-cache-ttl $GCSFUSE_CACHE_STAT_TTL"
    fi

    if [ -n "$GCSFUSE_CACHE_TYPE_TTL" ]; then
        GCSFUSE_FLAGS="$GCSFUSE_FLAGS --type-cache-ttl $GCSFUSE_CACHE_TYPE_TTL"
    fi

    # Not Supported
    #    -o [-o option -o option]	Additional system-specific mount options. Be careful!
    #    --uid "-1"			UID owner of all inodes.
    #    --gid "-1"			GID owner of all inodes.
    #    --implicit-dirs		Implicitly define directories based on content. Seedocs/semantics.md
    #    --only-dir 			Mount only the given directory, relative to the bucket root.

    gcsfuse $GCSFUSE_FLAGS $1 $GCSFUSE_MOUNTPOINT
fi

exec "$@"
