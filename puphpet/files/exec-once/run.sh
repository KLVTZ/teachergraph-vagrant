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
