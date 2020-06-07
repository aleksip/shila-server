# Shila server

Vagrant friendly Ubuntu 18.04 server setup, primarily meant for local Drupal development in a virtual machine.


## Installation

### For Vagrant

- Install [VirtualBox](https://www.virtualbox.org/)
- Install [Vagrant](https://www.vagrantup.com/)
- Install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin:
    - `vagrant plugin install vagrant-vbguest`
- Install [vagrant-bindfs](https://github.com/gael-ian/vagrant-bindfs) plugin:
    - `vagrant plugin install vagrant-bindfs`
- Create and provision the guest machine:
    - `vagrant up shila`


### For other Ubuntu 18.04 based environments

- Clone the repository to some location, e.g. `/usr/local`
    - `sudo git clone https://github.com/aleksip/shila-server /usr/local/shila-server`
- Set up correct ownership for your Ubuntu user, e.g. `ubuntu`
    - `sudo chown -R ubuntu:ubuntu /usr/local/shila-server`
- Create symbolic links to the `provisioning` and `instances` directories
    - `sudo ln -s /usr/local/shila-server/provisioning /shila-provisioning`
    - `sudo ln -s /usr/local/shila-server/instances /shila-instances`
- Run the bootstrap scripts in the provisioning directory
    - `cd /shila-provisioning/shila/`
    - `sudo ./bootstrap-privileged.sh`
    - `./bootstrap-unprivileged.sh`


## Installed software

- [MySQL](https://www.mysql.com/)
- [PHP](https://php.net/) 7.4 (for Drupal 7, 8 and 9) and 5.6 (for Drupal 6)
- [Xdebug](https://xdebug.org/)
- [Nginx](https://nginx.org/)
- [MailHog](https://github.com/mailhog/MailHog)
- [Git](https://git-scm.com/)
- [Composer](https://getcomposer.org/)
- [Drush](http://www.drush.org/) 8 (for Drupal 6 and 7)
- [Drupal Console](https://drupalconsole.com/)
- [Node.js](https://nodejs.org/) + [npm](https://www.npmjs.com/)
- [Gulp](http://gulpjs.com/)
- [Shila Drupal](https://github.com/aleksip/shila-drupal)
- [Shila Drupal site](https://github.com/aleksip/shila-drupal-site)
- [Shila theme](https://github.com/aleksip/shila-drupal-theme)
- [Shila CSS](https://github.com/aleksip/shila-css)
