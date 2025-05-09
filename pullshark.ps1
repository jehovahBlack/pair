# 设置：修改为你自己的信息
$repeat_count = 2  # 提交次数：建议每次不要超过 100
$co_author_name = "jehovahBlack"
$co_author_email = "luciferau@163.com"
$pr_title = "Boost Pull Shark"
$pr_body = "Auto contribution by hesphoros for Pull Shark"

for ($i = 1; $i -le $repeat_count; $i++) {
    Write-Host "➡️ 开始第 $i 次 PR 操作..."

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

    Write-Host "✅ 第 $i 次 PR 已完成。等待 GitHub 同步 Pull Shark 成就。`n"

    Start-Sleep -Seconds 5
}

Write-Host "🎉 所有 $repeat_count 次操作已完成！Pull Shark 成就即将提升！"
