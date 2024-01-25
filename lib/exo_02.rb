require 'rubygems'
require 'nokogiri'
require 'restclient'
def get_townhall_urls
    url = "https://annuaire-des-mairies.com/"
    response = RestClient.get(url)
    page = Nokogiri::HTML(response.body)
    liens = []
    links = page.css('a')
    links.each do |link|
    href = link['href']
    liens << href
    end
    for element in liens
        if element.include?("val-d-oise")
            lien_cherché = element
        end
    end
    nouveau_lien = url + lien_cherché
    response_deux = RestClient.get(nouveau_lien)
    page_deux = Nokogiri::HTML(response_deux.body)
    element = page_deux.at_xpath("//table[@class='Style20']")
    array_de_merde = []
    if element
        element.css('a').each do |link|
            href = link['href'].gsub(/^\.\//, '')
            href = url + href
            array_de_merde << href
        end
    else
    puts "L'élément n'a pas été trouvé."
    end
    return array_de_merde
end

def get_townhall_emails(townhall_url)
    response = RestClient.get(townhall_url)
    page = Nokogiri::HTML(response.body)
    element = page.at_xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
    if element
        texte_de_element = element.text.strip
        return texte_de_element
    else
        return ""
    end
end

def get_townname(townhall_url)
    response = RestClient.get(townhall_url)
    page = Nokogiri::HTML(response.body)
    element = page.at_xpath("/html/body/div/main/section[1]/div/div/div/h1")
    if element
        texte_de_element = element.text.strip
        femme_mature = texte_de_element.split(' ')
        texte_de_element = femme_mature[0].to_s
        return texte_de_element
    else
        retun ""
    end
end

p = get_townhall_urls
rendu_final = []
for element in p
    a = get_townname(element)
    b = get_townhall_emails(element)
    hash_temp = {a => b}
    rendu_final << hash_temp
end
puts rendu_final
