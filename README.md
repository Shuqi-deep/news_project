The setups steps expect following tools installed on the system.

- Github
- Ruby [3.3.4]
- Rails [7.2.1]

##### 1. Check out the repository

```bash
git clone https://github.com/Shuqi-deep/news_project.git
```

##### 2. Prepare to work

Run the following commands to setup project.

```ruby
bundle install
rails tailwindcss:build
```


##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
rails db:seed
```

##### 4. Run tests

Run the following commands to start tests.

```ruby
rails db:schema:load
rails db:test:prepare
rails test
```

##### 5. Start the Rails server

You can start the rails server using the commands given below.

```ruby
set PORT=3000
set RUBY_DEBUG_OPEN=true
set RUBY_DEBUG_LAZY=true
foreman start -f Procfile.dev
```

And now you can visit the site with the URL http://localhost:5000
