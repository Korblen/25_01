require 'rspec'
require_relative '../lib/exo_01.rb'

describe 'scrap_page' do
  it 'should return an array of hashes with names and prices' do
    crypto_data = scrap_page
    expect(crypto_data).to be_an(Array)
    expect(crypto_data).not_to be_empty
    crypto_data.each do |crypto|
        expect(crypto.keys.first).to be_a(String)
        expect(crypto.values.first).to be_a(Float)
      end
  end
end