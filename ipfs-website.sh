#!/bin/bash

echo 'ipfs-website!!!!'

# init & config ipfs <-- this needs to be done via supervisord
#ipfs init
#ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
#ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080

# exit if PIN env var was not set
if [ -z ${PIN} ]; then
    echo "Did not see a PIN environment variable. Exiting."
    exit 1
else

    echo "Saw a PIN environment variable. Pinning hash ${PIN} and starting IPFS."
    ipfs pin add ${PIN}

    # bork if there was an error
    if [ $? -ne 0 ]; then
	echo "There was an error pinning $PIN"
	exit 1
    fi
fi
