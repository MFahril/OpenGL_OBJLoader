@echo off
echo ========================================
echo OBJ Viewer with Material Support
echo ========================================
echo.

cd /d "%~dp0"

echo Compiling from organized structure...
g++ -o ObjViewer.exe Core\main.cpp Core\ObjLoader.cpp -ICore -lopengl32 -lglu32 -lfreeglut -static-libgcc -static-libstdc++

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
echo ===================================
echo IMPORTANT: Runtime DLL Required
echo ===================================
echo If you get "libfreeglut.dll not found" error when running:
echo.
echo Solution 1 (Recommended):
echo   Copy freeglut.dll to the same folder as ObjViewer.exe
echo.
echo Solution 2:
echo   Copy freeglut.dll to C:\Windows\System32 (for 64-bit)
echo   or C:\Windows\SysWOW64 (for 32-bit systems)
echo.
echo Solution 3:
echo   Add MinGW bin folder to Windows PATH environment variable
echo.
echo Download FreeGLUT DLL from:
echo   https://www.transmissionzero.co.uk/software/freeglut-devel/
echo ===================================
echo.
