$downloadDIR = "C:\Users\jamesd21\Downloads\Buxton"
$fileA = [string]$downloadDIR + "\5510_Intel-Thunderbolt-Controller-Driver_M6YD4_WIN_16.3.59.250_A02.EXE"
if (test-path $fileA){return 0}else{wget https://downloads.dell.com/FOLDER04309822M/1/5510_Intel-Thunderbolt-Controller-Driver_M6YD4_WIN_16.3.59.250_A02.EXE -OutFile $fileA}
