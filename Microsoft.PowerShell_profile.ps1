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

function timestamp { Get-Date -Format "yyyy-MM-dd_HH-mm-ss" }

# List
function ll {
    Get-ChildItem -Force | Format-Table -AutoSize
}

# Reload Profile file
function reload { . $PROFILE }  # Перезагрузить профиль

# Winget update
function wupall {
    winget upgrade --all --include-unknown
    Write-Host "The update is complete!" -ForegroundColor Green
}

# NET
function extip1 {
    $ip = (Invoke-WebRequest -Uri "https://api.ipify.org").Content.Trim()
    Write-Host "Внешний IP: " -NoNewline
    Write-Host $ip -ForegroundColor Green
}

function extip2 {
    $ip = (Invoke-WebRequest -Uri "https://api.ipify.org").Content.Trim()
    Write-Host "Внешний IP: " -NoNewline
    Write-Host $ip -ForegroundColor Yellow
    
    # Дополнительная информация (если нужно)
    try {
        $info = Invoke-RestMethod -Uri "https://ipinfo.io/$ip/json" -ErrorAction Stop
        Write-Host "Провайдер: $($info.org)" -ForegroundColor Cyan
        Write-Host "Город: $($info.city), $($info.region), $($info.country), $($info.country_name)" -ForegroundColor Cyan
		Write-Host "Тайм зона: $($info.timezone)" -ForegroundColor Green
    }
    catch {
        Write-Warning "Не удалось получить дополнительную информацию"
    }
}

function ports { netstat -ano | Select-String "LISTEN" }  # Слушающие порты


# navigation
function docs { cd ~\Documents }
function downloads { cd j:\Downloads\ }
function desktop { cd ~\Desktop }
function proj { cd ~\projects } 

# Процессы
function pstop { Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 }
function psram { Get-Process | Sort-Object WS -Descending | Select-Object -First 10 }
function killn { Stop-Process -Name $args[0] -Force }  # Убить по имени
function killp { Stop-Process -Id $args[0] -Force }    # Убить по ID

# System info
function sysinfo { Get-ComputerInfo }  # Информация о системе
function pslist { Get-Process | Sort-Object CPU -Descending }  # Процессы по CPU
function ram { Get-CimInstance Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory }
function disk { Get-PSDrive C | Select-Object Used, Free }
function stats {
    # RAM
    $os = Get-CimInstance Win32_OperatingSystem
    $ramUsed = [math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)/1MB, 1)
    $ramTotal = [math]::Round($os.TotalVisibleMemorySize/1MB, 1)
    $ramPct = [math]::Round(($ramUsed/$ramTotal)*100)
    
    # Disk
    $drive = Get-PSDrive C
    $diskUsed = [math]::Round($drive.Used/1GB, 1)
    $diskTotal = [math]::Round(($drive.Used + $drive.Free)/1GB, 1)
    $diskPct = [math]::Round(($diskUsed/$diskTotal)*100)
    
    Write-Host "RAM:  $ramUsed/$ramTotal GB ($ramPct%)" -ForegroundColor $(if ($ramPct -gt 80) { "Red" } else { "Green" })
    Write-Host "Disk: $diskUsed/$diskTotal GB ($diskPct%)" -ForegroundColor $(if ($diskPct -gt 85) { "Red" } elseif ($diskPct -gt 70) { "Yellow" } else { "Green" })
}

# Информация о системе
function uptime { (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime }
function drives { Get-PSDrive -PSProvider FileSystem }
function env { Get-ChildItem Env: | Sort-Object Name }
#Environment
function path { $env:Path -split ';' | ForEach-Object { Write-Host $_ } }
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


# Мониторинг
function watch { param($cmd) while($true) { Clear-Host; Invoke-Expression $cmd; Start-Sleep -Seconds 2 } }
function mem { Get-Process | Sort-Object WS -Descending | Select-Object -First 10 Name, @{Name="Mem(MB)";Expression={[math]::Round($_.WS/1MB,2)}} }

# Службы
function srv-running { Get-Service | Where-Object Status -eq 'Running' }
function srv-stopped { Get-Service | Where-Object Status -eq 'Stopped' }

# Базовые команды Linux
function grep { Select-String -Pattern $args[0] -Path $args[1] }
function wget { Invoke-WebRequest -Uri $args[0] -OutFile $args[1] }
function curl { Invoke-WebRequest -Uri $args[0] }
function touch { New-Item -ItemType File -Path $args[0] }
function mkdirp { New-Item -ItemType Directory -Path $args[0] -Force }
function rmr { Remove-Item -Recurse -Force $args[0] }
function cp { Copy-Item -Recurse $args[0] $args[1] }
function mv { Move-Item $args[0] $args[1] }

# Права и владельцы
function perms { Get-Acl $args[0] | Format-List }
function takeown { takeown /f $args[0] /r /d y }  # Взять владение

# История
function hist { Get-History | Select-Object Id, CommandLine, StartExecutionTime }
function runlast { Invoke-History -Id (Get-History)[-1].Id }

# Пользователи
function whoami { $env:USERNAME }
function users { Get-LocalUser | Select-Object Name, Enabled, LastLogon }
