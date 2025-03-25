### file should be kept in c:\Users\<user_name>\Documents\PowerShell\

##oh-my-posh themes
# to watch all themes: Get-PoshThemes
# to use theme in console:
# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\clean-detailed.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\easy-term.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kushal.omp.json" | Invoke-Expression


## Alias
New-Alias -Name gh -Value Get-Help
function ll {ls -Hidden && ls}
function wupall {winget upgrade --all --include-unknown}
