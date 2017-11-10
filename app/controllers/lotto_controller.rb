class LottoController < ApplicationController
  def index
  end

  def show
    @lotto= (1..45).to_a.sample(6).sort.join(',')
  end
  
  def api
    require 'json'
    
   uri ="http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
  response =HTTParty.get(uri)
  result=JSON.parse(response.body)
  puts result

  @arr= Array.new

  #6.times {|i| arr<< result["drwtNo#{i.next}"]} //원라인

  6.times do |i|
    @arr << result["drwtNo#{i.next}"]
    
  end
  
  bonus=result["bnusNo"]#보너스 번호

  result.each do |key,value|
        @arr << value if key.include? "drwtNo"
  end 
  
  lotto =[*1..45].sample(6)
  @lotto=lotto
  
  @matching= @arr& @lotto
  
  if @matching.count==6
    @result= "1등(15억원)"
  elsif @matching.count ==5 && @lotto.include?[bonus] #우리 추천 번호에 bonus가 있니?
    @result= "2등(4천만원)"
  elsif @matching.count ==4
  @result="3등(120만원)"

  elsif @matching.count ==3
@result="4등(5만원)"
  elsif @matching.count ==2
  @result="5등(5천원)"

  elsif @matching.count ==1
  @result="6등"
  else
  @result="꽝"
  
  end
end
  # def pick_and_check
  #   require 'open-uri'
  #   require 'json'
    
  # 	get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read

  # 	drw_numbers = []		# 이번주 당첨번호
  #   get_info.each do |k, v|
  #     drw_numbers << v if k.include? 'drwtNo'
  #   end
  #   drw_numbers.sort!
  #   bonus_number = get_info["bnusNo"]		#보너스번호
    
  #   @drw_numbers = drw_numbers
  #   @bonus_number = bonus_number
    
  # end
end
