# Horsefield

Scrape stuff

## Installation

Add this line to your application's Gemfile:

    gem 'horsefield'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install horsefield

## Usage

```ruby
Horsefield::Scraper.new('https://news.ycombinator.com').scrape do
  scope '//body//table' do
    many :posts, './/td[@class="title"][2]' do
      one :title, 'a'
      one :url, './a/@href'
    end
  end
end

# =>
# { posts:
#     [{ title: "Nobody expects CDATA sections in XML",
#        url: "http://lcamtuf.blogspot.com/2014/11/afl-fuzz-nobody-expects-cdata-sections.html" },
#     ...] }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/horsefield/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
