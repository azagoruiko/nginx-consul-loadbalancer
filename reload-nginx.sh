#!/usr/bin/env bash

/usr/sbin/nginx -s reload

if [ $? -ne 0 ]; then
    echo "reload failed"
else
    echo "reload success"
fi
exit 0
