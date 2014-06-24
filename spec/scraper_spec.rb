require 'spec_helper'
require 'horsefield/scraper'

describe Horsefield::Scraper do
  describe '#scrape' do
    it 'should accept HTML or a URL as argument' do
      VCR.use_cassette('linkedin_lunarmobiscuit') do
        puts Horsefield::Scraper.new('http://www.linkedin.com/in/lunarmobiscuit').html
      end
    end
  end
end
