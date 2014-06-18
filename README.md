Teachergraph via Vagrant
====================

Vagrant is a lightweight, reproducible, portable environment that aims to mirror your production envirionment. Vagrant will change how you work. Say goodbye to the "works on my machine" excuse as Vagrant creates identical development environments for everyone on the team. 

*Designed for Teachergraph*

Use case
--------
There are a number of problems that occur when updating your operating system. We may have a particular version of PHP on our system, however, we may want to manage a version that is different from our server environment. What happens then, is we begin to clutter our operating system with buckets of code. Instead, we should version each of our developer's environments into separate boxes, or portions, in order that one doesn't interfere with the other. These boxes are small and maintainable distributions of Linux. Isolation and Virtualization is key to a successful environment.

Setup
-----
1. Download and install Vagrant within minutes on Mac OS X, Windows, or a popular distribution of Linux: [Download](http://www.vagrantup.com/downloads.html)
2. Download and install Virtualbox. VirtualBox is a free virtualization software: [Download](https://www.virtualbox.org/wiki/Downloads)
3. Enable virtualization within your BIOS for 64-bit architecture support.
4. Download Ubuntu 12.04 Box into ~/Vagrant/ : [Download x64](http://files.vagrantup.com/precise64.box) || [Download x86](http://files.vagrantup.com/precise32.box). 
5. Add Ubuntu box to Vagrant's Box list. The first parameter, after the add command, is a friendly name of the box you are adding. The second, is the path to where your box is located on your host machine:
``` 
vagrant box add ubuntu12.04x64 /Vagrant/precise64.box
```
6. Git clone this repository into the root directory of your teachergraph instance:
```
git clone
```
7. Make sure your .gitignore is ignoring `Vagrant` and `puphpet/`
8. You are ready to fire up vagrant:
```
vagrant up
```
9. Vagrant will download and process your box from the specified path. Vagrant will handle multiple processes during initialization. This includes downloading all required provisions for Ubuntu, Apache, MySQL, PHP, and other packages for a healthy developer environment.
10. Once Vagrant has finished, you should see some elephants. If the majority of your terminal is green, then everything has gone well.

Next Steps
----------

