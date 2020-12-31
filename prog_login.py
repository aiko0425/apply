from selenium.webdriver import Firefox, FirefoxOptions
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import datetime
import csv

USER = "aaaa"
PASS = "bbbb"

# Firefoxのドライバを得る --- (※1)
options = FirefoxOptions()
#options.add_argument('-headless')
browser = Firefox(options=options)

# ログインページにアクセス --- (※2)
url = "https://prog-8.com/users/sign_in"
browser.get(url)
print('ログインページにアクセスしました')


##login-page > div > div:nth-child(1) > div.sc-fzokOt.eLnZFa > div:nth-child(2) > input
##login-page > div > div:nth-child(1) > div.sc-fzokOt.eLnZFa > div:nth-child(3) > input
#文字を入力
e = browser.find_element_by_css_selector("div:nth-child(2) > input")
e.clear()
e.send_keys(USER)
e = browser.find_element_by_css_selector("div:nth-child(3) > input")
e.clear()
e.send_keys(PASS)


#login-page > div > div:nth-child(1) > div.common_component__StyledLoginBtnWrapper-qtnxtj-0.cuoUwg > a
#フォームを送信
frm = browser.find_element_by_css_selector("div.common_component__StyledLoginBtnWrapper-qtnxtj-0.cuoUwg > a")
frm.click()
print('情報を入力してログインボタンを押しました')

#ページのロードまで待機
WebDriverWait(browser, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, "#web-completed-lessons")))

#web-completed-lessons > a
#修了レッスン一覧のURL
a = browser.find_element_by_css_selector("#web-completed-lessons > a")
url_all = a.get_attribute('href')
print('修了レッスン一覧URL = ',url_all)

#ページ表示
browser.get(url_all)
browser.implicitly_wait(10)



#保存するファイル名設定
now = datetime.datetime.now()
filename = 'prog_log' + now.strftime('%Y%m%d_%H%M') + '.csv'
#ファイル書き込み
file = open(filename, 'x')
titles = browser.find_elements_by_class_name("completed-lesson-card__name")
for i in titles:
    file.writelines(i.text)
file.close()

print('情報をファイルに書きこみ保存しました')

#ブラウザーを閉じる
browser.quit()
