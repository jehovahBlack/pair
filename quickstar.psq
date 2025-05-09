# 设置重复次数
$repeat_count = 10  # 可以调整为更高的次数

# 设置 GitHub 用户信息
$co_author_name = "hesphoros"
$co_author_email = "hesphoros@gmail.com"
$pr_title = "Quickdraw Contribution"
$pr_body = "Quickdraw PR created automatically"



for ($i = 1; $i -le $repeat_count; $i++) {
    Write-Host "Starting PR operation #$i..."

    # Create a unique branch name
    $timestamp = Get-Date -Format "yyyyMMddHHmmssfff"
    $branch_name = "quickdraw-$timestamp"

    git checkout -b $branch_name

    # Make a small change and commit
    Add-Content -Path "README.md" -Value "`nQuickdraw commit #$i - $(Get-Date)"

    git add README.md
    git commit -m "Quickdraw commit #$i`n`nCo-authored-by: $co_author_name <$co_author_email>"

    git push origin $branch_name

    # Create a PR
    gh pr create --title "$pr_title #$i" --body "$pr_body #$i" --base main --head $branch_name

    # Merge and delete the branch
    gh pr merge --merge --delete-branch

    Write-Host "PR #$i has been completed."

    Start-Sleep -Seconds 5  # Set a sleep time to avoid excessive operations
}

Write-Host "All $repeat_count operations are completed! Quickdraw achievement will be boosted soon!"
