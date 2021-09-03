Function Step-Main {
    Param (
        [string]$Command = "default"
    )

    Process {
        switch ( $Command ) {
            login {
                $Username = $( Read-Host "Please provide your GitHub username" )
                $SecurePassword = $( Read-Host -AsSecureString "Please provide a GitHub token with access to publish packages" )
                ConvertFrom-SecureString -SecureString $SecurePassword | docker login https://docker.pkg.github.com -u $Username --password-stdin
            }
            build { docker build -t ayanobot/lavalink:main . }
            deploy { docker push ayanobot/lavalink:main }
            remove { docker rmi -f ayanobot/lavalink }
            default { Write-Host "Unrecognized command, please try again" -ForegroundColor Red }
        }
    }
}

Step-Main @args
