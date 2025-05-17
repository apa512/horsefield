require_relative '../test_helper'
require 'pry'

class RedditScraper
  include Horsefield::Scraper

  one :meta do
    [:keywords].each do |name|
      one name, ".//meta[@name='#{name}']/@content"
    end
  end

  one :static do
    "test"
  end

  many :posts, '#siteTable .thing' do
    one :title, 'a.title'
    one :tagline, 'p.tagline' do
      one :submitted, './time/@datetime'
      one :subreddit, 'a.subreddit'
      one? :missing, '.missing'
    end
    many :links, './/a[contains(@href, "reddit.com")]/@href'
  end

  many :trending, '.trending-subreddits-content > ul > li a'
end

class TestScraper < Minitest::Test
  def setup
    @reddit_html = File.read(File.expand_path('../../reddit_source.html', __FILE__)).force_encoding('UTF-8')
  end

  def test_scraper
    reddit = RedditScraper.new(@reddit_html).scrape
    assert_equal "reddit, reddit.com, vote, comment, submit", reddit[:meta][:keywords]
    assert_equal "Chris Pratt, homeless, living in this van, holding the script to his first acting job", reddit[:posts][0][:title]
    assert_equal "test", reddit[:static]
  end
end
