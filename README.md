# Horsefield

It's for scraping.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'horsefield'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install horsefield

## Usage

Define a scraper:
```ruby
class RedditScraper
  include Horsefield::Scraper

  many :posts, '#siteTable .thing' do
    one :title, 'a.title'
    many :links, './/a[contains(@href, "reddit.com")]/@href'
  end

  many :trending, '.trending-subreddits-content > ul > li a'
end
```
and use it with a URL or an HTML string:
```ruby
RedditScraper.new('http://www.reddit.com').scrape
```
Enjoy:
```ruby
{:posts=>
  [{:title=>"Chris Pratt, homeless, living in this van, holding the script to his first acting job",
    :links=>["http://www.reddit.com/user/Ripsaw99", "http://www.reddit.com/r/pics/", "http://www.reddit.com/r/pics/comments/2v16z9/chris_pratt_homeless_living_in_this_van_holding/"]},
   {:title=>"Cannot believe I got him to sit and stay for this.",
    :links=>["http://www.reddit.com/user/Hurevolution4lx", "http://www.reddit.com/r/aww/", "http://www.reddit.com/r/aww/comments/2v0tuh/cannot_believe_i_got_him_to_sit_and_stay_for_this/"]}
  ...
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/horsefield/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
