# Setup FreeGLUT Static Library for MinGW

This guide will help you set up FreeGLUT static library so you can build **standalone executables without any DLL dependencies**.

## Why Static Linking?

✅ **Advantages:**
- No DLL dependencies (freeglut.dll, libwinpthread-1.dll, etc.)
- Fully portable executable - works on any Windows PC
- No "DLL not found" errors for end users
- Easy distribution - just share the .exe file

❌ **Disadvantages:**
- Larger executable size (a few MB larger)
- Must recompile to update libraries

## Prerequisites

- MinGW-w64 or MinGW installed
- Know your MinGW installation path (usually `C:\MinGW` or `C:\msys64\mingw64`)

## Installation Steps

### Step 1: Download FreeGLUT

1. Go to: https://www.transmissionzero.co.uk/software/freeglut-devel/
2. Download **freeglut 3.0.0 MinGW Package** (freeglut-MinGW-3.0.0-1.mp.zip)
3. Extract the ZIP file to a temporary location

### Step 2: Locate Your MinGW Installation

Find your MinGW installation directory. Common locations:
- `C:\MinGW`
- `C:\msys64\mingw64` (MSYS2 64-bit)
- `C:\msys64\mingw32` (MSYS2 32-bit)
- `C:\TDM-GCC-64`

To verify, open Command Prompt and type:
```cmd
where gcc
```
This will show you the path to gcc.exe. The MinGW root is usually 1-2 folders up.

### Step 3: Copy Header Files

From the extracted FreeGLUT folder:
1. Navigate to `freeglut\include\GL\`
2. Copy all `.h` files (freeglut.h, glut.h, etc.)
3. Paste them to `<MinGW-Path>\include\GL\`
   - Create the `GL` folder if it doesn't exist

**Example:**
```
Copy from: freeglut\include\GL\*.h
Copy to:   C:\MinGW\include\GL\
```

### Step 4: Copy Static Library File

From the extracted FreeGLUT folder:
1. Navigate to `freeglut\lib\`
2. Find `libfreeglut_static.a` (or `libfreeglut.a`)
   - For 64-bit MinGW: Use the x64 version
   - For 32-bit MinGW: Use the x86 version
3. Copy it to `<MinGW-Path>\lib\`
4. **Important:** Rename it to `libfreeglut_static.a` if it's named differently

**Example:**
```
Copy from: freeglut\lib\libfreeglut.a
Copy to:   C:\MinGW\lib\libfreeglut_static.a
```

### Step 5: Verify Installation

Open Command Prompt in your project folder and test compile:
```cmd
g++ -o test.exe Core\main.cpp Core\ObjLoader.cpp -ICore -DFREEGLUT_STATIC -lopengl32 -lglu32 -lfreeglut_static -lwinmm -lgdi32 -static-libgcc -static-libstdc++ -static
```

If successful, you should get `test.exe` with no DLL dependencies!

### Step 6: Use the Build Script

Now you can use the updated `build.bat`:
```cmd
build.bat
```

## Troubleshooting

### Error: "cannot find -lfreeglut_static"

**Solution:**
- Make sure `libfreeglut_static.a` is in `<MinGW>\lib\`
- Check the filename - it must be exactly `libfreeglut_static.a`
- Try renaming `libfreeglut.a` to `libfreeglut_static.a`

### Error: "undefined reference to `__imp___glutInitWithExit`"

**Solution:**
- Add `-DFREEGLUT_STATIC` flag to your compile command (already in build.bat)
- Make sure you're using the static library, not the import library

### Error: "undefined reference to `timeGetTime`"

**Solution:**
- Add `-lwinmm` to your linker flags (already in build.bat)

### Still Getting DLL Errors?

**Check your compile flags:**
```cmd
-DFREEGLUT_STATIC          <- Tells FreeGLUT to use static mode
-lfreeglut_static          <- Links the static library
-lwinmm -lgdi32            <- Required Windows libraries
-static                    <- Static linking for all libraries
```

## Alternative: Pre-built Static Libraries

If the above doesn't work, you can build FreeGLUT from source:

1. Download source from: https://github.com/FreeGLUTProject/freeglut
2. Use CMake to build with `-DFREEGLUT_BUILD_STATIC_LIBS=ON`
3. This ensures you get a proper static library for your MinGW version

## Verification

To check if your executable has no DLL dependencies:

1. Use **Dependency Walker**: http://www.dependencywalker.com/
2. Open `ObjViewer.exe` in Dependency Walker
3. You should only see Windows system DLLs (kernel32.dll, user32.dll, etc.)
4. No freeglut.dll or libwinpthread-1.dll should appear!

## Summary

After setup:
- ✅ `build.bat` will create standalone executables
- ✅ No DLLs needed to run ObjViewer.exe
- ✅ Executable is portable to any Windows PC
- ✅ No more "DLL not found" errors!

## Quick Reference

**MinGW Folder Structure:**
```
C:\MinGW\
├── bin\
│   └── gcc.exe, g++.exe, etc.
├── include\
│   └── GL\
│       ├── freeglut.h
│       ├── glut.h
│       └── freeglut_ext.h
└── lib\
    └── libfreeglut_static.a    <- Must be here!
```

Happy coding! 🚀
