require_relative '../lib/exo_02.rb'
require 'rspec'
require 'rubygems'
require 'nokogiri'
require 'restclient'

# Inclure ici vos trois fonctions : get_townhall_urls, get_townhall_emails, get_townname

describe "Web Scraping Functions" do
  describe "#get_townhall_urls" do
    it "returns an array of URLs" do
      urls = get_townhall_urls
      expect(urls).to be_an(Array)
      expect(urls).not_to be_empty
    end
  end

  describe "#get_townhall_emails" do
    it "returns the email address of a town hall" do
      # Replace 'townhall_url' with an actual URL from your data
      townhall_url = "https://annuaire-des-mairies.com/95/ableiges.html"
      email = get_townhall_emails(townhall_url)
      expect(email).to match(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
    end
  end

  describe "#get_townname" do
    it "returns the name of a town" do
      # Replace 'townhall_url' with an actual URL from your data
      townhall_url = "https://annuaire-des-mairies.com/95/ableiges.html"
      town_name = get_townname(townhall_url)
      expect(town_name).to be_a(String)
      expect(town_name).not_to be_empty
    end
  end
end