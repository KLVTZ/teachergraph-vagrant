Teachergraph via Vagrant
====================

Vagrant is a lightweight, reproducible, portable environment that aims to mirror your production envirionment. Vagrant will change how you work. Say goodbye to the "works on my machine" excuse as Vagrant creates identical development environments for everyone on the team. 

*Designed for Teachergraph*

Use Case
--------
There are a number of problems that occur when updating your operating system. We may have a particular version of PHP on our system, however, we may want to manage a version that is different from our server environment. What happens then, is we begin to clutter our operating system with buckets of code. Instead, we should version each of our developer's environments into separate boxes, or portions, in order that one doesn't interfere with the other. These boxes are small and maintainable distributions of Linux. Isolation and Virtualization is key to a successful environment.

Setup
-----
1. Download and install Vagrant on Mac OS X, Windows, or a popular distribution of Linux: [Download Vagrant](http://www.vagrantup.com/downloads.html)
2. Download and install Virtualbox. VirtualBox is a free virtualization software: [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
3. Enable virtualization within your BIOS for 64-bit architecture support.
4. Download Ubuntu 12.04 Box into ~/Vagrant/ : [Download x64](http://files.vagrantup.com/precise64.box) || [Download x86](http://files.vagrantup.com/precise32.box). 
5. Add Ubuntu box to Vagrant's Box list. The first parameter, after the add command, is a friendly name of the box you are adding. The second, is the path to where your box is located on your host machine: `vagrant box add ubuntu12.04x64 /Vagrant/precise64.box`
6. Git clone this repository into the root directory of your teachergraph instance: 
`git clone git@github.com:KLVTZ/teachergraph-vagrant.git`
7. Make sure your .gitignore is ignoring `Vagrant` and `puphpet/`
8. *Optional* Download the latest schema into the root directory of your teachergraph instance. If you rather use a separate, custom schema, remove the import command from [Custom Settings](#Custom-Settings). 
9. You are ready to fire up vagrant: vagrant up
10. Vagrant will download and process your box from the specified path. Vagrant will handle multiple processes during initialization. This includes downloading all required provisions for Ubuntu, Apache, MySQL, PHP, and other packages for a healthy developer environment.
11. Once Vagrant has finished, you should see some elephants. If the majority of your terminal is green, then everything has gone well.
12. Edit your `/etc/hosts` file and add: `192.168.56.101 teachergraph.dev`. This will allow us to access teachergraph's local environment via `teachergraph.dev`. In addition, teachergraph has a dedicated private IP for a secure, dedicated, port connection.
13. Test out TeacherGraph by going to `teachergraph.dev`. You should redirect to the login route. You're ready to rock-and-roll!

Next Steps
----------
###SSH into Virtual Machine via bash
1. Make sure you are located within the same directoy as your Vagrant file: 
`cd /var/www/teachergraph.dev`
2. Run: `vagrant up`
3. You are now a secure guest in your virtual machine. You can interact with your MySQL Database, change Apache's settings, or even add a new packages via aptitude.

###SSH into Virtual Machine via cmd
**Windows**: Use PuTTY: A free Telnet/SSH Client: [Download PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/)
- Using PuTTY GUI:
```
HostName: 127.0.0.1
Port: 2222
```
- When you connect (Terminal Screen):
```
User: vagrant
Passwd: vagrant
```
- Before you try to connect, verify your VM using *cmd.exe*: `vagrant status`
- If it is down use: `vagrant up`

###Custom Settings
In addition to Vagrant and Puppet Provisions, Puphpet allows us to bootstrap executables when we vagrant up. For TeacherGraph, the following commands have been added to `puphpet/files/exec-once/run.sh`:
```
echo "--- Installing php5-curl module. ---"
sudo apt-get install php5-curl -y
echo "--- Installing vim. ---"
sudo apt-get install vim -y
echo "--- Initializing migrate table. ---"
php /vagrant/artisan migrate:install --env=local
echo "--- Migrating current schema ---"
php /vagrant/artisan migrate --env=local
echo "--- Importing current teachergraph schema. ---"
mysql -uroot -psecret teachergraph < /vagrant/development.sql

# Extra Laravel Goodness

echo "--- SEE YOU IN SPACE COWBOY... ---"
```
Feel free to add more before you `vagrant up`

###Teardown
We now have a fully functional virtual machine we can use for basic web development. But now let's say it is time to switch gears, maybe work on another project, maybe go out to lunch, or maybe just time to go home. How do we clean up our development environment?

With Vagrant, you *suspend*, *halt*, or *destroy* the guest machine. Each of these options have pros and cons. Choose the method that works best for you.

**Suspending** the virtual machine by calling `vagrant suspend` will save the current running state of the machine and stop it. When you're ready to begin working again, just run `vagrant up`, and it will be resumed from where you left off. The main benefit of this method is that it is super fast, usually taking only 5 to 10 seconds to stop and start your work. The downside is that the virtual machine still eats up your disk space, and requires even more disk space to store all the state of the virtual machine RAM on disk.

**Halting** the virtual machine by calling `vagrant halt` will gracefully shut down the guest operating system and power down the guest machine. You can use `vagrant up` when you're ready to boot it again. The benefit of this method is that it will cleanly shut down your machine, preserving the contents of disk, and allowing it to be cleanly started again. The downside is that it'll take some extra time to start from a cold boot, and the guest machine still consumes disk space.

**Detroying** the virtual machine by calling `vagrant destroy` will remove all traces of the guest machine from your system. It'll stop the guest machine, power it down, and remove all of the guest hard disks. Again, when you're ready to work again, just issue a vagrant up. The benefit of this is that no cruft is left on your machine. The disk space and RAM consumed by the guest machine is reclaimed and your host machine is left clean. The downside is that vagrant up to get working again will take some extra time since it has to reimport the machine and reprovision it.

###Troubleshoot
- If you are new to the project, please make sure you `chmod -R 777 storage/`
- TeacherGraph Migration is dependant on *php5-curl* module. Please make sure it is installed.
- If you want additional control while maintaining the environment settings, or something did not go right with this repository, then head on over to <http://puphpet.com>. There you can just drag your `puphpet/config.yaml` file into your browser and the form will be filled with your previous values.

**Still trouble?** Email me: <xjustinpagex@gmail.com>
