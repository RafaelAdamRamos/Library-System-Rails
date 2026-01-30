require "net/http"
require "json"

class GoogleBooksCoverSearch
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def initialize(title:, author:, publisher:)
    @title = title
    @author = author
    @publisher = publisher
  end

  def call
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(q: query, langRestrict: "pt")

    response = Net::HTTP.get(uri)
    json = JSON.parse(response)

    item = json["items"]&.first
    return nil unless item

    item.dig("volumeInfo", "imageLinks", "thumbnail")
  end

  private

  def query
    [
      "intitle:#{@title}",
      "inauthor:#{@author}",
      "inpublisher:#{@publisher}"
    ].compact.join("+")
  end
end
