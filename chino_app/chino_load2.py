#ランダムサーチのインポート
from sklearn.model_selection import RandomizedSearchCV
#ランダムフォレストのインポート
from sklearn.ensemble import RandomForestClassifier
#ファイル保存のためのjoblibインポート
import joblib


# CSVファイルを読んで学習用データに整形 
def load_csv(fname):
    labels = []
    images = []
    with open(fname, "r") as f:
        for line in f:
            cols = line.split(",")
            if len(cols) < 2: continue
            labels.append(int(cols.pop(0)))
            vals = list(map(lambda n: int(n) / 256, cols))
            images.append(vals)
    return {"labels":labels, "images":images}

#MNISTデータの読み込み
data = load_csv("mnist/INPUT.csv")

#ランダムサーチ
params = {
    'n_estimators':[200,250],
    'max_features':[70,73],
    'max_depth':[70,80],
    'min_samples_split':[3,4,5]
}

#ランダムサーチを実行
clf =  RandomizedSearchCV(RandomForestClassifier(),
params,
cv = 3,
verbose = True,
n_jobs = -1,
n_iter =20
)

#学習
clf = clf.fit(data["images"], data["labels"])

#正答率表示
print("各正解率=", clf)
print("正解率=", clf.mean())
print(clf.best_estimator_)
print(clf.best_params_)

#学習データを保存する
joblib.dump(clf, "freq.pkl3")
print("ok")