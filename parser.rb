require 'uri'
require 'net/http'

module FPraser

  class Parser
    @@body

    def initialize(url)
      url = URI(url)
      @@body = Net::HTTP.get_response(url)
      @@body = @@body.body
    end

    def find_all(tag)

      res = []
      index = 0
      tag_start = "<#{tag}"
      tag_end = "</#{tag}>"
      tag_start_index = @@body.index(tag_start, index)
      len = @@body.scan(tag_end).length
      founded_times = 0

      while founded_times < len
        res << get_sentence(@@body, tag_start_index)
        tag_start_index = @@body.index(tag_start, index)
        founded_times += 1

      end
      res
    end

    def get_sentence(body, start_index)
      while body[start_index] != ">"
        start_index+=1
      end
      start_index+=1
      res = []
      while (body[start_index] != '<') && (body[start_index + 1] != '/')
        res << body[start_index]
        start_index += 1
      end
      res.join("")
    end    

    def match_element(element, body, index)
      (0..element.length-1).each do |i|
        if body[index] != element[i]
          return { is_matched: false, index: index - 1 }
        end
        index += 1
      end
      { is_matched: true, index: index }
    end


  end
end
