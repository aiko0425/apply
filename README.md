# apply  
 今までに作成したプログラムの一覧です  

# 各プログラム  
 - register  
   - Overview  
     履修登録をするプログラムです。生徒側と教師側の2つのモードがあります。  
     学生側では履修する科目の登録と必要な残りの単位数を知ることができます。  
     教師側では開講する科目の登録を行うことができます。
     
   - Date  
     学生側のモードで学籍番号を入力するところがあります。  
     学籍番号はすべて数字で8桁で入力してください。  
     すでに登録されている学籍番号は「19241233」「19241273」「19241277」「19241278」です。  
     
   - File  
     「数字_all.csv」のファイルは学生が今までに登録した科目が記録されています。  
     「ローマ字2.csv」のファイルは教師側が登録した科目が記録されています。
  
 - wordtest  
   - Overview  
    タイピング練習をするプログラムです。「英和モード・和英モード・コマンド練習」等  
    5つのモードがあります。  
    各モードの問題はcsvファイルで管理しているので簡単に変更することができます。  
   
   - File  
     「record_ローマ字.csv」のファイルは各モードの実行記録とハイスコアが記録されています。  
     「ruby.csv」「type_easy.csv」「type_nomal.csv」これらのファイルは各モードの問題が記録されています。  
    
   - Change  
     - 既存のモードの問題に追加したい場合  
       「日本語　-->　英語(初級）」と「英語　-->　日本語(初級)」のモードは  
       「type_easy.csv」ファイルを書き換えてください。  
       「日本語　-->　英語(中級)」と「英語　-->　日本語(中級)」のモードは  
       「type_nomal.csv」ファイルを書き換えてください。  
       「コマンド練習」のモードは「ruby.csv」のファイルを書き換えてください。  
     - 新しいモードを追加する場合  
       問題用のcsvファイルと結果を記録するcsvファイルを用意してください  
       13行目のmodes配列に「モード名・問題ファイル・記録ファイル」の順で追加します  
       最後に98行目の「#問題ハッシュ作成」の部分のwhenにモード番号を追加します  
       和英・英和モードのように問題ファイルの日本語と英語を逆にして出題したい場合は「when3,4」に  
       問題をそのまま出題する場合は「when1,2,5」にモード番号を追加してください。

  - prog_login.py  
    - Overview  
      Progateのサイトにログインして修了レッスン一覧を取得しcsvファイルで保存するプログラムです。  
      
    - Date  
      正しくプログラムを実行するにはログインするアカウントのメールアドレスとパスワードが必要です。  
      メールアドレスは8行目のUSERの部分を、パスワードは9行目のPASSの部分を書き換えてください。  
      
    - Install  
      プログラムを動かすには以下のものが必要です  
      「selenimu」「Firefox」「BeautifulSoup4」「Geckodriver」  
      
    - Command  
      - Firefoxのインストール  
        sudo apt-get install -y firefox  
      - Seleniumのインストール  
        pip3 install selenium  
      - BeautifulSoup4のインストール  
        pip3 install beautifulsoup4  
  - chino_app
    - Overview  
      画像の数字を予測するアプリです。
    - Data  
      学習データにMNISTを用いています。学習用データ6万件、テストデータ1万件をダウンロードし、結合した「INPUT.csv」を学習データに利用。ただしGithubでは「INPUT.csv」が100Mbを超えたためアップロードされていません。
    - File  
      「chino.py」のファイルはchinoアプリを実行させるファイルです。
      「chino_load2.py」のファイルは学習するファイルです。
      「freq.pkl3」は学習したパラメーターが保存されているバイナリーファイルです。「chino_load2.py」を実行すると作成されます。

