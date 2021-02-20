service nginx start
service mysql start
service php7.3-fpm start

# Configure a wordpress database
#creating db with name wordpress
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
#access to tables in wordpress
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
#it asks server to reload tables with new data, if I use insert, update, delete
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

bash