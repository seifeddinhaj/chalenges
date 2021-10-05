require 'nokogiri'
require 'open-uri'
class NamesController < ApplicationController


    def search
        start = Time.now
        xml_doc = Nokogiri::HTML(open("https://www.familysearch.org/en/surname?surname=#{params["name"]}"))
        countries_nodes = xml_doc.css("svg").children.css("g")
        countires = []
        countries_nodes.each do  |node|
            if node.attributes["id"].present?
                if node.attributes["id"].value != "Layer_2"
                    countires.push(node.attributes["id"].value)
                end
            end

        end
        finish = Time.now
        time = finish - start
        render json: {requested_name: params["name"], guessed_country: countires, time_processed: time}
    end
end
