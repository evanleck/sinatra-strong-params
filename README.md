# Sinatra::StrongParams

A really naive parameter filtering implementation for Sinatra.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-strong-params', require: 'sinatra/strong-params'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-strong-params

If you are using a Modular Sinatra application such as `class MyApp < Sinatra::Base` you must include any desired extensions explicitly within your Sinatra application:

```ruby
register Sinatra::StrongParams
```

## Usage

This gem adds two filters to Sinatra routes: `allows` and `needs`.

### Allows

A way to whitelist parameters in the request scope.

```ruby
get '/', allows: [:id, :action] do
  erb :index
end
```

`allows` modifies the parameters available in the request scope keeping just the allowed params.

### Needs

A way to require parameters in the request scope.

```ruby
get '/', needs: [:id, :action] do
  erb :index
end
```

`needs` does not modify the parameters available to the request scope
but raises a `RequiredParamMissing` error if a needed param is missing.

Catching a missing parameter error:

```ruby
error RequiredParamMissing do
  [400, env['sinatra.error'].message]
end
```

### Allows and Needs

Wanna get super restrictive? Can do.

```ruby
post '/login', needs: [:email, :password], allows: [:name] do
  # handle yo business
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sinatra-strong-params/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes with tests (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
