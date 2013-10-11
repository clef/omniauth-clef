# OmniAuth Clef

The official Clef OAuth2 Strategy for OmniAuth 1.0.

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth'
gem 'omniauth-clef'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Clef` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :clef, ENV['CLEF_ID'], ENV['CLEF_SECRET']
end
```

### Custom Callback URL/Path

You can set a custom `callback_url` or `callback_path` option to override the default value. See [OmniAuth::Strategy#callback_url](https://github.com/intridea/omniauth/blob/master/lib/omniauth/strategy.rb#L411) for more details on the default.

## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'clef',
  :uid => '1234567',
  :info => {
    :email => 'test@example.com',
    :first_name => 'Clef',
    :last_name => 'User',
    :phone_number => '2021119999'
  },
  :extra => {
    :raw_info => {
      :id => '1234567',
      :first_name => 'Clef',
      :last_name => 'User',
      :name => 'Clef User' # only included if first name is included
      :email => 'test@example.com',
      :phone_number => '2021119999'
    }
  }
}
```

## Supported Rubies

Actively tested with the following Ruby versions:

- MRI 1.9.3
- MRI 1.9.2
- MRI 1.8.7
- JRuby 1.6.5

*NB.* For JRuby, you'll need to install the `jruby-openssl` gem. There's no way to automatically specify this in a Rubygem gemspec, so you need to manually add it your project's own Gemfile:

```ruby
gem 'jruby-openssl', :platform => :jruby
```

## License

Copyright (c) 2012 by Jesse Pollak

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
