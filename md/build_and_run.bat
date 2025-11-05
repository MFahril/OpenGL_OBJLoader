@echo off
echo ========================================
echo OBJ Viewer with Material Support
echo ========================================
echo.

cd /d "%~dp0"

echo Compiling with material and texture support...
g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut -static-libgcc -static-libstdc++

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
    echo Running with test_cube.obj...
    echo.
    ObjViewer.exe test_cube.obj
) else (
    echo.
    echo ===================================
    echo Compilation failed!
    echo ===================================
    echo Please check:
    echo 1. MinGW/GCC is installed
    echo 2. FreeGLUT is installed
    echo 3. All required files are present
    echo    - main.cpp
    echo    - ObjLoader.cpp
    echo    - ObjLoader.h
    echo    - stb_image.h
    echo.
    pause
)
