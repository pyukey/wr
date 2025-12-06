Import-Module ActiveDirectory -ErrorAction SilentlyContinue

$users = @(
"otto.bot",
"meme.lord",
"car.guy",
"ai.driver",
"not.a.robot",
"eliza.turing",
"guido.python",
"rusty.bolt",
"benny.beamer",
"chevy.nova",
"tesla.lol",
"jeep.wrangler",
"civic.duty",
"vroom.vroom",
"irony.magnet",
"ford.focus",
"auto.mated",
"mustang.sally",
"luke.oil",
"piston.cup",
"otto.mated",
"last.place",
"speed.limiter",
"drift.king",
"clutch.burn",
"turn.signal",
"reverse.gear",
"driver.error",
"404.notfound",
"meme.car",
"pass.word",
"fuel.inefficient",
"giga.chad",
"chrome.rim",
"safety.test",
"taxi.yellow",
"otto.pilot",
"seat.warmer",
"danica.drive",
"hybrid.lol"
)

function New-CTFPassword {
    $upper = [char[]](65..90) | Get-Random -Count 3
    $lower = [char[]](97..122) | Get-Random -Count 3
    $digit = [char[]](48..57) | Get-Random -Count 3
    $special = ("!@#$%^&*()_+" | Select-Object -ExpandProperty ToCharArray) | Get-Random -Count 3
    ($upper + $lower + $digit + $special | Sort-Object {Get-Random}) -join ""
}

foreach ($user in $users) {
    $password = New-CTFPassword
    $securePass = ConvertTo-SecureString $password -AsPlainText -Force

    $domainChanged = $false
    $localChanged = $false

    # DOMAIN
    try {
        Set-ADAccountPassword -Identity $user -NewPassword $securePass -Reset -ErrorAction Stop
        Set-ADUser $user -ChangePasswordAtLogon $false
        $domainChanged = $true
    } catch {}

    # LOCAL using net user
    net user "$user" "$password" 2>$null
    if ($LASTEXITCODE -eq 0) {
        $localChanged = $true
    }

    Write-Output "$user,$password,Domain:$domainChanged,Local:$localChanged"
}
