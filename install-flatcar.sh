#!/bin/sh

apt-get install --no-install-recommends -y gawk
curl -fsSLO --retry-delay 1 --retry 60 --retry-connrefused --retry-max-time 60 --connect-timeout 20 https://raw.githubusercontent.com/flatcar/init/flatcar-master/bin/flatcar-install
chmod 0755 flatcar-install
./flatcar-install -d /dev/sda -V "$FLATCAR_VERSION" -C "$FLATCAR_CHANNEL" -o hetzner
