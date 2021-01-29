# Inhelint

This tiny gem checks inheritance level and warns if it exceeds the given number.

It's useful to detect overuse of inheritance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inhelint'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install inhelint

## Usage

```ruby
class C1
include Inhelint::Lint.new(level: 2) # level 2 is default
# Or shorter: include Inhelint::Default
end

class C2 < C1
end

class C3 < C2
end
# => Error!
```

You can pass a Proc object to change the behavior after detection.

```ruby
class C1
include Inhelint::Lint.new(level: 2, handler: proc { Kernel.warn 'oops!' })
end

class C2 < C1
end

class C3 < C2
end
# => oops!
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/inhelint. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/inhelint/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Inhelint project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/inhelint/blob/master/CODE_OF_CONDUCT.md).
