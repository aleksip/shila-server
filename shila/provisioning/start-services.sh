#!/usr/bin/env bash

systemctl daemon-reload
service php7.0-fpm restart
service nginx restart
service varnish restart
