#!/usr/bin/env bash

systemctl daemon-reload
service php5.6-fpm restart
service php7.2-fpm restart
service nginx restart
