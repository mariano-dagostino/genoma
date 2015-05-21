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

You can use the content from ```ansible/playbook.example.yml``` as example.

With the following content on the  ```ansible/playbook.yml``` file:

```yaml

- hosts: all
  sudo: True
  remote_user: vagrant
  vars:
    vm_name: testvm
    vendors:
      webserver: apache # alternatives: nginx
      database: mysql   # alternatives: mariadb

  roles:
    # Install basic packages, upgrade packages
    - { role: common }

    # Install the webserver
    - { role: webserver }

    # Install the database server
    - { role: database }

    # Install PHP
    - { role: php, version: "5.6", env: dev }

    # Install and configure phpmyadmin on port 81
    - { role: dev/phpmyadmin }

    # Install git, vim, oh-my-zsh and other dev tools
    - { role: dev/tools }

    # Install composer and configure it globally
    - { role: dev/composer }


    # To Install drupal apps -------------------------------

    # Install drush
    - { role: dev/drush }


    # Create a self signed certificate for the host
    - { role: dev/ssl_cert, hostname: 'drupal7.example.com' }
    # Install the drupal app
    - { role: apps/drupal,
            hostname: "drupal7.example.com",
            root_dir: "/vagrant/drupal7",
            version: "7.37",
            install: "yes",
            db_url: "mysql://root:root@localhost/drupal7",
            https: "yes",
      }

    - { role: dev/ssl_cert, hostname: 'drupal8.example.com' }
    - { role: apps/drupal,
            hostname: "drupal8.example.com",
            root_dir: "/vagrant/drupal8",
            version: "8.0.0-beta10",
            install: "yes",
            db_url: "mysql://root:root@localhost/drupal8",
            https: "no",
      }

    # To Install wordpress apps -----------------------------
    - { role: dev/wpcli }

    - { role: dev/ssl_cert, hostname: 'wp.example.com' }
    - { role: apps/wordpress,
            hostname: "wp.example.com",
            root_dir: "/vagrant/wp",
            database_name: "wp",
            database_user: "root",
            database_pass: "root",
            https: "yes",
      }

    # To Install laravel apps --------------------------------
    - { role: dev/laravel_installer }
    - { role: dev/ssl_cert, hostname: 'laravel.example.com' }
    - { role: apps/laravel,
            hostname: "laravel.example.com",
            root_dir: "/vagrant/laravel",
            database_name: "laravel",
            database_user: "laravel_user",
            database_pass: "laravel_pass",
            https: "yes",
      }

```

Run:
- ```vagrant up```
- ```vagrant ssh```
- ```/provisioning/run```

And finally add ```192.168.55.10 drupal7.example.com``` to your the ```/etc/hosts```
or ```c:\windows\system32\etc\drivers\hosts``` on your host machine.

Then visit ```http://drupal7.example.com``` and you will see your drupal site
ready to use. You can login now using user: ```admin``` and password: ```admin```.

