# OBJ Loader - Organized Structure

## Folder Structure

```
OBJ_Loader/
├── Core/               # Source code
│   ├── main.cpp
│   ├── ObjLoader.cpp
│   ├── ObjLoader.h
│   └── stb_image.h
├── Models/             # 3D models and materials
│   ├── test_cube.obj
│   ├── test_pyramid.obj
│   ├── test_materials.mtl
│   └── VindingMechine_OpenGL.obj
├── md/                 # Documentation
│   ├── README.md
│   ├── COMPILE.md
│   ├── MATERIALS_GUIDE.md
│   ├── BLENDER_EXPORT_GUIDE.md
│   └── ...
├── build.bat           # Build script
└── ObjViewer.exe       # Compiled executable
```

## Quick Start

### Compile:
```powershell
build.bat
```

Or manually:
```powershell
g++ -o ObjViewer.exe Core\main.cpp Core\ObjLoader.cpp -ICore -lopengl32 -lglu32 -lfreeglut
```

### Run:
```powershell
ObjViewer.exe Models\yourmodel.obj
```

### Examples:
```powershell
# Test cube (no materials)
ObjViewer.exe Models\test_cube.obj

# Test pyramid
ObjViewer.exe Models\test_pyramid.obj

# Vinding Machine (with materials)
ObjViewer.exe Models\VindingMechine_OpenGL.obj
```

## Features

- ✅ OBJ file loading
- ✅ Material support (.mtl files)
- ✅ Texture support (PNG, JPG, BMP, etc.)
- ✅ Interactive 3D viewing
- ✅ Lighting and shading

## Controls

- **Mouse drag** - Rotate model
- **W/S** - Zoom in/out
- **L** - Toggle lighting
- **F** - Toggle wireframe
- **R** - Reset view
- **ESC** - Exit

## Documentation

See the `md/` folder for detailed documentation:
- `md/README.md` - Main documentation
- `md/MATERIALS_GUIDE.md` - Material and texture guide
- `md/COMPILE.md` - Compilation instructions
- `md/BLENDER_EXPORT_GUIDE.md` - Blender export guide

## Adding Your Models

1. Export from Blender with materials
2. Place `.obj`, `.mtl`, and texture files in `Models/` folder
3. Run: `ObjViewer.exe Models\yourmodel.obj`

Materials and textures load automatically! 🎨
