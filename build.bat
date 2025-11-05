@echo off
echo ========================================
echo OBJ Viewer with Material Support
echo ========================================
echo.

cd /d "%~dp0"

echo Compiling from organized structure...
g++ -o ObjViewer.exe Core\main.cpp Core\ObjLoader.cpp -ICore -lopengl32 -lglu32 -lfreeglut -static-libgcc -static-libstdc++ -static

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===================================
    echo Compilation successful!
    echo ===================================
    echo.
    echo Features:
    echo  - Material support (.mtl files)
    echo  - Texture support (PNG, JPG, BMP, etc.)
    echo  - Automatic material loading
    echo.
    echo Usage:
    echo   ObjViewer.exe Models\yourmodel.obj
    echo.
    echo Examples of valid paths:
    echo   Models\yourmodel.obj                          (relative path)
    echo   Models\VendingMechine.obj                     (relative path)
    echo   C:\MyModels\object.obj                        (absolute path)
    echo   D:\Projects\3D Models\character.obj           (absolute path with spaces)
    echo   ..\OtherFolder\model.obj                      (parent directory)
    echo.
    set /p OBJ_PATH="Enter the path to your OBJ file (or press Enter for default test model): "
    echo.
    
    if "%OBJ_PATH%"=="" (
        echo Loading default test model...
        ObjViewer.exe Models\test_cube.obj
    ) else (
        echo Loading: %OBJ_PATH%
        ObjViewer.exe "%OBJ_PATH%"
    )
) else (
    echo.
    echo ===================================
    echo Compilation failed!
    echo ===================================
    echo Please check:
    echo 1. MinGW/GCC is installed and in PATH
    echo 2. FreeGLUT is installed properly
    echo 3. All files are in correct folders:
    echo    Core\   - Source files
    echo    Models\ - OBJ files
    echo    md\     - Documentation
    echo.
    echo FreeGLUT Installation Guide:
    echo 1. Download FreeGLUT from: https://www.transmissionzero.co.uk/software/freeglut-devel/
    echo 2. Extract and copy:
    echo    - freeglut.dll to C:\Windows\System32 (64-bit) or C:\Windows\SysWOW64 (32-bit)
    echo    - OR copy freeglut.dll to this project folder
    echo    - include files to MinGW\include\GL\
    echo    - lib files to MinGW\lib\
    echo.
    pause
)

echo.
echo ========================================================================
echo IMPORTANT: Runtime DLL Required - PLEASE READ!
echo ========================================================================
echo.
echo If you get "freeglut.dll was not found" error when running ObjViewer.exe:
echo.
echo ** QUICK FIX (Recommended) **
echo   1. Download FreeGLUT from: 
echo      https://www.transmissionzero.co.uk/software/freeglut-devel/
echo   2. Extract the ZIP file
echo   3. Copy freeglut.dll from bin\x64\ (64-bit) or bin\ (32-bit)
echo   4. Paste it in the SAME FOLDER as ObjViewer.exe
echo   5. Done! Run ObjViewer.exe again
echo.
echo Alternative Solutions:
echo   - Copy freeglut.dll to C:\Windows\System32 (64-bit Windows)
echo   - Copy freeglut.dll to C:\Windows\SysWOW64 (32-bit Windows)
echo.
echo For detailed instructions, see: FIX_FREEGLUT_DLL_ERROR.md
echo ========================================================================
echo.
