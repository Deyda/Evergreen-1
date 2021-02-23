Function Get-EvergreenApp {
    <#
        .SYNOPSIS
            Query an application function and return the output
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNull()]
        [System.String] $Name
    )

    # Build a path to the application function
    $Function = Join-Path -Path $MyInvocation.MyCommand.Module.ModuleBase -ChildPath "Apps\Get-$Name.ps1"

    # Test that the function exists and run it to return output
    Write-Verbose -Message "$($MyInvocation.MyCommand): Test path: $Function."
    If (Test-Path -Path $Function) {
        try {
            $Output = . Get-$Name
        }
        catch {
            Throw $_
        }
        If ($Output) { Write-Output -InputObject $Output }
    }
    Else {
        Write-Error -Message "Cannot find application: $Name."
    }
}
