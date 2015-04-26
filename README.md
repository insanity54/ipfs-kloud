# ipfs-website
Serve a static website using IPFS

## Indended workflow

*On your local computer*

* make a static html site
* set up an ipfs node
* add your static site to ipfs

*On your cloud server*

    docker run -d --name ipfs -e PIN=QmZfqVvnqesSyFosEAQPZBcfeepfey5efkLZSwm3sySp36 insanity54/ipfs-website
    
Yay, now you have an IPFS hosted website, with your site's data servable from two places. On your local computer, and on your cloud server.
