require 'httparty'
require 'json'

uri ="http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
response =HTTParty.get(uri)
result=JSON.parse(response.body)
puts result

arr= Array.new

#6.times {|i| arr<< result["drwtNo#{i.next}"]} //원라인

6.times do |i|
    arr << result["drwtNo#{i.next}"]
    
end
puts arr

# arr[0] = result["drwtNo1"]
# arr[1] = result["drwtNo2"]
# arr[2] = result["drwtNo3"]
# arr[3] = result["drwtNo4"]
# arr[4] = result["drwtNo5"]
# arr[5] = result["drwtNo6"]

# puts arr

result.each do |key,value|
        arr << value if key.include? "drwtNo"
end 

puts.sort

