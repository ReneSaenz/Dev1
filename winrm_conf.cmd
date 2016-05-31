
call winrm quickconfig
call winrm set winrm/config/client @{AllowUnencrypted="true"}
call winrm set winrm/config/client/auth @{Basic="true"}
call winrm set winrm/config/client @{TrustedHosts="*"}

call winrm create winrm/config/listener?Address=*+Transport=HTTP
call winrm set winrm/config/service @{AllowUnencrypted="true"}
call winrm set winrm/config/service/auth @{Basic="true"}

