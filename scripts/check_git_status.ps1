param(
    [string]$Root = "."
)

Write-Host "🔍 Scanning projects in $Root..."
if (-not (Test-Path -Path $Root)) {
    Write-Error "Path '$Root' does not exist."
    exit 1
}

$projects = Get-ChildItem -Path $Root -Directory
foreach ($project in $projects) {
    $gitPath = Join-Path $project.FullName ".git"
    if (Test-Path $gitPath) {
        Write-Host "✅ Git initialized in $($project.Name)"
        $remoteUrl = $null
        try {
            $remoteUrl = git -C $project.FullName remote get-url origin 2>$null
        } catch {
            # git -C might not be available; fallback to directory change
        }
        if (-not $remoteUrl) {
            Push-Location $project.FullName
            $remoteUrl = git remote get-url origin 2>$null
            Pop-Location
        }
        if ($remoteUrl -and $remoteUrl -match "github.com") {
            Write-Host "🔗 Pushed to GitHub: $remoteUrl"
        } elseif ($remoteUrl) {
            Write-Host "🔗 Remote: $remoteUrl (not GitHub)"
        } else {
            Write-Host "❌ No 'origin' remote found"
        }
    } else {
        Write-Host "⚠️ Git not initialized in $($project.Name)"
    }
}
Write-Host "✔️ Done!"
