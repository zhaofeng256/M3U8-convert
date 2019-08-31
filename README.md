# M3U8-convert
a script convert video type of M3U8 to MP4 

What is an M3U8 File? It is plain text file like a file list, and each file's size is very small, like hundreds of KBs. like this:

  #EXTM3U  
  #EXT-X-TARGETDURATION:8  
  #EXTINF:4.170000,  
  file:///storage/emulated/0/QQBrowser/video/.ac82a07ac0f038d338966a382f0e80bd/0.ts  
  #EXTINF:4.336800,  
  file:///storage/emulated/0/QQBrowser/video/.ac82a07ac0f038d338966a382f0e80bd/1.ts  
  #EXTINF:3.961500,  
  file:///storage/emulated/0/QQBrowser/video/.ac82a07ac0f038d338966a382f0e80bd/2.ts  
  #EXTINF:4.170000,  
  file:///storage/emulated/0/QQBrowser/video/.ac82a07ac0f038d338966a382f0e80bd/3.ts  
  .....  
  .....  
  .....  
  
  
The real media files is saved in one folder(may be hidden), usually in the folder where .m3u8 file is, like this:  
  
|----.ac82a07ac0f038d338966a382f0e80bd  
|&ensp;|-0.ts  
|&ensp;|-1.ts  
|&ensp;|-2.ts  
|&ensp;|-3.ts  
|&ensp;|-4.ts  
|&ensp;|...  
|&ensp;|-1861.ts  
|&ensp;|-1862.ts  
!----Avengers: Endgame.m3u8  
  
  
Some media players do not support m3u8 files, they had to be converted. I found the movies download by my phone browser is m3u8 type, but when I copy the .m3u8 and the video folder to windows pc, it can not be played directly, so I write this power-shell script and it runs well on my window 10 pc with power-shell version 5.1.  

HOW TO USE:  
 1.put the script to  the same fold with .m3u8 file  
 2.open windows power-shell as administrator  
 3.check the executation police of power-shell by input command 'Get-ExecutionPolicy'  
 4.if it is not RemoteSigned, power-shell script cann't run. Input 'Set-ExecutionPolicy RemoteSigned' and input 'A'  
 5.go to the .m3u8 folder. For example, input 'cd D:/videos', change the path if yours is different  
 6.now wen can run the script like './m3u8_mp4.ps1  name_of_video.m3u8', change the m3u8 file name to your own
 7.when the file is convert successfully, you will see 'sucess!', and the mp4 file is saved in the same folder with .m3u8  
 

