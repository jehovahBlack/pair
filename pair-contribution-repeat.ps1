# 设置要重复的次数
$repeat_count = 10  # 可修改此值来控制重复次数

# 设置 GitHub 协作者信息
$co_author_name = "jehovahBlack"
$co_author_email = "1481458358@qq.com"

# 设置 GitHub PR 标题和描述
$pr_title = "Paired contribution"
$pr_body = "GitHub badge attempt"

# 循环执行多个提交
for ($i = 1; $i -le $repeat_count; $i++) {
    Write-Host "正在进行第 $i 次提交..."

    # 设置唯一的分支名
    $timestamp = [int][double]::Parse((Get-Date -UFormat %s))
    $branch_name = "pair-commit-$timestamp"

    # 创建并切换到新分支
    git checkout -b $branch_name

    # 添加示意内容（可以修改为其他文件）
    Add-Content -Path "README.md" -Value "`nPaired contribution on $(Get-Date)"

    # 添加改动并提交，包含 Co-authored-by 头
    git add .
    git commit -m "Paired contribution`nCo-authored-by: $co_author_name <$co_author_email>"

    # 推送新分支
    git push origin $branch_name

    # 创建 PR
    gh pr create --title "$pr_title #$i" --body "$pr_body #$i" --base main --head $branch_name

    # 合并 PR 并删除分支（使用 merge 模式）
    gh pr merge --delete-branch --squash

    Write-Host "第 $i 次提交已完成！"
}

Write-Host "所有提交已完成！"
