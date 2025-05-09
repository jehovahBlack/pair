$OutputEncoding = New-Object -typename System.Text.UTF8Encoding

# 设置：修改为你自己的信息
$repeat_count = 50  # 提交次数：建议每次不要超过 100
$co_author_name = "jehovahBlack"
$co_author_email = "luciferau@163.com"
$pr_title = "Boost Pull Shark"
$pr_body = "Auto contribution by hesphoros for Pull Shark"

for ($i = 1; $i -le $repeat_count; $i++) 
{
    Write-Host "开始第 $i 次 PR 操作..."

    # 创建唯一分支名
    $timestamp = Get-Date -Format "yyyyMMddHHmmssfff"
    $branch_name = "pullshark-$timestamp"

    git checkout -b $branch_name

    # 添加文件内容（确保有变更）
    Add-Content -Path "README.md" -Value "`nPull Shark boost $i - $(Get-Date)"

    git add README.md
    git commit -m "Boost Pull Shark #$i`n`nCo-authored-by: $co_author_name <$co_author_email>"

    git push origin $branch_name

    # 创建 PR
    gh pr create --title "$pr_title #$i" --body "$pr_body #$i" --base main --head $branch_name

    # 合并并删除分支
    gh pr merge --merge --delete-branch

    Write-Host "✅ PR #$i completed. Waiting for GitHub to sync Pull Shark achievement."


    Start-Sleep -Seconds 10
}

Write-Host "All $repeat_count operations completed! Pull Shark achievement will be boosted soon!"

