# Fix: "freeglut.dll was not found" Error

## Problem
When running `ObjViewer.exe`, you get an error:
> **"The code execution cannot proceed because freeglut.dll was not found. Reinstalling the program may fix this problem."**

## Quick Solution (Recommended)

### Step 1: Download FreeGLUT DLL
1. Go to: https://www.transmissionzero.co.uk/software/freeglut-devel/
2. Download **freeglut 3.0.0 MSVC Package** or **MinGW Package** (depending on your compiler)
3. Extract the ZIP file

### Step 2: Copy the DLL
**Option A: Copy to Project Folder (Easiest)**
1. From the extracted folder, navigate to:
   - For 64-bit: `freeglut\bin\x64\freeglut.dll`
   - For 32-bit: `freeglut\bin\freeglut.dll`
2. Copy `freeglut.dll` to the same folder as `ObjViewer.exe` (your project root folder)

**Option B: Copy to Windows System Folder**
1. Copy `freeglut.dll` to:
   - For 64-bit Windows: `C:\Windows\System32\`
   - For 32-bit Windows: `C:\Windows\SysWOW64\`
2. May require administrator privileges

### Step 3: Verify
- Run `ObjViewer.exe` again
- The error should be gone

## Alternative: Static Linking (Advanced)

If you want to avoid DLL dependencies entirely, you need to:
1. Get the static FreeGLUT library (`.a` or `.lib` file)
2. Modify the build command to link statically:
   ```bat
   g++ -o ObjViewer.exe Core\main.cpp Core\ObjLoader.cpp -ICore -lopengl32 -lglu32 -lfreeglut_static -DFREEGLUT_STATIC -static-libgcc -static-libstdc++ -static
   ```
3. This creates a larger executable but with no DLL dependencies

## Troubleshooting

### "Wrong Architecture" Error
- Make sure the DLL architecture (32-bit/64-bit) matches your compiled executable
- Check your MinGW version: Run `gcc -v` in terminal to see if it's 32-bit or 64-bit

### Still Not Working?
1. Make sure you copied the correct DLL file (not a `.lib` or `.a` file)
2. Try placing the DLL in multiple locations:
   - Same folder as ObjViewer.exe
   - C:\Windows\System32
   - Your MinGW\bin folder (if you have one)

## Quick Download Links

- **FreeGLUT Official**: https://freeglut.sourceforge.net/
- **FreeGLUT MSVC/MinGW**: https://www.transmissionzero.co.uk/software/freeglut-devel/
- **FreeGLUT GitHub**: https://github.com/FreeGLUTProject/freeglut

## Summary
The easiest fix is to **copy `freeglut.dll` to the same folder as `ObjViewer.exe`**. No installation or admin rights needed!
