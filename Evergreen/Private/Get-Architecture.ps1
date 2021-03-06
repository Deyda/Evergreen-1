Function Get-Architecture {
    [OutputType([System.String])]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [System.String] $String
    )

    Switch -Regex ($String.ToLower()) {
        "amd64" { $architecture = "AMD64" }
        "arm64" { $architecture = "ARM64" }
        "arm32" { $architecture = "ARM32" }
        "win64" { $architecture = "x64"; Break }
        "win32" { $architecture = "x86"; Break }
        "x86_64" { $architecture = "x64"; Break }
        "x64" { $architecture = "x64"; Break }
        "64-bit" { $architecture = "x64"; Break }
        "32-bit" { $architecture = "x86"; Break }
        "-x86" { $architecture = "x86"; Break }
        "x86" { $architecture = "x86"; Break }
        "fxdependent" { $architecture = "fxdependent" }
        Default {
            Write-Verbose -Message "$($MyInvocation.MyCommand): Architecture not found, defaulting to x86."
            $architecture = "x86"
        }
    }
    Write-Output -InputObject $architecture
}
