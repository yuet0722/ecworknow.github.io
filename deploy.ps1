# 先生成網站靜態檔案
hugo

# 檢查 public 是否是被加入 Git (index) 的子模組或資料夾
$publicStatus = git ls-files --stage public 2>$null

if ($publicStatus) {
    Write-Output "發現 public 資料夾在 Git index，正在移除中..."
    git rm -r --cached public
    git commit -m "移除 public 資料夾，避免嵌套 git 倉庫"
}

# 新增所有變更
git add .

# 取得時間戳記
$time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# 提交
git commit -m "自動部署於 $time"

# 推送到遠端
git push