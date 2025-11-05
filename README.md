# OpenGL OBJ Loader - Animation & Cinematic Lighting

A powerful OpenGL-based 3D model viewer with support for static models, frame-based animations, materials, textures, and advanced cinematic lighting system.

## Folder Structure

```
OpenGL_OBJLoader/
├── Core/                      # Source code
│   ├── main.cpp              # Main application with cinematic lighting
│   ├── ObjLoader.cpp         # OBJ/MTL file parser
│   ├── ObjLoader.h           # OBJ loader interface
│   ├── AnimationLoader.cpp   # Frame-based animation system
│   ├── AnimationLoader.h     # Animation loader interface
│   └── stb_image.h           # Image loading library
├── Models/                    # 3D models and materials
│   ├── All.mtl               # Material files
│   ├── *.obj                 # Static 3D models
│   └── Anim/                 # Animation frames
│       ├── AnimatedObject0001.obj
│       ├── AnimatedObject0001.mtl
│       ├── ...
│       └── AnimatedObject0050.obj
├── md/                        # Documentation
│   ├── QUICKSTART.md
│   ├── COMPILE.md
│   ├── MATERIALS_GUIDE.md
│   ├── BLENDER_EXPORT_GUIDE.md
│   ├── ALTERNATIVE_ASSIMP.md
│   └── ...
├── build.bat                  # Automated build & run script
└── ObjViewer.exe              # Compiled executable (static, no DLLs)
```

## Quick Start

### Option 1: Using build.bat (Recommended)
```batch
build.bat
```
The script will:
1. Compile with static linking (no DLL dependencies)
2. Show compilation progress (0% → 100%)
3. Prompt for OBJ file path
4. Ask if you want animation
5. Automatically launch the viewer

### Option 2: Manual Compilation
```batch
g++ -c Core\main.cpp -o Core\main.o -ICore -DFREEGLUT_STATIC -static-libgcc -static-libstdc++
g++ -c Core\ObjLoader.cpp -o Core\ObjLoader.o -ICore -DFREEGLUT_STATIC
g++ -c Core\AnimationLoader.cpp -o Core\AnimationLoader.o -ICore -DFREEGLUT_STATIC
g++ -o ObjViewer.exe Core\main.o Core\ObjLoader.o Core\AnimationLoader.o -lfreeglut_static -lopengl32 -lglu32 -lwinmm -lgdi32 -static
```

### Running Static Models
```batch
# Basic usage
ObjViewer.exe Models\yourmodel.obj

# Examples
ObjViewer.exe Models\All.obj
ObjViewer.exe Models\VendingMachine.obj
```

### Running Animations
```batch
# With defaults (frames 0-60, 30 FPS)
ObjViewer.exe Models\Anim\AnimatedObject -a

# Custom frame range and FPS
ObjViewer.exe Models\Anim\AnimatedObject -a 0 50 30
ObjViewer.exe Models\Anim\AnimatedObject -a 10 40 24

# Format: ObjViewer.exe <basePath> -a <startFrame> <endFrame> <fps>
```

## Features

### Core Features
- ✅ **OBJ/MTL file loading** - Full Wavefront format support
- ✅ **Material system** - Ambient, Diffuse, Specular, Shininess (Ka, Kd, Ks, Ns)
- ✅ **Texture mapping** - PNG, JPG, BMP via stb_image
- ✅ **Frame-based animation** - Load sequences of OBJ files (e.g., 0001-0050)
- ✅ **Static linking** - Standalone .exe with no DLL dependencies

### Lighting System
- ✅ **Cinematic 6-light setup:**
  - **Key Light** (GL_LIGHT0) - Main illumination
  - **Fill Light** (GL_LIGHT1) - Soften shadows
  - **Rim Light** (GL_LIGHT2) - Edge definition
  - **Point Light 1** (GL_LIGHT3) - Interactive warm light
  - **Spotlight** (GL_LIGHT4) - Dramatic top-down lighting
  - **Point Light 2** (GL_LIGHT5) - Cool accent light
- ✅ **Blinn-Phong shading** - Accurate specular highlights
- ✅ **Real-time controls** - Adjust all lights interactively

### Rendering
- ✅ **Smooth shading** with normal interpolation
- ✅ **Wireframe mode** toggle
- ✅ **Axis display** for reference
- ✅ **Interactive camera** - Rotate and zoom

## Controls

### View Controls
| Key | Action |
|-----|--------|
| **Mouse drag** | Rotate model |
| **W / S** | Zoom in / out |
| **L** | Toggle lighting ON/OFF |
| **F** | Toggle wireframe mode |
| **R** | Reset camera view |
| **A** | Toggle axis display |
| **ESC** | Exit application |

