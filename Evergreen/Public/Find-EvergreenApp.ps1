Function Find-EvergreenApp {
    <#
        .SYNOPSIS
            Lists the applications that Evergreen supports
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False, Position = 0)]
        [ValidateNotNull()]
        [System.String] $Name
    )

    # Get application resource strings from its manifest
    $params = @{
        Path        = Join-Path -Path $MyInvocation.MyCommand.Module.ModuleBase -ChildPath "Manifests"
        Filter      = "*.json"
        ErrorAction = "SilentlyContinue"
    }
    Write-Verbose -Message "$($MyInvocation.MyCommand): Search path: $($params.Path)."
    $Manifests = Get-ChildItem @params

    ForEach ($manifest in $Manifests) {
        try {
            $Json = Get-Content -Path $manifest.FullName | ConvertFrom-Json
        }
        catch {
            Throw $_
        }
        $PSObject = [PSCustomObject] @{
            Name        = [System.IO.Path]::GetFileNameWithoutExtension($manifest.Name)
            Application = $Json.Name
            Link        = $Json.Source
        }
        Write-Output -InputObject $PSObject
    }
}
