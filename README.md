# Genoma - A set of interchangeable provisioning instructions

## Project Description

This project allows to create different vagrant boxes to easily deploy different
types of apps like Drupal, Wordpress or Laravel. It allows you to choose between
different web and database servers by just changing a few words on a single file.

It uses ansible to provision the virtual machine and different pieces can be
putted together to deploy a ready to use development environment.

With this tool you could create for example:

A virtual machine with: Nginx as webserver, MySQL as database server, A site
running Wordpress (downloaded and installed using wp-cli) and a Drupal 7 site
(downloaded and installed using drush).

Then, just changing two words on the Ansible playbook you can install the same
stack but using Apache as webserver and MariaDB as database server, or try the
same applications using a different version of PHP.

## Current available options

- Webservers: Apache 2 or Nginx.
- Database servers: MariaDB or Mysql.
- Apps: Drupal 7, Drupal 8, Wordpress 4, Laravel 5.
- PHP Versions: 5.4, 5.5 and 5.6.
- PHP related tools: Composer, Drush, WP-CLI, PHPMyAdmin.
- Other tools that can be installed: GIT, Oh-My-SSH, Vim with plugins.

## Planned features to be implemented

- Support for PostgreSQL and Sqlite.
- Support for Moodle apps.
- Support for Other linux based systems: Ubuntu Server and CentOS.
- Support Varnish, Memcached and Redis services.

## Example:

With the following content on the  ```ansible/playbook.yml``` file:

    - hosts: all
      sudo: True
      remote_user: vagrant
      vars:
        vm_name: testvm
        vendors:
          # change this to nginx to install nginx instead of apache.
          webserver: apache

          # change this to mysql to install mysql instead of mariadb.
          database: mariadb

      roles:
        - { role: common }         # install the common tools
        - { role: webserver }      # Install apache
        - { role: php, version: "5.6", env: dev } # Install PHP 5.6
        - { role: dev/tools }      # install vim, oh-my-zsh
        - { role: dev/composer }   # install composer
        - { role: dev/drush }      # install drush
        - { role: database}        # install MariaDB
        - { role: dev/phpmyadmin } # install PHPMyAdmin on port 81.

        # Create the database, configure virtualhosts, download and install drupal 7.36
        - { role: apps/drupal,
                hostname: "drupal7.example.com",
                root_dir: "/vagrant/drupal7",
                version: "7.36",
                install: "yes",
                db_url: "mysql://root:root@localhost/drupal7"
          }

Run:
- vagrant up
- vagrant ssh
- /provision/run

And finally add ```192.168.55.10 drupal7.example.com``` to your the ```/etc/hosts```
or ```c:\windows\system32\etc\drivers\hosts``` on your host machine.

Then visit ```http://drupal7.example.com``` and you will see your drupal site
ready to use. You can login now using user: ```admin``` and password: ```admin```.

