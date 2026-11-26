@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
rem ============================================================
rem  Convierte los clips de Seedance en la secuencia de la web.
rem
rem  1. Pon los 14 clips en la carpeta  herramientas\clips\
rem     con estos nombres:  01.mp4  02.mp4 ... 14.mp4
rem     (01 = del lago a la colina, 14 = del altar a la cupula)
rem  2. Haz doble clic en este archivo.
rem  3. Se rellenan frames\hi y frames\lo y se actualiza manifest.js.
rem
rem  Necesita ffmpeg (el mismo que usa MoneyPrinterTurbo).
rem ============================================================

set "HERE=%~dp0"
set "CLIPS=%HERE%clips"
set "ROOT=%HERE%.."
set "TMP=%HERE%_tmp"
rem fotogramas por tramo: 40 = recorrido fluido y peso razonable
set "PER=40"

where ffmpeg >nul 2>nul
if errorlevel 1 (
  echo No encuentro ffmpeg. Instalalo con:  winget install Gyan.FFmpeg
  pause & exit /b 1
)
if not exist "%CLIPS%\01.mp4" (
  echo Falta "%CLIPS%\01.mp4". Revisa los nombres de los clips.
  pause & exit /b 1
)

if exist "%TMP%" rmdir /s /q "%TMP%"
mkdir "%TMP%"
if exist "%ROOT%\frames\hi" rmdir /s /q "%ROOT%\frames\hi"
if exist "%ROOT%\frames\lo" rmdir /s /q "%ROOT%\frames\lo"
mkdir "%ROOT%\frames\hi" "%ROOT%\frames\lo"

set /a IDX=0
set "KEYS=0"
for /l %%n in (1,1,14) do (
  set "NN=0%%n" & set "NN=!NN:~-2!"
  if not exist "%CLIPS%\!NN!.mp4" ( echo Falta el clip !NN!.mp4 & pause & exit /b 1 )
  echo Tramo !NN! ...
  rem duracion del clip en segundos
  for /f %%d in ('ffprobe -v error -show_entries format^=duration -of csv^=p^=0 "%CLIPS%\!NN!.mp4"') do set "DUR=%%d"
  rem extrae PER fotogramas repartidos por todo el clip (sin el ultimo, que es el primero del siguiente)
  ffmpeg -v error -i "%CLIPS%\!NN!.mp4" -vf "fps=%PER%/!DUR!" -frames:v %PER% "%TMP%\t_%%03d.png"
  for /l %%k in (1,1,%PER%) do (
    set "K=00%%k" & set "K=!K:~-3!"
    set "O=000!IDX!" & set "O=!O:~-4!"
    if exist "%TMP%\t_!K!.png" (
      ffmpeg -v error -y -i "%TMP%\t_!K!.png" -vf "scale=1920:-2" -quality 70 "%ROOT%\frames\hi\!O!.webp"
      ffmpeg -v error -y -i "%TMP%\t_!K!.png" -vf "scale=854:-2" -quality 60 "%ROOT%\frames\lo\!O!.webp"
      set /a IDX+=1
    )
  )
  del /q "%TMP%\t_*.png"
  set "KEYS=!KEYS!,!IDX!"
)
rem ultimo fotograma del ultimo clip (la cupula)
ffmpeg -v error -sseof -0.1 -i "%CLIPS%\14.mp4" -frames:v 1 "%TMP%\last.png"
set "O=000!IDX!" & set "O=!O:~-4!"
ffmpeg -v error -y -i "%TMP%\last.png" -vf "scale=1920:-2" -quality 70 "%ROOT%\frames\hi\!O!.webp"
ffmpeg -v error -y -i "%TMP%\last.png" -vf "scale=854:-2" -quality 60 "%ROOT%\frames\lo\!O!.webp"
set /a COUNT=IDX+1
rmdir /s /q "%TMP%"

(
  echo /* Generado por convertir-video.bat */
  echo window.FRAMES = {
  echo   version: "realista",
  echo   count: !COUNT!,
  echo   pad: 4,
  echo   ext: "webp",
  echo   keys: [!KEYS!]
  echo };
) > "%ROOT%\frames\manifest.js"

echo.
echo Listo: !COUNT! fotogramas. Abre index.html para verlo.
pause
