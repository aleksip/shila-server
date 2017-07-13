# Shila Vagrant

A setup for running one or more instances (development, staging, production...) of [Shila Drupal](https://github.com/aleksip/shila-drupal) in a Vagrant virtual machine.


## Installation

- Install [VirtualBox](https://www.virtualbox.org/)
- Install [Vagrant](https://www.vagrantup.com/)
- Install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin:
    - `vagrant plugin install vagrant-vbguest`
- Install [vagrant-bindfs](https://github.com/gael-ian/vagrant-bindfs) plugin:
    - `vagrant plugin install vagrant-bindfs`
- Create and provision the guest machine:
    - `vagrant up shila`


## Software installed on guest machine (`ubuntu/xenial64`)

- [MySQL](https://www.mysql.com/)
- [PHP](https://php.net/) 7.0 (for Drupal 7 and 8) and 5.6 (for Drupal 6)
- [Nginx](https://nginx.org/)
- [Varnish](https://varnish-cache.org/)
- [Git](https://git-scm.com/)
- [Composer](https://getcomposer.org/)
- [Drush](http://www.drush.org/)
- [Drupal Console](https://drupalconsole.com/)
- [Node.js](https://nodejs.org/) + [npm](https://www.npmjs.com/)
- [Gulp](http://gulpjs.com/)
