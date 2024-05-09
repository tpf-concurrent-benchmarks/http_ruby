# HTTP Server in Ruby

## Objective

This is a Ruby on Rails implementation of an HTTP polls server.

## Deployment

### Requirements

- [Docker >3](https://www.docker.com/) (needs docker swarm)
- [Ruby >3.3.1](https://www.ruby-lang.org/en/) (for local development)

This README would normally document whatever steps are necessary to get the
application up and running.

### Configuration

The following environment variables must be defined in the `.env` file:

- `SECRET_KEY`: A secret key for encrypting the JWT tokens.
- `ALGORITHM`: The algorithm used for encrypting the JWT tokens.
- `ACCESS_TOKEN_EXPIRE_MINUTES`: The expiration time for the JWT tokens, in minutes.
- `APP_HOST`: The host of the application.
- `APP_PORT`: The port of the application.

Example values for every variable can be found in the [.env.example](.env.example) file. If no `.env` file is found, this file will be copied to `.env`.

### Commands

#### Startup

- `make setup`: Sets up everything needed for the application to run in Docker Swarm.

#### Run

- `make deploy`: Builds the necessary Docker images and deploys the application to Docker Swarm, alongside with Graphite, Grafana and cAdvisor.
- `make remove`: Removes all services created by the `deploy` command.

### Monitoring

- Grafana: [http://127.0.0.1:8081](http://127.0.0.1:8081)
- Graphite: [http://127.0.0.1:8080](http://127.0.0.1:8080)

## Used libraries

- [Ruby on Rails](https://rubygems.org/gems/rails/versions/7.1.3): A web-application framework
- [Puma](https://rubygems.org/gems/puma/versions/5.0.0): A Ruby web server
- [SQLite](https://rubygems.org/gems/sqlite3/versions/1.4): Allows Ruby to interact with a SQLite database
- [bcrypt](https://rubygems.org/gems/bcrypt/versions/3.1.7): Secure hash algorithm for hashing passwords and storing them in the database
- [jwt](https://rubygems.org/gems/jwt/versions/2.5.0): JSON Web Token implementation for Ruby
- [dotenv](https://rubygems.org/gems/dotenv/versions/3.1.1): Loads environment variables from a `.env` file