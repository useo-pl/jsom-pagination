# JSOM::Pagination

An easy to use JSON:API support for web applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsom-pagination'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jsom-pagination

## Usage

**For arrays**

```ruby
  paginator = JSOM::Pagination::Paginator.new
  collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  paginated = paginator.call(collection, params: { number: 2, size: 3 }, base_url: 'https://example.com')
```

**For ActiveRecord collections**

```ruby
  paginator = JSOM::Pagination::Paginator.new
  collection = Article.published
  paginated = paginator.call(collection, params: { number: 2, size: 3 }, base_url: 'https://example.com')
```

**Meta data object**

You can call `meta` on the paginated collection to easily get meta information about the paginated results

```ruby
paginated.meta
# => #<JSOM::Pagination::MetaData total=10 pages=4>

paginated.meta.to_h
# => {:total=>10, :pages=>4}
```

**Links object**

You can call `links` on the paginated collection to easily get collection of pagination links for the client

```ruby
paginated.links
# => #<JSOM::Pagination::Links:0x00007fdf5d0dd2b8 @url="https://example.com", @page=#<JSOM::Pagination::Page number=2 size=3>, @total_pages=4, @first="https://example.com?page[size]=3", @prev="https://example.com?page[size]=3", @self="https://example.com?page[number]=2&page[size]=3", @next="https://example.com?page[number]=3&page[size]=3", @last="https://example.com?page[number]=4&page[size]=3">

paginated.links.to_h
# => {
#   :first=>"https://example.com?page[size]=3",
#   :prev=>"https://example.com?page[size]=3",
#   :self=>"https://example.com?page[number]=2&page[size]=3",
#   :next=>"https://example.com?page[number]=3&page[size]=3",
#   :last=>"https://example.com?page[number]=4&page[size]=3"
# }
```

### Rendering using fast_jsonapi

```
options = { meta: paginated.meta.to_h, links: paginated.links.to_h }
render json: serializer.new(paginated.items, options)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/useo-pl/jsom-pagination. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/useo-pl/jsom-pagination/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JSOM::Pagination project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/useo-pl/jsom-pagination/blob/master/CODE_OF_CONDUCT.md).
