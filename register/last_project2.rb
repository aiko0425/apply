##変数##
#クラスター配列
kurasuta = ["人間・環境クラスター","心理・文化クラスター",
            "家族・地域社会クラスター","政治・公共政策クラスター", 
            "経済・ビジネスクラスター","情報クラスター","国際社会クラスター"]
#file配列
file = ["human2.csv","sinri2.csv","family2.csv","seizi2.csv","keizai2.csv",
        "zyouhou2.csv","national2.csv"]
#前期・後期配列
seasons = ["前期","後期"]

#質問配列
questions = ["登録する教科名", "教員名", "曜日", "時間", "単位"]

#必修配列
musts = ["必修","必修ではない"]

#生徒ファイル配列
numbers = ["19241273_all.csv","19241233_all.csv","19241277_all.csv"]

##メソッド定義##
#教師実行メソッド
def teacher(kurasuta, file, seasons, questions, musts)
  #登録する教科情報配列
  subjects = []

  #登録する手順（繰り返し）
  while true
    #今から登録する教科情報配列
    subject = []

    #クラスター選択
    puts "-"*30
    puts "クラスターを選択してください"

    #一覧出力
    kurasuta.each_with_index do |kura, index|
      puts "#{index+1}.#{kura}クラスター"
    end
    print '選択:'
    classes = gets.chomp.to_i - 1

    #前期後期の選択
    puts <<~EOS
    ------------------------------
    #{seasons[0]}の教科ですか？#{seasons[1]}の教科ですか？
    1.#{seasons[0]} 2.#{seasons[1]}
    EOS
    print '選択:'
    subject.push seasons[gets.chomp.to_i - 1]  #教科情報の配列に追加

    #教科情報の入力
    questions.each do |qes|
      puts "-"*30
      puts "#{qes}を入力してください"
      print'入力:'
      subject.push gets.chomp  #教科情報の配列に追加
    end

    #必修か必修でないか
    puts "-"*30
    puts <<~EOS
    必修ですか？
    1.#{musts[0]}　2.#{musts[1]}
    EOS
    print '選択:'
    subject.push musts[gets.chomp.to_i - 1]

    #ファイルへの書き込み
    File.open(file[classes], "a") do |fo|
      fo.puts "#{subject[1]},#{subject[5]},#{subject[2]},#{subject[0]},#{subject[3]},#{subject[4]},#{subject[6]}"
    end

    #繰り返しの終了
    puts <<~FIN
    他に追加する教科はありますか？
    1.はい　2.いいえ
    FIN
    print '選択:'
    repeat = gets.chomp.to_i
    if repeat == 2
      break
    end
  end
end



#生徒実行メソッド
def student(numbers,kurasuta,file)
  #登録する教科情報配列
  output = []

  #生徒のファイルを選択
   puts "学籍番号を入力してください"
   print '入力:'
   number = gets.chomp
   number += "_all.csv"
   #新規生徒ファイルの場合ヘッダー追加
   if !numbers.include?(number)
     File.open(number, "a"){|head|
       head.puts "科目名,単位,教員,前期/後期,曜日,時間,必修"
     }
   end
   
  #登録する手順(繰り返し)
  while true
    #今から登録する教科情報配列
    hash = []

    #クラスター選択
    puts "-"*30
    puts "クラスターを選択してください"
    index = 1
    kurasuta.each do |kurasutas|
      puts "  #{index}.#{kurasutas}"
      index += 1
    end
    print '選択:'
    kura = gets.chomp.to_i - 1

    #教科選択
    puts "-"*30
    puts "登録する教科を選んでください"

    #教科一覧出力
    File.open(file[kura],"r") do |fp|
      index2 = 1
      fp.gets
      fp.each_line do |line|
        line.chomp!
        c = line.split(",")
        puts "　#{index2},#{c[0]}, #{c[1]}, #{c[2]}, #{c[3]}, #{c[4]}, #{c[5]}, #{c[6]}"
        index2 += 1
      end
    end
    print '選択:'
    register = gets.chomp.to_i
    puts "-"*30

    #ファイル入力
    File.open(file[kura],"r"){|file|
      output.push(file.readlines[register])
    }
    File.open(file[kura],"r"){|file|
      hash.push(file.readlines[register])
    }
    File.open(number,"a") do |fo|
      hash.each do |hashes|
        fo.puts "#{hashes}"
      end
    end
    
    #繰り返しの終了
    puts <<~STU
    他に登録しますか？
    1.はい　2.いいえ
    STU
    print '選択:'
    add = gets.chomp.to_i
    if add == 2
      break
    end
  end
  puts "-------------------------------------"
  puts "登録した教科"
  output.each do |outputs|
    puts "　#{outputs}"
  end
  puts "-------------------------------------"
  puts "合計単位"
  sum = 0
  #単位の計算
  File.open(number,"r") do |fp|
    fp.gets
    fp.each_line do |line|
      line = line.chomp
      c = line.split(',')
      sum += c[1].to_i
    end
  end
  last = 132 - sum
  puts "合計: #{sum}単位"
  puts "卒業までに必要な単位: #{last}単位"
end

##実行部分##

puts <<~QST
     履修登録をするシステムです
     ------------------------------
     あなたは教員ですか、生徒ですか？
     1.教員　2.生徒
     QST
print '選択:'
select = gets.chomp.to_i

case select
#教師側のプログラム
when 1
  teacher(kurasuta, file, seasons, questions, musts)


#生徒側のプログラム
when 2
  student(numbers,kurasuta, file)
end

