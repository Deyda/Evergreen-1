Function Export-EvergreenManifest {
    <#
        .SYNOPSIS
            Returns a hashtable of an app manifest
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns", "")]
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $False, Position = 0)]
        [ValidateNotNull()]
        [System.String] $Name = "Template"
    )
    
    Write-Output -InputObject (Get-FunctionResource -AppName $Name)
    #Write-Output -InputObject $script:resourceStrings
}
