#!/usr/bin/env bash

systemctl daemon-reload
service php5-fpm restart
service nginx restart
service varnish restart
