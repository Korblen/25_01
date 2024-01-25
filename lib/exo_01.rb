require 'rubygems'
require 'nokogiri'
require 'restclient'
def scrap_page
    response = RestClient.get("https://coinmarketcap.com/all/views/all/")
    page = Nokogiri::HTML(response.body)
    array_fin = []
    page.css('tr.cmc-table-row').each do |row|
        name = row.css('td.cmc-table__cell--sort-by__symbol').text.strip
        price_element= row.css('td.cmc-table__cell--sort-by__price span').first
        price = price_element ? price_element.text.strip.gsub(/[ ",$]/, "") : ""
        if name != "" && price != ""
            array_fin << { name => price.to_f }
        end
    end
    return array_fin
end

scrap_page