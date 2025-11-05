# OBJ File Loader for OpenGL

## Overview
This is a complete C++ OpenGL application that can load and display 3D models from Wavefront OBJ files.

## Features
- ✅ Load .obj files with vertices, normals, and texture coordinates
- ✅ Automatic model centering and scaling
- ✅ Interactive 3D viewing with mouse rotation
- ✅ Lighting and shading support
- ✅ Wireframe toggle
- ✅ Support for triangles, quads, and polygons

## Files
- `ObjLoader.h` - Header file with class definition
- `ObjLoader.cpp` - OBJ parser implementation
- `main.cpp` - OpenGL viewer application

## Compilation

### Windows (with MinGW)
```powershell
g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut
```

### Windows (with Visual Studio)
1. Create a new C++ Console Application project
2. Add all three files to the project
3. Add OpenGL libraries to linker:
   - Right-click project → Properties → Linker → Input
   - Add: `opengl32.lib;glu32.lib;freeglut.lib`
4. Make sure FreeGLUT is installed and configured

### Linux
```bash
g++ -o ObjViewer main.cpp ObjLoader.cpp -lGL -lGLU -lglut
```

## Usage

### Running the Program
```powershell
./ObjViewer.exe model.obj
```
Or run without arguments and enter the file path when prompted.

### Controls
- **Mouse Drag**: Rotate the model
- **W/S**: Zoom in/out
- **L**: Toggle lighting on/off
- **F**: Toggle wireframe mode
- **R**: Reset view to default
- **ESC**: Exit application

## Blender Export Settings for OBJ

### Step-by-Step Guide:

1. **In Blender, select your model**

2. **File → Export → Wavefront (.obj)**

3. **Recommended Export Settings:**
   ```
   Include:
   ☑ Objects as OBJ Objects
   ☑ Material Groups
   ☑ Apply Modifiers
   ☑ Write Normals
   ☑ Include UVs
   ☑ Write Materials (if using .mtl files)
   
   Transform:
   ☑ Y Forward
   ☑ Z Up
   Scale: 1.00
   
   Geometry:
   ☑ Triangulate Faces (recommended for compatibility)
   ☐ Write Nurbs (uncheck)
   ☐ Polygroups (optional)
   ```

4. **Click "Export OBJ"**

### Important Notes:
- **Triangulate Faces**: Check this if you have complex polygons
- **Apply Modifiers**: Make sure modifiers are applied before export
- **Scale**: Keep at 1.00 (the loader auto-scales the model)
- **Coordinate System**: Y Forward, Z Up works best for OpenGL

## Supported OBJ Features

### ✅ Fully Supported:
- `v` - Vertex positions
- `vn` - Vertex normals
- `vt` - Texture coordinates
- `f` - Faces (triangles, quads, polygons)
- Face formats: `v`, `v/vt`, `v/vt/vn`, `v//vn`
- Negative indices (relative indexing)
- Comments (`#`)
- **`mtllib`** - Material library files (.mtl) ✨ NEW!
- **`usemtl`** - Material assignment per face ✨ NEW!

### ✨ Material Support (.mtl files):
- Ambient color (`Ka`)
- Diffuse color (`Kd`)
- Specular color (`Ks`)
- Shininess (`Ns`)
- Transparency (`d` or `Tr`)
- Illumination model (`illum`)
- **Diffuse textures** (`map_Kd`) - PNG, JPG, BMP, TGA, etc.
- Ambient textures (`map_Ka`)
- Specular textures (`map_Ks`)
- Bump maps (`map_Bump`)

### ⚠️ Partially Supported:
- Textures - Only diffuse textures currently displayed
- Groups (`g`) - Parsed but not used for rendering
- Objects (`o`) - Parsed but not separated

### ❌ Not Supported:
- Smoothing groups (`s`)
- Advanced material properties
- Vertex colors

## Example Test Files

Create a simple cube OBJ file for testing:

**cube.obj:**
```obj
# Simple Cube
v -1.0 -1.0  1.0
v  1.0 -1.0  1.0
v  1.0  1.0  1.0
v -1.0  1.0  1.0
v -1.0 -1.0 -1.0
v  1.0 -1.0 -1.0
v  1.0  1.0 -1.0
v -1.0  1.0 -1.0

vn  0.0  0.0  1.0
vn  0.0  0.0 -1.0
vn  0.0  1.0  0.0
vn  0.0 -1.0  0.0
vn  1.0  0.0  0.0
vn -1.0  0.0  0.0

f 1//1 2//1 3//1 4//1
f 8//2 7//2 6//2 5//2
f 4//3 3//3 7//3 8//3
f 5//4 6//4 2//4 1//4
f 2//5 6//5 7//5 3//5
f 8//6 5//6 1//6 4//6
```

## Troubleshooting

### Model appears too small/large
- The loader automatically scales models to fit in view
- If issues persist, check the model's scale in Blender

### Model appears black
- Press 'L' to toggle lighting
- Make sure normals are exported from Blender
- Check "Write Normals" in Blender export settings

### Model is inside-out
- In Blender, check face orientation (Edit Mode → Mesh → Normals → Flip)
- Enable/disable back-face culling in the code

### File not found
- Use absolute paths: `C:\\Users\\YourName\\model.obj`
- Or place the .obj file in the same directory as the executable

## Advanced: Using with Textures

To add texture support, you'll need to:
1. Load texture images (using libraries like SOIL or stb_image)
2. Parse `.mtl` files (material files)
3. Bind textures in the draw function

## Alternative: Using Assimp Library

For more features and format support, see `ALTERNATIVE_ASSIMP.md`
