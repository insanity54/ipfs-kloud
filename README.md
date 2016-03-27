# ipfs-website
Serve a static website using IPFS

## Intended workflow

*On your local computer*

* make a static html site
* set up an ipfs node
* add your static site to ipfs

*On your cloud server*

    docker run -d --name ipfs -e PIN=QmZfqVvnqesSyFosEAQPZBcfeepfey5efkLZSwm3sySp36 insanity54/ipfs-website
    
Note the environment variable `PIN` sent to the container with `-e`. The value is an IPFS hash of the website you want to serve.
    
Yay, now you have an IPFS hosted website, with your site's data servable from two places. On your local computer, and on your cloud server.

## DNS Stuff

For most current info, see the ipfs website ipfs.io This is how you can get IPFS to serve a specific hash.

Add a DNS TXT record to your domain which contains the IPFS hash you want it to serve. IPFS is deprecating the first method, so do them both for compatibility with present and future versions.

present way

    "QmZfqVvnqesSyFosEAQPZBcfeepfey5efkLZSwm3sySp36"

future way

    "dnslink=/ipfs/QmZfqVvnqesSyFosEAQPZBcfeepfey5efkLZSwm3sySp36"

## Performance stuff

Thanks to headbite on the freenode #ipfs IRC for this one. You can swarm connect your local computer to your cloud server to get better load times. Do this on your local computer using a command like the following--

    ipfs swarm connect /ip4/x.x.x.x/tcp/4001/ipfs/QmW3ssBgGLANKNKXiRxcQMmxg3FPd3tSwu2Dt96DBLbjBZ

where x.x.x.x is the IP address of your cloud server.