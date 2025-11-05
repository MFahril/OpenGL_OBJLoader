# Fix: "libfreeglut.dll was not found" Error

## Problem
When running `ObjViewer.exe`, you get an error:
```
The code execution cannot proceed because libfreeglut.dll was not found.
Reinstalling the program may fix this problem.
```

## Quick Solution (Easiest)

**Copy `freeglut.dll` to the same folder as `ObjViewer.exe`**

This is the simplest solution - just place the DLL file right next to your executable.

## Where to Get freeglut.dll

### Option 1: Download Pre-built Binary
1. Visit: https://www.transmissionzero.co.uk/software/freeglut-devel/
2. Download the appropriate version:
   - **For 64-bit Windows**: Download "freeglut 3.x MSVC Package" or MinGW version
   - **For 32-bit Windows**: Download 32-bit version
3. Extract the zip file
4. Find `freeglut.dll` in the `bin` folder

### Option 2: From MinGW Installation
If you have MinGW installed with FreeGLUT:
1. Look in your MinGW folder: `C:\MinGW\bin\` or `C:\mingw64\bin\`
2. Find `freeglut.dll` or `libfreeglut.dll`
3. Copy it

## Solutions (Choose One)

### Solution 1: Copy to Project Folder ⭐ (RECOMMENDED)
```
Copy freeglut.dll → d:\Thathak file\Matkul\Tugas\OpenGL project\OBJ_Loader\
```
**Pros:** 
- Easy to share with others
- Keeps everything in one place
- No system changes needed

### Solution 2: Copy to Windows System Folder
**For 64-bit Windows:**
```
Copy freeglut.dll → C:\Windows\System32\
```

**For 32-bit Windows:**
```
Copy freeglut.dll → C:\Windows\SysWOW64\
```

**Note:** Requires administrator privileges

### Solution 3: Add MinGW to PATH
1. Right-click "This PC" → Properties → Advanced System Settings
2. Click "Environment Variables"
3. Under "System Variables", find "Path" and click "Edit"
4. Add your MinGW bin folder (e.g., `C:\MinGW\bin`)
5. Click OK and restart your terminal

## File Names
The DLL might be named:
- `freeglut.dll`
- `libfreeglut.dll`
- `freeglut3.dll`

**All work the same way!** Just rename it to match what your program expects if needed.

## Still Having Issues?

### Check if you have the right version:
- 32-bit program needs 32-bit DLL
- 64-bit program needs 64-bit DLL

### Verify your MinGW installation:
```bash
g++ --version
```
If this doesn't work, MinGW is not properly installed.

## Complete Installation (If Nothing Works)

1. **Install MinGW-w64:**
   - Download from: https://sourceforge.net/projects/mingw-w64/
   - Or use MSYS2: https://www.msys2.org/

2. **Install FreeGLUT:**
   ```bash
   # If using MSYS2:
   pacman -S mingw-w64-x86_64-freeglut
   ```

3. **Add to PATH:**
   Add `C:\msys64\mingw64\bin` to your system PATH

4. **Recompile:**
   ```bash
   .\build.bat
   ```

## Quick Test
After copying the DLL, run:
```bash
.\build.bat
```
Then enter a model path when prompted, or press Enter for the default test model.

---

**Note:** Make sure the `.mtl` and texture files are in the same directory as your `.obj` file!
