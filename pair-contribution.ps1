# 设置循环次数（可以根据需要更改）
$iterations = 50

for ($i = 1; $i -le $iterations; $i++) {
    # 设置唯一分支名
    $timestamp = [int][double]::Parse((Get-Date -UFormat %s))
    $branch_name = "pair-commit-$timestamp-$i"

    # 创建并切换到新分支
    git checkout -b $branch_name

    # 添加示意内容（可改成其他文件和内容）
    Add-Content -Path "README.md" -Value "`nPaired contribution #$i on $(Get-Date)"

    # 添加改动并提交，包含 Co-authored-by 头
    git add .
    git commit -m "Paired contribution #$i`nCo-authored-by: jehovahBlack <luciferau@163.com>"

    # 推送新分支
    git push origin $branch_name

    # 创建 PR（注意默认合入主分支 main，如有不同请修改 --base）
    gh pr create --title "Paired contribution #$i" --body "GitHub badge attempt #$i" --base main --head $branch_name

    # 合并 PR 并删除分支（使用 merge 模式）
    gh pr merge --merge --delete-branch

    # 暂停 2 秒，避免时间戳重复（可选）
    Start-Sleep -Seconds 60
}
