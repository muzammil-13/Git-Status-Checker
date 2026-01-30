param(
    [string]$Root = "."
)

Write-Host "🔍 Scanning projects in $Root..."
$projects = Get-ChildItem -Path $Root -Directory
foreach ($project in $projects) {
    $gitPath = Join-Path $project.FullName ".git"
    if (Test-Path $gitPath) {
        Write-Host "✅ Git initialized in $($project.Name)"
        $remoteUrl = git -C $project.FullName remote get-url origin 2>$null
        if ($remoteUrl -and $remoteUrl -match "github.com") {
            Write-Host "🔗 Pushed to GitHub: $remoteUrl"
        } else {
            Write-Host "❌ Not pushed to GitHub"
        }
    } else {
        Write-Host "⚠️ Git not initialized in $($project.Name)"
    }
}
Write-Host "✔️ Done!"