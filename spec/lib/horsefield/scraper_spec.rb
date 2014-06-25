require 'spec_helper'
require 'horsefield/scraper'

describe Horsefield::Scraper do
  let(:scraper) { Horsefield::Scraper.new('http://www.linkedin.com/in/lunarmobiscuit') }

  it 'should accept HTML or a URL as argument' do
    VCR.use_cassette('linkedin_lunarmobiscuit') do
      scraper.html.should match('<!DOCTYPE html>')
    end
  end

  describe '#scrape' do
    it 'should take a block with attributes to scrape' do
      scraper.scrape do
        name '.profile-header .full-name'
      end
    end
  end
end
