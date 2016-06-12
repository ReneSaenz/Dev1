#################################################################################################################################
#  Name        : Configure-WinRM.ps1                                                                                            #
#                                                                                                                               #
#  Description : Configures the WinRM on a local machine                                                                        #
#                                                                                                                               #
#  Arguments   : HostName, specifies the FQDN of machine or domain                                                           #
#################################################################################################################################

param
(
    [Parameter(Mandatory = $true)]
    [string] $HostName
)

#################################################################################################################################
#                                             Helper Functions                                                                  #
#################################################################################################################################

function Delete-WinRMListener {
   try {
      $config = Winrm enumerate winrm/config/listener
      foreach($conf in $config) {
         if($conf.Contains("HTTPS")) {
            Write-Verbose "HTTPS is already configured. Deleting the exisiting configuration."
            winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
            break
         }
      }
   }
   catch {
      Write-Verbose -Verbose "Exception while deleting the listener: " + $_.Exception.Message
   }
}

function Configure-WinRMHttpListener {
  param([string] $HostName, [string] $port)
  # Delete the WinRM Https listener if it is already configured
  Delete-WinRMListener

  $response = cmd.exe /c .\winrmconf.cmd $hostname $thumbprint
}

function Add-FirewallException {
   param([string] $port)

   # Delete an exisitng rule
   netsh advfirewall firewall delete rule name="Windows Remote Management (HTTPS-In)" dir=in protocol=TCP localport=$port

   # Add a new firewall rule
   netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=$port
}


#################################################################################################################################
#                                              Configure WinRM                                                                  #
#################################################################################################################################

$winrmHttpsPort=5985

# Configure https listener
Configure-WinRMHttpsListener $HostName $port

# Add firewall exception
Add-FirewallException -port $winrmHttpsPort

