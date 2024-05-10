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

    def find_all(element)
      res = []
      founded_times = 0
      index = 0
      len = @@body.scan(element).length / 2
      while index <= @@body.length
        if @@body[index] == element[0] && @@body[index-1] == "<"
          match = match_element(element,@@body,index)
          if match[:is_matched]
            sentence = get_sentence(@@body, index, element)
            res << sentence[:sentence]
            index = sentence[:start_index]
            puts "yesss sir"
          end

        end
        index += 1
      end
      puts res
      puts "end"

    end

    def get_sentence(body, start_index, element)
      while body[start_index] != ">"
        start_index+=1
      end
      res = []
      while (body[start_index] != '<') && (body[start_index + 1] != '/')
        res << body[start_index]
        start_index += 1
      end
      { sentence: res.join(''), start_index: start_index + 3 + element.length }
    end
    

    def match_element(element, body, index)
      test = []
      (0..element.length-1).each do |i|
        test.push(element[i])
        if body[index] != element[i]
          return { is_matched: false, index: index - 1 }
        end
        index += 1
      end
      { is_matched: true, index: index }
    end


  end
end