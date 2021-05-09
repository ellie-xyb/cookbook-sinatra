require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class ScrapeAllrecipesService
  BASE_URL = "https://www.allrecipes.com/search/results/?search=".freeze

  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "#{BASE_URL}#{@keyword}"
    doc = Nokogiri::HTML(URI.open(url), nil, 'utf-8')
    doc.search(".card__detailsContainer").first(5).map do |el|
      name = el.search("h3.card__title").text.strip
      rating = el.search(".review-star-text").text.strip
      descs = el.search(".card__summary").text.strip
      link = el.search("a.card__titleLink")[0].attributes["href"].value
      prep_time = Nokogiri::HTML(URI.open(link), nil, 'utf-8').search(".recipe-meta-item-body").first.text.strip
      Recipe.new({ name: name, rating: rating, description: descs, prep_time: prep_time })
    end
  end
end
