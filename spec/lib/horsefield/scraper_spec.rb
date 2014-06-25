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
      data = scraper.scrape do
        scope '.profile-header' do
          one :name, '//span[@class="full-name"]'
        end

        many :experiences, '#profile-experience .position' do
          one :headline, 'span.title'

          one :start_year, '.period .dtstart' do
            attr('title').split('-').first.to_i
          end
        end
      end

      data[:name].should == "Michael 'Luni' Libes"
      data[:experiences].first[:headline].should == 'Founder and Managing Director'
    end
  end
end
