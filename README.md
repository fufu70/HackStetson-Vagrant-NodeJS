##WubbaLubbadubdub!!!

###Setting up vagrant

So your trying to setup a basic NodeJS environment for your team mates but its taking too much time, TIME TO SETUP VAGRANT!

First download [Vagrant](https://www.vagrantup.com/downloads.html) and [Virtual Box](https://www.virtualbox.org/wiki/Downloads)

Now that we have installed our dependencies lets start setting up vagrant

First lets type in the  in your console: 

> $ vagrant init 

Now lets setup the Vagrantfile to install a basic virtual box:

```
Vagrant.configure(2) do |config|

	config.vm.box = "precise32"

	config.vm.box_url = "http://files.vagrantup.com/precise32.box"
	
end
```


Once we setup the specific box to be used we can then start vagrant to install the box:

> $ vagrant up

While the box is installing we can setup a user and password for the box and a working directory both locally and on the server in the Vagrantfile:

```
Vagrant.configure(2) do |config|

	config.vm.box = "precise32"

	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	config.ssh.username = "vagrant"
	config.ssh.password = "vagrant"

	config.vm.synced_folder "node/", "/var/www/node"
	
end
```
---

### Building your Shell script

After the vagrant box is setup and a working directory we need to setup the NodeJS environment on the server. We will be doing this through a basic shell script.

Firstly we need to create a shell script, I called mine "script.sh". My command is to firstly update the box:

```shell
#!/bin/bash
sudo apt-get -y update 
```

Then we want to install apache:

```shell
sudo apt-get -y install nodejs
```

After that all we want is to start the node server on vagrant up

```shell
node /var/www/node/httpserver.js
````

After all of that is done your "setup.sh" file should look like this:

```shell
#!/bin/bash

# Updating Box

sudo apt-get -y update

# Installing nodejs
sudo apt-get -y install nodejs
```


Once we've added all of that to the "setup.sh" file we go into the Vagrantfile to define the startup script for our NodeJS environment:

```
Vagrant.configure(2) do |config|

	config.vm.box = "precise32"

	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# Mentioning the SSH Username/Password:
	config.ssh.username = "vagrant"
	config.ssh.password = "vagrant"

	config.vm.synced_folder "node/", "/var/www/node"

	config.vm.define "node" do|node|
		node.vm.hostname = "node" # Setting up hostname
		node.vm.network "private_network", ip: "192.168.205.11" # Setting up machine's IP Address
		node.vm.provision :shell, path: "setup.sh" # Provisioning with script.sh
	end

	# End Configuring
end
```
---

After all of this is finished we can then simply run

> $ vagrant reload --provision

to apply our changes to the vagrant server

---

##Starting Node Server

Since your done provisioning the vagrant server all we need to do now is ssh into the machine and start up our node server.

> $ vagrant ssh

> $ cd /var/www/node

> $ node httpserver.js

The server should then prompt you that it is listening on port 8080, sooooo simply go into your browser and enter 192.168.205.11:8080

---

Once your done with your vagrant box turn it off by running 

> $ vagrant halt

Or completly wipeout your box to start fresh by calling 

> $ vagrant destroy
