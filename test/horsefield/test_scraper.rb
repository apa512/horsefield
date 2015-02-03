require 'test_helper'
require 'pry'

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

  postprocess do |doc|
    doc[:nutritional_value] = doc[:nutritional_value].uniq.compact
    doc
  end
end

class RecipeScraperWithOptionalField
  include Horsefield::Scraper

  scope '.hide_from_screen' do
    one :title, 'h1'
    one :description, 'h2'
    one? :missing, '.missing'
  end
end

class RecipeScraperWithRequiredField
  include Horsefield::Scraper

  scope '.hide_from_screen' do
    one :title, 'h1'
    one :description, 'h2'
    one! :important, '.important'
  end
end

class TestScraper < Minitest::Test
  def setup
    @html = File.read(File.expand_path('../../recipe_source.html', __FILE__)).force_encoding('UTF-8')
  end

  def test_that_it_scrapes
    recipe = RecipeScraper.new(@html).scrape
    p recipe

    assert_equal 'Traditional Welsh cawl', recipe[:title]
  end

  def test_that_it_ignores_optional_fields
    recipe = RecipeScraperWithOptionalField.new(@html).scrape
    refute_includes recipe.keys, :missing
  end

  def test_that_it_raises_with_missing_required_field
    assert_raises(Horsefield::MissingSelectorError) { RecipeScraperWithRequiredField.new(@html).scrape }
  end
end
