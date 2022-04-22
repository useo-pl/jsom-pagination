# JSOM::Pagination

[![Gem Version](https://badge.fury.io/rb/jsom-pagination.svg)](https://badge.fury.io/rb/jsom-pagination)
![Tests](https://github.com/useo-pl/jsom-pagination/workflows/Run%20tests/badge.svg?branch=master&event=push)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/bc98c8c017c64b70a11ca79aea6c3e3c)](https://app.codacy.com/gh/useo-pl/jsom-pagination?utm_source=github.com&utm_medium=referral&utm_content=useo-pl/jsom-pagination&utm_campaign=Badge_Grade_Dashboard)
[![Codacy Badge](https://app.codacy.com/project/badge/Coverage/eab277bd1f694da88691a2e645adbe96)](https://www.codacy.com/gh/useo-pl/jsom-pagination?utm_source=github.com&utm_medium=referral&utm_content=useo-pl/jsom-pagination&utm_campaign=Badge_Coverage)

An easy to use JSON:API support for web applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jsom-pagination'
```

And then execute:

```shell
$ bundle install
```

Or install it yourself as:

```shell
$ gem install jsom-pagination
```

## Usage

### For arrays

```ruby
paginator = JSOM::Pagination::Paginator.new
collection = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
paginated = paginator.call(collection, params: { number: 2, size: 3 }, base_url: 'https://example.com')
```

### For ActiveRecord collections

```ruby
paginator = JSOM::Pagination::Paginator.new
collection = Article.published
paginated = paginator.call(collection, params: { number: 2, size: 3 }, base_url: 'https://example.com')
```

### Meta data object

You can call `meta` on the paginated collection to easily get meta information about the paginated results

```ruby
paginated.meta
# => #<JSOM::Pagination::MetaData total=10 pages=4>

paginated.meta.to_h
# => {:total=>10, :pages=>4}
```

### Links object

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

```ruby
options = { meta: paginated.meta.to_h, links: paginated.links.to_h }
render json: serializer.new(paginated.items, options)
```

### Summary

Using the information above, you can put everything all together by using [jsom-pagination](https://github.com/useo-pl/jsom-pagination) in a ruby framework of your choice.

Below is an illustration in [Rails](https://rubyonrails.org/):

```ruby
# app/controllers/concerns/paginable.rb
module Paginable
    extend ActiveSupport::Concern
    
    def paginator
      JSOM::Pagination::Paginator.new
    end
    
    def pagination_params
      params.permit![:page] # defaults to 20 pages 
    end
    
    def paginate(collection)
      paginator.call(collection, params: pagination_params, base_url: request.url)
    end
  
    def render_collection(paginated)
      options = {
        # meta: paginated.meta.to_h, # Will get total pages, total count, etc.
        links: paginated.links.to_h
      }
      paginated_result = serializer.new(paginated.items, options)
  
      render json: paginated_result
    end
end
```

```ruby
# app/controllers/articles_controllers.rb
class ArtclesController < ApplicationController
    include Paginable

    def index
        articles = articles = Article.order('created_at DESC')
        paginated = paginate(articles)
    
        articles.present? ? render_collection(paginated) : :not_found
    end

    private

    def serializer
        ArticleSerializer
    end
end
```

The response from the paginated json will look like below:

```json
{
  "data": [
    {
      "id": "5404329",
      "type": "article",
      "attributes": {
        "author": "Canan Ercan",
        "copies": 10000,
        "publisher": "Webster & Canan Publishers",
        "price": "700"
      }
    }
  ],
  "links": {
    "first": "http://127.0.0.1:3000/api/v1/articles",
    "prev": "http://127.0.0.1:3000/api/v1/articles?page[number]=349",
    "self": "http://127.0.0.1:3000/api/v1/articles?page[number]=350",
    "next": "http://127.0.0.1:3000/api/v1/articles?page[number]=351",
    "last": "http://127.0.0.1:3000/api/v1/articles?page[number]=352"
  }
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/useo-pl/jsom-pagination>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/useo-pl/jsom-pagination/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JSOM::Pagination project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/useo-pl/jsom-pagination/blob/master/CODE_OF_CONDUCT.md).
