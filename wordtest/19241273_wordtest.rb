#19241273 道山愛子
#和英モードの為の読み込み
require 'readline'

##変数設定##
#得点
score = 0

#間違いリスト
wrong ={}

#モード・ファイル名・記録ファイル名配列
modes = [{mode: "日本語　-->　英語（初級）",name: "type_easy.csv",
          record: "record_easy.csv"},
         {mode: "日本語　-->　英語（中級）",name: "type_nomal.csv",
          record: "record_nomal.csv"},
         {mode: "英語　-->　日本語（初級）",name: "type_easy.csv",
          record: "record_easy2.csv"},
         {mode: "英語　-->　日本語（中級）",name: "type_nomal.csv",
          record: "record_nomal2.csv"},
         {mode: "コマンド練習",name: "ruby.csv",
          record: "record_command.csv"}
        ]

##メソッド定義##
#カウントダウンメソッド
def countdown
  3.times do
    print "."
    sleep(1)
  end
end

#記録の書き込みメソッド
def record(filename, day, time, scored, lists)
  File.open(filename,"a") do |wr|
    wr.puts <<-reco
------------------------------------
  開始日時:#{day}
  時間:#{time}秒
  得点:#{scored}点
  間違えた単語:
        reco
    if lists.empty? then
      wr.puts "\t無し"
    else
      lists.each do |key, valu|
        wr.puts "\t#{key} => #{valu}"
      end
    end
  end
end

#ファイルの読み込みメソッド
def select(filename)
  words = {}
  File.open(filename,"r") do |fo|
    fo.each_line do |line|
      line.chomp!
      c = line.split(",")
      words[c[0]] = c[1]
    end
  end
  return words
end

#ハイスコア読み取りメソッド
def highscore(filename)
  File.open(filename,"r") do |hs|
    hs.gets
    line = hs.gets.chomp
    h = line.split(':')
    return h[1].to_i
  end
end

#ハイスコア書き換えメソッド
def newrecord(filename,point)
  File.open(filename,"r+") do |nr|
    nr.gets
    nr.puts "ハイスコア:#{point}"
  end
end

##実行部##

#モード選択
puts "モード選択（数字を選択してください）"
puts "--------------------------------------"
n = 1
modes.each do |show|
  puts "#{n}.#{show[:mode]}"
  n += 1
end
puts "--------------------------------------"
print ">"

#問題ハッシュ作成
sel =Readline.readline.to_i
case sel
when 1,2,5
  puts "#{modes[sel-1][:mode]}を選択しました"
  question = select(modes[sel-1][:name])
when 3,4
  puts "#{modes[sel-1][:mode]}を選択しました"
  question = select(modes[sel-1][:name])
  question = question.invert  #値とキーを入れ替え
else
  puts "正しい数字を入力してください"
  exit
end

#ハイスコア表示
high = highscore(modes[sel-1][:record])
puts "ハイスコアは#{high}点です！"
puts "ハイスコア目指して頑張りましょう！！"


#テスト開始
puts <<-start
--------------------------------------
   問題は全部で#{question.size}問です
--------------------------------------
start
start_time = Time.now # 開始時間

#カウントダウン
countdown
puts "スタート！"
sleep(1)

#問題表示・解く
question.sort_by{rand}.each do |key, value|
  puts key
  print ">"
  ans = Readline.readline #回答
  #正誤判定
  if ans == value
    score += 1
    puts "--------------------------------------"
  else
    #間違いリスト追加
    wrong[:"#{key}"] = ans
    puts "残念！正解は#{value}です"
    puts "--------------------------------------"
  end
end

puts "終了です"
end_time = Time.now # 終了時刻

#結果の表示
time = end_time - start_time
#点数計算
point = 100 * score / question.size

puts <<-result
---------------結果発表---------------
          得点:#{point}点
          時間:#{time.round(2)}秒
-------------間違えた問題--------------
result
if wrong.empty? then
   puts "\t間違い無し\n\tよくできました！！"
else
  wrong.each do |key, value|
   puts "\t#{key} => #{value}"
  end
end


#ファイルへの記入
record(modes[sel-1][:record], start_time, time, point, wrong)
if high <= point
  newrecord(modes[sel-1][:record],point)
end
