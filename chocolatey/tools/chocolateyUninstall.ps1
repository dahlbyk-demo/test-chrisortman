try {
    $binRoot = Get-BinRoot
    $poshgitPath = join-path $binRoot 'poshgit'

    try {
      if (test-path($poshgitPath)) {
        Write-Host "Attempting to remove `'$poshgitPath`'."
        remove-item $poshgitPath -recurse -force
      }
    } catch {
      Write-Host "Could not remove `'$poshgitPath`'"
    }

    if(Test-Path $PROFILE) {
        $oldProfile = @(Get-Content $PROFILE)
        $newProfile = @()

        foreach($line in $oldProfile) {
            if ($line -like '*PoshGitPrompt*') { continue; }
            if ($line -like '*Load posh-git example profile*') { continue; }
            if ($line -like '*posh-git*profile.example.ps1*') { continue; }

            $newProfile += $line
        }
        Set-Content -path $profile -value $newProfile -Force
    }
} catch {
  try {
    if($oldProfile){ Set-Content -path $PROFILE -value $oldProfile -Force }
  }
  catch {}
  throw
}

