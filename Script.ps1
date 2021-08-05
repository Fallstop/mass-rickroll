Try{  
    Do{
        $URL = 'ws://mass-rickroll.host.qrl.nz'
        $WS = New-Object System.Net.WebSockets.ClientWebSocket                                                
        $CT = New-Object System.Threading.CancellationToken
        $WS.Options.UseDefaultCredentials = $true

        #Get connected
        $Conn = $WS.ConnectAsync($URL, $CT)
        While (!$Conn.IsCompleted) { 
            Start-Sleep -Milliseconds 100 
        }
        Write-Host "Connected to $($URL)"
        $Size = 1024
        $Array = [byte[]] @(,0) * $Size

        #Start reading the received items
        While ($WS.State -eq 'Open') {                        

            $Recv = New-Object System.ArraySegment[byte] -ArgumentList @(,$Array)
            $Conn = $WS.ReceiveAsync($Recv, $CT)
            While (!$Conn.IsCompleted) { 
                    #Write-Host "Sleeping for 100 ms"
                    Start-Sleep -Milliseconds 100 
            }

            #Write-Host "Finished Receiving Request"

            $Command = [System.Text.Encoding]::utf8.GetString($Recv.array)

            Write-Host $Command

            if ($Command -eq 'rick') {
                Start-Process 'https://www.youtube.com/watch?v=o-YBDTqX_ZU&ab_channel=MusRest'
            }
        }   
    } Until ($WS.State -ne 'Open')

}Finally{

    If ($WS) { 
        Write-Host "Closing websocket"
        $WS.Dispose()
    }

}
