### file should be kept in c:\Users\<user_name>\Documents\PowerShell\

##oh-my-posh themes
# to watch all themes: Get-PoshThemes
# to use theme in console:
# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))

#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\clean-detailed.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\easy-term.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kushal.omp.json" | Invoke-Expression

## write 'pwsh' in alacrity terminal to use PS7

## User Alias
New-Alias -Name gh -Value Get-Help

function ll {
    Get-ChildItem -Force | Format-Table -AutoSize
}

function envn {$env:Path -split ';'}

function envn2 {
    $paths = $env:Path.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
    for ($i = 0; $i -lt $paths.Count; $i++) {
        if (Test-Path $paths[$i]) {
            Write-Host "$($i+1). $($paths[$i])" -ForegroundColor Green
        } else {
            Write-Host "$($i+1). $($paths[$i])" -ForegroundColor Red
        }
    }
}

function wupall {
    winget upgrade --all --include-unknown
    Write-Host "The update is complete!" -ForegroundColor Green
}

# NET
#function myip { (Invoke-WebRequest -Uri "https://2ip.ru").Content }  # Внешний IP
function ports { netstat -ano | Select-String "LISTEN" }  # Слушающие порты

# System info
function sysinfo { Get-ComputerInfo }  # Информация о системе
function pslist { Get-Process | Sort-Object CPU -Descending }  # Процессы по CPU

# navigation
function docs { cd ~\Documents }
function downloads { cd j:\Downloads\ }
function desktop { cd ~\Desktop }
function proj { cd ~\projects } 


