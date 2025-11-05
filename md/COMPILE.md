# Compilation and Setup Guide

## Prerequisites

You need to have OpenGL and GLUT installed on your system.

### Windows Setup

#### Option 1: FreeGLUT with MinGW (Recommended)

1. **Install MinGW-w64**
   - Download from: https://www.mingw-w64.org/
   - Or use MSYS2: https://www.msys2.org/

2. **Install FreeGLUT**
   
   **Using MSYS2 (easiest):**
   ```powershell
   # Open MSYS2 terminal
   pacman -S mingw-w64-x86_64-freeglut
   ```

   **Manual installation:**
   - Download FreeGLUT from: https://www.transmissionzero.co.uk/software/freeglut-devel/
   - Extract the files
   - Copy files to MinGW directories:
     ```
     freeglut/include/GL/* → C:\mingw64\include\GL\
     freeglut/lib/x64/* → C:\mingw64\lib\
     freeglut/bin/x64/* → C:\mingw64\bin\
     ```

3. **Compile the Project**
   ```powershell
   cd "d:\Thathak file\Matkul\Tugas\OpenGL project\OBJ_Loader"
   
   g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut -static-libgcc -static-libstdc++
   ```

4. **Run the Program**
   ```powershell
   ./ObjViewer.exe test_cube.obj
   ```

#### Option 2: Visual Studio

1. **Install Visual Studio** (Community Edition is free)
   - Include "Desktop development with C++"

2. **Install FreeGLUT via NuGet**
   - Open Visual Studio
   - Create new C++ Console Application
   - Tools → NuGet Package Manager → Manage NuGet Packages for Solution
   - Search for "nupengl.core" and install

3. **Add Files to Project**
   - Add `main.cpp`, `ObjLoader.cpp`, `ObjLoader.h`

4. **Configure Project**
   - Right-click project → Properties
   - C/C++ → General → Additional Include Directories: Add FreeGLUT include path
   - Linker → Input → Additional Dependencies: Add `opengl32.lib;glu32.lib;freeglut.lib`

5. **Build and Run**
   - Press F5 to build and run

#### Option 3: Code::Blocks

1. **Install Code::Blocks** with MinGW
   - Download from: http://www.codeblocks.org/

2. **Install FreeGLUT** (same as MinGW method above)

3. **Create New Project**
   - File → New → Project → Console Application
   - Add all .cpp and .h files

4. **Configure Linker**
   - Project → Build Options → Linker Settings
   - Add: `opengl32`, `glu32`, `freeglut`

5. **Build and Run**

---

## Compilation Commands

### Windows (PowerShell)
```powershell
# Navigate to project directory
cd "d:\Thathak file\Matkul\Tugas\OpenGL project\OBJ_Loader"

# Compile
g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut

# Run with test cube
./ObjViewer.exe test_cube.obj

# Or run and enter filename when prompted
./ObjViewer.exe
```

### Linux
```bash
# Install dependencies (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install build-essential freeglut3-dev

# Compile
g++ -o ObjViewer main.cpp ObjLoader.cpp -lGL -lGLU -lglut

# Run
./ObjViewer test_cube.obj
```

### macOS
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install FreeGLUT (using Homebrew)
brew install freeglut

# Compile
g++ -o ObjViewer main.cpp ObjLoader.cpp -framework OpenGL -framework GLUT

# Run
./ObjViewer test_cube.obj
```

---

## Quick Start

### 1. Test with Built-in Cube
```powershell
cd "d:\Thathak file\Matkul\Tugas\OpenGL project\OBJ_Loader"
g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut
./ObjViewer.exe test_cube.obj
```

### 2. Test with Blender Model
1. Open Blender
2. Create/select a model
3. File → Export → Wavefront (.obj)
4. Export settings:
   - ☑ Triangulate Faces
   - ☑ Write Normals
5. Save as `mymodel.obj`
6. Run: `./ObjViewer.exe mymodel.obj`

---

## Troubleshooting

### Error: "GL/glut.h: No such file or directory"
**Solution:** FreeGLUT is not installed or not in the include path
- Reinstall FreeGLUT
- Check include path: `-I/path/to/freeglut/include`

### Error: "cannot find -lfreeglut"
**Solution:** FreeGLUT library not found
- Check library path: `-L/path/to/freeglut/lib`
- Make sure freeglut.lib is in the lib directory

### Error: "freeglut.dll not found"
**Solution:** DLL not in system path
- Copy `freeglut.dll` to the same directory as the .exe
- Or add FreeGLUT bin directory to system PATH

### Program crashes on startup
**Solution:** 
- Make sure OpenGL drivers are up to date
- Try running with a simple OBJ file first (test_cube.obj)
- Check if the OBJ file path is correct

### Model doesn't appear
**Solution:**
- Press 'L' to toggle lighting
- Press 'R' to reset view
- Use 'W' to zoom in
- Check if OBJ file loaded successfully (console output)

---

## Project Structure

```
OBJ_Loader/
├── main.cpp                    # Main program with OpenGL viewer
├── ObjLoader.h                 # OBJ loader class header
├── ObjLoader.cpp               # OBJ loader implementation
├── test_cube.obj               # Test model
├── README.md                   # Main documentation
├── BLENDER_EXPORT_GUIDE.md     # Blender export instructions
├── ALTERNATIVE_ASSIMP.md       # Assimp library guide
└── COMPILE.md                  # This file
```

---

## Next Steps

### 1. Test the Program
```powershell
./ObjViewer.exe test_cube.obj
```

### 2. Try Your Own Models
- Export from Blender following BLENDER_EXPORT_GUIDE.md
- Load into the viewer

### 3. Customize the Code
- Change colors in `main.cpp`
- Add new features (see ideas below)
- Experiment with lighting

### 4. Advanced Features to Add
- [ ] Texture support
- [ ] Material (.mtl) file support
- [ ] Multiple objects
- [ ] Animation
- [ ] Save/load camera positions
- [ ] Screenshot capability

---

## Performance Tips

### For Large Models:
1. **Use Vertex Buffer Objects (VBO)** instead of immediate mode
2. **Enable display lists** for static geometry
3. **Implement frustum culling**
4. **Use level of detail (LOD)**

Example VBO implementation:
```cpp
// Store vertex data in GPU memory
GLuint vbo;
glGenBuffers(1, &vbo);
glBindBuffer(GL_ARRAY_BUFFER, vbo);
glBufferData(GL_ARRAY_BUFFER, vertexData.size() * sizeof(float), 
             &vertexData[0], GL_STATIC_DRAW);
```

---

## Resources

### Learning OpenGL:
- LearnOpenGL: https://learnopengl.com/
- OpenGL Tutorial: http://www.opengl-tutorial.org/
- Lighthouse3d: http://www.lighthouse3d.com/

### OBJ File Format:
- Wikipedia: https://en.wikipedia.org/wiki/Wavefront_.obj_file
- Fileformat: https://www.fileformat.info/format/wavefrontobj/

### 3D Models:
- Sketchfab: https://sketchfab.com/
- TurboSquid: https://www.turbosquid.com/
- Free3D: https://free3d.com/

---

## Support

If you encounter issues:
1. Check the Troubleshooting section above
2. Verify OpenGL is working: Run other OpenGL examples
3. Test with the simple test_cube.obj first
4. Check console output for error messages

Good luck with your OpenGL project! 🚀
