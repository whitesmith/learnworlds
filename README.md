# Learnworlds

Wrapper for the Learn Worlds API

**IMPORTANT!:** This gem is still on a early state and not all features are built in yet. Feel free to add features or if you need our help please reach us at nuno_lopes@whitesmith.co

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add learnworlds

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install learnworlds

## Usage

### Authentication with Client Credentials grant

To authenticate with client credentials grant you need to 

```ruby
client = LearnWorlds::Client.new(
  client_id: 'xxxxxxxxxxx',
  client_secret: 'xxxxxxxxx',
  base_url: 'https://yourschool.mylearnworlds.com'
)

client.authentication.authenticate('client_credentials')

```

If you already have the accesse token you can initiate the client in the following way

```ruby
client = LearnWorlds::Client.new(
  access_token: 'xxxxxxxx',
  base_url: 'https://yourschool.mylearnworlds.com'
)
```

you can also save some lines of code if you set the folloing env vars `LEARN_WORLDS_CLIENT_ID`, `LEARN_WORLDS_CLIENT_SECRET`, `LEARN_WORLDS_BASE_URL`

Once that is done, you can initialize the client with 

```ruby
client = LearnWorlds::Client.new
```

Everytime you call `authenticate('client_credentials')` a new request will be made to Learn Worlds. 
If you want to avoid that you can define custom getters and setters for the access token via the configuration.

You can use that to add logic to persist or get the access token on your side and you can also add some logic to verify if the access token is still valid.

For example:

```ruby
LearnWorlds.configure do |config|
  
  # return nil if access_token is invalid and you want to proceed with the authentication process
  config.retrieve_access_token_method =  ->() { Rails.cache.fetch("learnworlds_access_token") }

  config.persist_access_token_method =  ->(access_token, expires_in) { Rails.cache.write('learnworlds_access_token', access_token) } }
end
```

### User Resource

```ruby
# lists all users
client.user.list

# creates a user
client.user.create(email: 'test@test.com', username: 'test')

# updates a user
client.user.update(user_id: 'user_id', username: 'updated_username')

# finds a user
client.user.find(user_id: 'user_id')

# enrolls a user on a course
client.user.enroll(user_id: 'user_id', product_id: 'course_id', product_type: 'course', price: 0)
```

### SSO Resource

```ruby

client.sso.redirect(email: 'test@test.com', redirect_to 'xyz.learnworlds.com/courses')

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/whitesmith/learnworlds. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/whitesmith/learnworlds/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Learnworlds project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/whitesmith/learnworlds/blob/main/CODE_OF_CONDUCT.md).
