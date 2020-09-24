#! /bin/sh

# Wait for MySQL
until nc -z -v -w30 $DATABASE_HOST $DATABASE_PORT; do
 echo 'Waiting for MySQL...'
 sleep 1
done
echo "MySQL is up and running!"
