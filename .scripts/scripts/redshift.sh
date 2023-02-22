#!/usr/bin/env bash

set -eu

if [[ -z ${LAT-} || -z ${LON-} ]]; then
	location=$(curl --silent --show-error --fail --ipv4 "https://location.services.mozilla.com/v1/geolocate?key=geoclue")
	LAT=$(jq -r .location.lat <<<"$location")
	LON=$(jq -r .location.lng <<<"$location")
fi

redshift -l $LAT:$LON -t 6500:3500 -g 1.0 -m randr -v
