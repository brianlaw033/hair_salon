# Hair Salon

## Prerequisites

You will need the following things properly installed on your computer.

* [Git](https://git-scm.com/)
* [Ruby](http://moringacore-ruby.herokuapp.com/#setup.html)

## Installation
* `git clone <repository-url>` this repository
* `cd hair_salon`
* `bundle install`

##Database Setup
* `psql`
* `CREATE DATABASE hair_salon;`
* `\c hair_salon;`
* `CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);`
* `CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);`
* `CREATE DATABASE hair_salon_test TEMPLATE hair_salon;`
* `INSERT INTO stylists (name) VALUES ('Gordon');`
* `INSERT INTO clients (name, stylist_id) VALUES ('Ian', 1);`

## Running / Development

* `ruby app.rb`
* Visit your app at [http://localhost:4567](http://localhost:4567).

### Running Tests

* `rspec`

## Further Reading / Useful Links

* [moringa](http://moringacore-ruby.herokuapp.com/#setup.html)
