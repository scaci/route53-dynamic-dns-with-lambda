#!/bin/sh
[ -z "$domain" ]   && write_log 14 "Service section not configured correctly! Missing 'domain'"
[ -z "$username" ] && write_log 14 "Service section not configured correctly! Missing 'username'"
[ -z "$password" ] && write_log 14 "Service section not configured correctly! Missing 'password'"

__URL="PUT_YOUR_HTTPS_DDNS_URL"

UPDATE=$(/usr/sbin/aws-ddns --ip-version ipv6 --hostname $username.$domain --secret $password --api-key $param_opt --url $__URL --ip-source "public")

write_log 7 "${UPDATE}"

echo ${UPDATE} | grep failed >/dev/null && return 1
echo ${UPDATE} | grep succeeded >/dev/null && return 0
return 2
