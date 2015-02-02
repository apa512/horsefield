require 'test_helper'

class RecipeScraper
  include Horsefield::Scraper

  scope '.hide_from_screen' do
    one :title, 'h1'
    one :description, 'h2'
  end

  many :nutritional_value, 'article.recipe_nutrition ul li' do
    one(:type) { at('span').text }
    one(:value) { at('span.value').text }
  end

  many :recommendations, '#recipe_slider .item' do
    one :title, '.carousel_title'
  end
end

class TestScraper < Minitest::Test
  def test_it
    html = File.read(File.expand_path('../../recipe_source.html', __FILE__)).force_encoding('UTF-8')
    p RecipeScraper.new(html).scrape
  end
end
