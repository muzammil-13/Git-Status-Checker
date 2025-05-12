Write-Host "🔍 Scanning projects..."
$projects = Get-ChildItem -Directory
foreach ($project in $projects) {
    if (Test-Path "$($project.FullName)\.git") {
        Write-Host "✅ Git initialized in $($project.Name)"
        Set-Location "$($project.FullName)"
        $remoteUrl = git remote get-url origin 2>$null
        if ($remoteUrl -match "github.com") {
            Write-Host "🔗 Pushed to GitHub: $remoteUrl"
        } else {
            Write-Host "❌ Not pushed to GitHub"
        }
        Set-Location ..
    } else {
        Write-Host "⚠️ Git not initialized in $($project.Name)"
    }
}
Write-Host "✔️ Done!"