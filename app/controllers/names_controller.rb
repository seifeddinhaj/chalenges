require 'nokogiri'
require 'open-uri'
class NamesController < ApplicationController


    def search
        if params["name"].present?
            start = Time.now
        uri = URI.parse(URI.escape("https://www.familysearch.org/en/surname?surname=#{params["name"]}"))
        xml_doc = Nokogiri::HTML(URI.open(uri))
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
        else
            render json: {error: "Data can not be blank"}, status: 422
        end
    end
end
