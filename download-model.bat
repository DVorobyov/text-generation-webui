@echo off

SET TextOnly=False &REM True or False for Text only mode

cd /D "%~dp0"

set MAMBA_ROOT_PREFIX=%cd%\installer_files\mamba
set INSTALL_ENV_DIR=%cd%\installer_files\env

if not exist "%MAMBA_ROOT_PREFIX%\Scripts\activate.bat" (
  call "%MAMBA_ROOT_PREFIX%\micromamba.exe" shell hook >nul 2>&1
)
call "%MAMBA_ROOT_PREFIX%\condabin\mamba_hook.bat" || ( echo MicroMamba hook not found. && goto end )
call micromamba activate "%INSTALL_ENV_DIR%" || goto end

cd text-generation-webui || goto end
goto %TextOnly%

:False
call python download-model.py
goto end

:True
call python download-model.py --text-only

:end
pause
