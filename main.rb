
require 'uri'
require 'net/http'
require 'open-uri'
require_relative 'parser'

parser = FPraser::Parser.new("https://example.com")
puts parser.find_all("p")

url = URI('https://sokolvek.github.io/portfolio/#/')


res = Net::HTTP.get_response(url)

test = "h21"
a = parser.match_element("h1", test, 0)
