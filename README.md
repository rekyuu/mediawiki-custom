# MediaWiki Custom Docker Image

This is a custom MediaWiki 1.36.2 Docker image that adds the following features:

- Image is based on the MediaWiki [Alpine FPM](https://hub.docker.com/layers/mediawiki/library/mediawiki/1.36.2-fpm-alpine/images/sha256-78547dd202041c57d7365878bcae46c105dc35a63f0eae9d669b5cb03bc2a31c?context=explore) image
- NGINX server installed
- NGINX config to provide shortened URLs
- PostgreSQL PHP support
- [Discord](https://www.mediawiki.org/wiki/Extension:Discord) MediaWiki extension
- [Widgets](https://www.mediawiki.org/wiki/Extension:Widgets) MediaWiki extension
- [WikiSEO](https://www.mediawiki.org/wiki/Extension:WikiSEO) MediaWiki extension
- A backup utility script

## Running a new server

1. Clone this repository.
2. **Optional:** Create a `favicon.ico` and `logo.png`.
3. Start the stack:

    ```bash
    $ docker-compose up
    ```

4. Go to `localhost:7000/mw-config/` and perform the initial MediaWiki setup.
5. Once completed, download the `LocalSettings.php` to this directory.
6. Stop the stack.
7. Uncomment the `LocalSettings.php` mount binding in the `docker-compose.yml` file.
8. Start the stack again.
9. Add the following to `LocalSettings.php` to activate the extensions:

    ```php
    wfLoadExtension( 'Discord' );
    wfLoadExtension( 'Widgets' );
    wfLoadExtension( 'WikiSEO' );
    ```

    Please see each extension's respective repositories for configuration documentation.

10. **Optional:** Add the following to `LocalSettings.php` for shortened URLs:

    ```php
    $wgArticlePath = "/$1";
    $wgUsePathInfo = true;
    $wgScriptExtension = ".php";
    ```

## Migrating from an existing setup

1. Clone this repository.
2. Copy your `LocalSettings.php`, `favicon.ico` and `logo.png`.
3. Uncomment the `LocalSettings.php` mount binding in the `docker-compose.yml` file.
4. Start the stack:

    ```bash
    $ docker-compose up
    ```

5. Copy existing images into the volume:

    ```bash
    $ cd images/
    $ docker cp . wiki:/var/www/html/images
    $ docker exec wiki chown -R www-data:www-data /var/www/html/images
    ```

## Creating backups

To create a backup, simply run the following script:

```bash
$ docker exec wiki /scripts/mw-backup.sh
```

This will create a backup archive in the mounted `backups` folder.

The script will backup the following:

- `images/`
- `LocalSettings.php`
- `logo.png`
- `favicon.ico`