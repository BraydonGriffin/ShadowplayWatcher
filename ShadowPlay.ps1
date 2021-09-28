$watcher = New-Object System.IO.FileSystemWatcher;
$watcher.Path = "C:\Shadowplay";
$watcher.Filter = "*.mp4";
$watcher.EnableRaisingEvents = $true;
$watcher.IncludeSubdirectories = $true;
$destination = "\\WinServer\Data\Shadowplay";

$action = {
    $path = $Event.SourceEventArgs.Name;
    Start-Sleep -Seconds 5
    $pathArray = $path.Split("\")
    $folder = $pathArray[0]
    $dst = "\\WinServer\Data\Shadowplay\$($folder)"
    Write-Host $dst
    New-Item -ItemType Directory -Force -Path "$($dst)"
    Copy-Item -Path $Event.SourceEventArgs.FullPath -Destination "$($dst)\$($folder)_$(get-date -f yyyy-MM-dd-HHmmss).mp4";
}

Unregister-Event -SourceIdentifier "Shadowplay"
Register-ObjectEvent -InputObject $watcher -EventName "Created" -SourceIdentifier "Shadowplay" -Action $action | Out-Null;
Add-Type -AssemblyName System.Drawing;
Remove-Item -Path (Join-Path $watcher.Path '\*') -Recurse
while ($true) { Wait-Event -SourceIdentifier "Shadowplay"; };
