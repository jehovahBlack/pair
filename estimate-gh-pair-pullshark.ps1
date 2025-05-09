# 请确保 gh CLI 已登录，并在你的账户下运行
# 需要安装 jq：https://stedolan.github.io/jq/

$githubUser = "hesphoros"  # 替换为你的用户名
$repo = "jehovahBlack/pair"  # 替换为你的仓库路径

# 获取已合并的 PR 列表（你创建的）
$prs = gh pr list --author $githubUser --state merged --json number,title,commits --repo $repo | ConvertFrom-Json

$totalMergedPRs = $prs.Count
$coAuthoredCount = 0

foreach ($pr in $prs) {
    $commitDetails = gh pr view $pr.number --repo $repo --json commits --jq ".commits[].message"

    foreach ($msg in $commitDetails) {
        if ($msg -match "Co-authored-by:") {
            $coAuthoredCount++
            break  # 每个 PR 至多统计一次
        }
    }
}

Write-Host "`n Pull Shark 合并 PR 总数: $totalMergedPRs"

switch ($totalMergedPRs) {
    {$_ -lt 4} {" Pull Shark 等级:  Bronze"}
    {$_ -lt 16} {" Pull Shark 等级:  Silver"}
    {$_ -lt 64} {" Pull Shark 等级:  Gold"}
    default {" Pull Shark 等级:  Platinum"}
}

Write-Host "`n Pair Extraordinaire 共同协作 PR 总数: $coAuthoredCount"

switch ($coAuthoredCount) {
    {$_ -lt 4} {" Pair Extraordinaire 等级:  Bronze"}
    {$_ -lt 16} {" Pair Extraordinaire 等级:  Silver"}
    {$_ -lt 64} {" Pair Extraordinaire 等级:  Gold"}
    default {" Pair Extraordinaire 等级:  Platinum"}
}
