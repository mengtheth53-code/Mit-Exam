Write-Host "Pushing project to GitHub repository (https://github.com/mengtheth53-code/Mit-Exam.git)..." -ForegroundColor Cyan
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "Source code: https://github.com/mengtheth53-code/Mit-Exam" -ForegroundColor Cyan
    Write-Host "GitHub Pages Demo (after workflow completes): https://mengtheth53-code.github.io/Mit-Exam/" -ForegroundColor Yellow
} else {
    Write-Host "`n Push failed." -ForegroundColor Red
    Write-Host "Please ensure the repository exists on GitHub by clicking:" -ForegroundColor Yellow
    Write-Host "👉 https://github.com/new?name=Mit-Exam" -ForegroundColor Cyan
    Write-Host "Then re-run this script." -ForegroundColor Yellow
}
