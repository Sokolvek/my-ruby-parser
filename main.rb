require 'uri'
require 'net/http'
uri = URI('https://example.com')
res = Net::HTTP.get_response(uri)
puts res.body
def get_sentence(body, startIndex, element)
    res = []
    while body[startIndex] != "<" and body[startIndex+1] != "/"
        res << body[startIndex]
        startIndex+=1
    end
    return {sentence:res.join(""), startIndex: startIndex+3+element.length()}
end
# puts get_sentence("aba caba </", 0, "h1")
def get_all(body, element)
    elsLen = body.scan(element).length()
    b = 0
    ind = body.index(element)
    wordStart = ind + element.length()
    index = ind
    # puts body[wordStart-2]
    puts get_sentence(body, wordStart, "p")

end


puts get_all(res.body, "<p>")