### Animation Controls (when using `-a` flag)
| Key | Action |
|-----|--------|
| **SPACE** | Play / Pause animation |
| **P** | Play animation |
| **O** | Stop animation |
| **]** | Increase FPS (+5) |
| **[** | Decrease FPS (-5) |

### Lighting Controls

**Global Ambient:**
| Key | Action |
|-----|--------|
| **M** | Increase ambient light |
| **m** | Decrease ambient light |

**Point Light 1 (GL_LIGHT3 - Warm Orange):**
| Key | Action |
|-----|--------|
| **Numpad 4 / 6** | Move light Left / Right (X axis) |
| **Numpad 8 / 2** | Move light Up / Down (Y axis) |
| **Numpad 7 / 9** | Move light Forward / Back (Z axis) |

**Point Light 2 (GL_LIGHT5 - Cool Blue):**
| Key | Action |
|-----|--------|
| **Arrow Left / Right** | Move light on X axis |
| **Arrow Up / Down** | Move light on Y axis |
| **Home / End** | Move light on Z axis |

**Spotlight (GL_LIGHT4 - Top-down):**
| Key | Action |
|-----|--------|
| **+ / -** | Increase / Decrease intensity |
| **T / t** | Increase / Decrease focus (exponent) |
| **PgUp / PgDn** | Increase / Decrease angle (cutoff) |

## Animation System

The animation system loads sequences of OBJ files with automatic frame numbering:

### File Naming Convention
```
Models/Anim/AnimatedObject0001.obj  ← Frame 1
Models/Anim/AnimatedObject0001.mtl  ← Materials for frame 1
Models/Anim/AnimatedObject0002.obj  ← Frame 2
Models/Anim/AnimatedObject0002.mtl
...
Models/Anim/AnimatedObject0050.obj  ← Frame 50
```

### How It Works
1. Provide base path without frame number: `Models/Anim/AnimatedObject`
2. System automatically appends frame numbers (0001, 0002, etc.)
3. Each frame loads its own geometry and materials
4. Plays back in sequence at specified FPS

### Usage Examples
```batch
# Default: Frames 0-60 at 30 FPS (loads available frames only)
ObjViewer.exe Models\Anim\AnimatedObject -a

# Custom: Frames 0-50 at 24 FPS
ObjViewer.exe Models\Anim\AnimatedObject -a 0 50 24

# Subset: Frames 10-30 at 60 FPS
ObjViewer.exe Models\Anim\AnimatedObject -a 10 30 60
```

**Note:** Missing frames are skipped - the system loads only available files.

## Adding Your Models

### Static Models
1. Export from Blender with materials (.obj + .mtl)
2. Place files in `Models/` folder with textures
3. Run: `ObjViewer.exe Models\yourmodel.obj`

### Animated Models
1. Export animation sequence from Blender (1 OBJ per frame)
2. Name files: `YourModel0001.obj`, `YourModel0002.obj`, etc.
3. Place in `Models/Anim/` or custom folder
4. Run: `ObjViewer.exe Models/Anim/YourModel -a 1 50 30`

Materials and textures load automatically! 🎨

## Technical Details

### Build System
- **Compiler:** MinGW-w64 GCC (via MSYS2)
- **Linking:** Full static linking (no runtime DLLs)
- **Libraries:** FreeGLUT (static), OpenGL32, GLU32, Winmm, GDI32
- **Standards:** C++11 compatible

### Lighting Model
- **Shading:** Blinn-Phong with `GL_LIGHT_MODEL_LOCAL_VIEWER`
- **Attenuation:** Quadratic falloff for point lights
- **Spotlight:** Configurable cutoff angle (0-90°) and exponent (0-128)
- **Materials:** Full support for Ka, Kd, Ks, Ns, d (transparency)

### Performance
- **Animation:** Frame-based (not vertex morphing)
- **Rendering:** Immediate mode OpenGL (legacy pipeline)
- **Memory:** Each frame stored separately for accuracy

## Documentation

See the `md/` folder for detailed guides:
- `md/QUICKSTART.md` - Getting started guide
- `md/COMPILE.md` - Compilation instructions
- `md/MATERIALS_GUIDE.md` - Material and texture guide
- `md/BLENDER_EXPORT_GUIDE.md` - Blender export workflow
- `md/ALTERNATIVE_ASSIMP.md` - Alternative animation approaches
- `md/SETUP_STATIC_FREEGLUT.md` - Static linking setup
- `md/FIX_FREEGLUT_ERROR.md` - Troubleshooting

## Requirements

- **OS:** Windows 10/11
- **Compiler:** MinGW-w64 GCC 8.0+ or MSVC 2019+
- **Libraries:** FreeGLUT (static build recommended)
- **Runtime:** None (fully static executable)

## License

This project demonstrates OpenGL OBJ loading with materials, animation, and cinematic lighting. Feel free to use and modify for educational purposes.
