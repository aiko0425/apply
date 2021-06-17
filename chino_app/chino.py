import tkinter as tk
import tkinter.filedialog as fd
import PIL.Image 
import PIL.ImageTk
import cgi, os.path
import joblib
# 機械学習で使うモジュール
import sklearn.datasets
import sklearn.svm
import numpy
from PIL import Image, ImageOps

# 画像ファイルを数値リストに変換する
def imageToData(filename):
    # 画像を8x8のグレースケールに変換
    grayImage = PIL.Image.open(filename).convert("L")
    grayImage = ImageOps.invert(grayImage)
    #grayImage.show()
    grayImage = grayImage.resize((28,28),PIL.Image.ANTIALIAS)
    # その画像を表示する
    dispImage = PIL.ImageTk.PhotoImage(grayImage.resize((300,300)))
    imageLabel.configure(image = dispImage)
    imageLabel.image = dispImage
    # 数値リストに変換
    numImage = numpy.asarray(grayImage, dtype = float)
    #print(numImage)
    numImage = numImage / 256
    #numImage = numpy.floor(16 - 16 * (numImage / 256))
    numImage = numImage.flatten()
    numImage = list(numImage)
    #print(numImage)
    #print(type(numImage))
    #print(len(numImage))
    return numImage

# 数字を予測する
def predictDigits(data):
    # 学習データを読み込む
    pklfile = os.path.dirname(__file__) + "/freq.pkl3"
    clf = joblib.load(pklfile)
    # 予測結果を表示する
    n = clf.predict([data])
    textLabel.configure(text = "この画像は"+str(n)+"です！")



# ファイルダイアログを開く
def openFile():
    fpath = fd.askopenfilename()
    if fpath:
        # 画像ファイルを数値リストに変換する
        data = imageToData(fpath)
        # 数字を予測する
        predictDigits(data)

# アプリのウィンドウを作る
root = tk.Tk()
root.geometry("400x400")

btn = tk.Button(root, text="ファイルを開く", command = openFile)
imageLabel = tk.Label()
btn.pack()
imageLabel.pack()

# 予測結果を表示するラベル
textLabel = tk.Label(text="手書きの数字を認識します！") 
textLabel.pack()

tk.mainloop()
