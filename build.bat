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
    echo Running with test model...
    echo.
    ObjViewer.exe Models\test_cube.obj
) else (
    echo.
    echo ===================================
    echo Compilation failed!
    echo ===================================
    echo Please check:
    echo 1. MinGW/GCC is installed
    echo 2. FreeGLUT is installed
    echo 3. All files are in correct folders:
    echo    Core\   - Source files
    echo    Models\ - OBJ files
    echo    md\     - Documentation
    echo.
    pause
)
