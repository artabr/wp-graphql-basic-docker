#!/bin/bash -e

{
if [ -f DUMMY.md ]; then
    echo "The dummy data was already populated. Exiting WP_CLI"
    exit 0
fi
}
  
until mysql -h "db" -P "3306" -D "wordpress" -u "wordpress" -pwordpress -e '\q'; do
  >&2 echo "MySQL is unavailable right now - waiting for MySQL to run WP-CLI"
  sleep 1
done
  
>&2 echo "MySQL is up - running WP-CLI installation command"
echo $PWD
echo "# This WP installation was populated with dummy data by WP_CLI" > DUMMY.md
exec curl -N https://loripsum.net/api/5/headers/decorate/link/bq | wp post generate --post_content --count=10
exec curl -N https://loripsum.net/api/5/headers/decorate/link/bq | wp post generate --post_type=project --post_content --count=10