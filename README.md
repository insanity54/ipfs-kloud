# ipfs-kloud
Host IPFS content on your infrastructure in an optionally redundant way, with an Ansible playbook for deployment and maintenance.

*UNSTABLE PROJECT* I could not get `ipfs pin` to be called by ansible reliably. It seems to require more RAM than I have available on any of my budget VPS

## Intended workflow (Summary)

Add the IPFS multihashes you would like to host (ipfs pin) to the `multihashes` dictionary in the file, `vars/public.yml`

Two Ansible tasks are made available via playbook tags, `deploy`, and `update`. Deployment installs everything you need to turn a fresh Ubuntu<sup>1</sup> VPS into an ipfs-kloud server, while update makes sure that all your IPFS nodes are pinning your latest list of IPFS multihashes.

```
$ ansible-playbook -i ~/.ansible-inventory -t deploy main.yml
$ ansible-playbook -i ~/.ansible-inventory -t update main.yml
```

## Workflow Detail

[Ansible](https://docs.ansible.com/ansible/intro_installation.html) is an amazing tool for deployment/operations/managment of web services. Using Ansible, you can be at your laptop, and run a "playbook" which can make changes on up to thousands of your servers. Ansible does not require "agent" software on each of these servers. Instead, it runs remote commands using SSH. Check out the official [Ansible](https://ansible.com/) website for more details.

If you're new to Ansible, you'll need an inventory file. This is the file that tracks your inventory of servers. I put mine at `~/.ansible-inventory`, but some people like making a new inventory file relative each project. Mine looks like this-

```
[monitoring]
foxxy
twobee


[kloud]
foxxy
twobee
worlds


[teamspeak]
foxxy


foxxy ansible_ssh_host=xxx.xxx.xxx.xxx
twobee ansible_ssh_host=xxx.xxx.xxx.xxx
worlds ansible_ssh_host=xxx.xxx.xxx.xxx
```

You can see I have three projects. `monitoring`, `kloud`, and `teamspeak`. Then I have three servers, `foxxy`, `twobee`, and `worlds`. This inventory file tells Ansible that I want the monitoring project to run on foxxy & twobee, the kloud project should run on foxxy/twobee/worlds, and the teamspeak project should run on foxxy.

For more on inventory, check out the official [ansible docs](https://docs.ansible.com/ansible/intro_inventory.html) on the subject.

When you get started with ipfs-kloud, it needs to be deployed to your servers. To do this, we use the `ansible-playbook` command, telling ansible to carry out the tasks which have been tagged with the tag, `deploy` (-t). Ansible also needs to know about our inventory of servers (-i). Finally, Ansible needs to know what playbook we want it to run.

```
ansible-playbook -t deploy -i ~/.ansible-inventory ./main.yml
```



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

## Footnotes

<sup>1</sup> I'm only familiar with Ubuntu so that's what I tested against, but you're welcome to submit PRs for more distros!
