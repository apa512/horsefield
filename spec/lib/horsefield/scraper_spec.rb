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

        many :skills, '#skills-list li'

        many :experiences, '#profile-experience .position' do
          one :headline, 'span.title'

          one :start_year, '.period .dtstart' do
            attr('title').split('-').first.to_i
          end
        end

        one :company do
          one :name, '.postitle h4'
        end
      end

      p data[:company]

      data[:name].should == "Michael 'Luni' Libes"
      data[:experiences].first[:headline].should == 'Founder and Managing Director'
      data[:skills].should == ["Entrepreneurship", "Business Planning", "Fundraising", "Team Building", "Start-ups", "Venture Capital", "Social Entrepreneurship", "Strategic Planning", "Strategic Partnerships", "Strategy", "Business Development", "Management Consulting", "Marketing Strategy", "Sustainability", "Executive Management", "Marketing", "New Business Development", "Competitive Analysis", "Go-to-market Strategy", "Thought Leadership", "Corporate Development", "Software Development", "Business Strategy", "Mobile Devices", "Wireless", "Management", "Cloud Computing", "Nonprofits", "Business Modeling", "SaaS", "Mobile Applications", "Product Marketing", "Program Management", "Analytics", "E-commerce", "Leadership", "Enterprise Software", "Consulting", "Strategic Consulting"]
    end
  end
end
