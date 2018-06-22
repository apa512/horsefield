require 'test_helper'
require 'pry'

class RedditScraper
  include Horsefield::Scraper

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

class XMLScraper
  include Horsefield::Scraper

  many :jobs, '//item' do
    one :title, 'title'
    one :url, 'link'
  end
end

class TestScraper < Minitest::Test
  def setup
    @html = File.read(File.expand_path('../../reddit_source.html', __FILE__)).force_encoding('UTF-8')
    @xml = File.read(File.expand_path('../../jobs.rss', __FILE__)).force_encoding('UTF-8')
  end

  def test_scraper
    # reddit = RedditScraper.new(@html).scrape
    # p reddit[:posts].first[:tagline]
    # jobs = XMLScraper.new(@xml).scrape
    # p jobs
  end
end
