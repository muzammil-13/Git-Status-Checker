#!/bin/bash
echo "🔍 Scanning projects..."
for dir in */ ; do
    if [ -d "$dir/.git" ]; then
        echo "✅ Git initialized in $dir"
        cd "$dir"
        remote_url=$(git remote get-url origin 2>/dev/null)
        if [[ $remote_url == *"github.com"* ]]; then
            echo "🔗 Pushed to GitHub: $remote_url"
        else
            echo "❌ Not pushed to GitHub"
        fi
        cd ..
    else
        echo "⚠️ Git not initialized in $dir"
    fi
done
echo "✔️ Done!"