# OBJ Viewer with Material & Texture Support

## ✨ NEW FEATURES

### Material Support (.mtl files)
- ✅ Reads `.mtl` (material library) files automatically
- ✅ Ambient, Diffuse, Specular colors
- ✅ Shininess and transparency
- ✅ Per-face material assignment

### Texture Support
- ✅ Loads texture images (PNG, JPG, BMP, TGA, etc.)
- ✅ Automatic texture mapping with UV coordinates
- ✅ Multiple textures per model
- ✅ Uses stb_image library (no external dependencies!)

---

## Blender Export for Materials

### Step-by-Step Export with Materials:

1. **Create Materials in Blender:**
   - Select object → Material Properties → New Material
   - Set Base Color, Metallic, Roughness
   - Add textures (Image Texture node in Shading workspace)

2. **File → Export → Wavefront (.obj)**

3. **Critical Settings:**
   ```
   ☑ Include:
     ☑ Objects as OBJ Objects
     ☑ Material Groups        ← Important!
     ☑ Write Materials        ← Important!
     ☑ Triangulate Faces
     ☑ Write Normals
     ☑ Include UVs            ← Required for textures!
   
   ☑ Path Mode: Copy
   ☑ Copy: All
   ```

4. **Result:**
   - `.obj` file (geometry)
   - `.mtl` file (materials) - automatically created
   - Texture images copied to same folder

---

## Material File Format (.mtl)

### Example Material:
```mtl
newmtl MyMaterial
Ka 0.2 0.2 0.2    # Ambient color (RGB 0-1)
Kd 0.8 0.8 0.8    # Diffuse color (main color)
Ks 1.0 1.0 1.0    # Specular color (highlights)
Ns 32.0           # Shininess (0-1000)
d 1.0             # Dissolve (transparency, 1=opaque, 0=transparent)
illum 2           # Illumination model

# Texture maps (optional)
map_Kd texture.png     # Diffuse texture
map_Ka ambient.png     # Ambient texture
map_Ks specular.png    # Specular texture
map_Bump normal.png    # Bump/normal map
```

### What Each Property Does:
- **Ka (Ambient)**: Color in shadows, minimum light
- **Kd (Diffuse)**: Main surface color
- **Ks (Specular)**: Color of shiny highlights
- **Ns (Shininess)**: How sharp/blurry highlights are (higher = sharper)
- **d (Dissolve)**: Transparency (1.0 = solid, 0.0 = invisible)
- **illum**: Lighting model (2 = standard, with highlights)

---

## OBJ File with Materials

### Example:
```obj
# Reference the material file
mtllib mymodel.mtl

# Vertices, normals, UVs...
v 0.0 0.0 0.0
vn 0.0 0.0 1.0
vt 0.0 0.0

# Use material for following faces
usemtl RedMaterial
f 1/1/1 2/2/2 3/3/3

# Switch material
usemtl BlueMaterial
f 4/4/4 5/5/5 6/6/6
```

---

## Supported Texture Formats

Thanks to **stb_image** library:
- ✅ **PNG** - Best for art/UI
- ✅ **JPG/JPEG** - Good for photos
- ✅ **BMP** - Windows bitmap
- ✅ **TGA** - Targa
- ✅ **PSD** - Photoshop (flattened)
- ✅ **GIF** - Animated (first frame)
- ✅ **HDR** - High dynamic range
- ✅ **PIC** - Softimage

---

## Testing Materials

### Create a Simple Material Test:

**test.mtl:**
```mtl
newmtl RedPlastic
Ka 0.1 0.0 0.0
Kd 0.7 0.0 0.0
Ks 0.9 0.9 0.9
Ns 100.0
d 1.0
illum 2
```

**test.obj:**
```obj
mtllib test.mtl

v -1.0 -1.0 0.0
v  1.0 -1.0 0.0
v  1.0  1.0 0.0
v -1.0  1.0 0.0

vn 0.0 0.0 1.0
vn 0.0 0.0 1.0
vn 0.0 0.0 1.0
vn 0.0 0.0 1.0

usemtl RedPlastic
f 1//1 2//2 3//3
f 1//1 3//3 4//4
```

Save both files in the same folder and load the .obj:
```powershell
./ObjViewer.exe test.obj
```

---

## Compilation with Materials

**The same as before!** No extra libraries needed (stb_image is header-only):

```powershell
g++ -o ObjViewer.exe main.cpp ObjLoader.cpp -lopengl32 -lglu32 -lfreeglut
```

---

## How It Works

### 1. **OBJ File Loading:**
```obj
mtllib materials.mtl    ← Parser loads this file
usemtl RedMaterial      ← Assigns material to following faces
f 1/1/1 2/2/2 3/3/3    ← This face uses RedMaterial
```

### 2. **MTL File Parsing:**
- Reads all materials
- Stores RGB colors, shininess, etc.
- Loads texture images if specified

### 3. **Rendering:**
- For each face, check its material
- Apply material properties to OpenGL:
  ```cpp
  glMaterialfv(GL_FRONT, GL_AMBIENT, ambient);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, specular);
  ```
- Bind texture if available:
  ```cpp
  glBindTexture(GL_TEXTURE_2D, textureID);
  ```

---

## Troubleshooting

### Materials not showing?
1. **Check console output** - Does it say "Loaded X materials"?
2. **Enable lighting** - Press 'L' in the viewer
3. **MTL file location** - Must be in same folder as .obj
4. **MTL file reference** - .obj must have `mtllib` line

### Textures not loading?
1. **Texture path** - Must be relative to .obj location
2. **Supported format** - Use PNG, JPG, BMP
3. **UV coordinates** - Model must have texture coords (`vt` lines)
4. **Console messages** - Check for "Failed to load texture" errors

### Model is all one color?
- No materials defined → Uses default lighting
- Materials but no `usemtl` → Faces don't reference materials
- Export issue → Re-export with "Write Materials" enabled

### Textures look wrong?
- **Upside down** - Some formats flip Y-axis (normal, can't fix easily)
- **Stretched** - UV mapping issue in model
- **Pixelated** - Low-res texture or no mipmaps

---

## Blender Material Tips

### PBR to Legacy Conversion:
Blender uses PBR (Physically Based Rendering), but OBJ/MTL uses simpler "Phong" shading:

**Blender → OBJ/MTL Mapping:**
- Base Color → Kd (Diffuse)
- Metallic → Affects Ks (Specular)
- Roughness → Affects Ns (Shininess)
  - Low roughness = High shininess
  - High roughness = Low shininess

### Best Practices:
1. **Keep it simple** - Basic materials work best
2. **Bake complex shaders** - Convert nodes to textures
3. **Test early** - Export and test frequently
4. **Use power-of-2 textures** - 256, 512, 1024, 2048 pixels
5. **Relative paths** - Keep textures in same folder as .obj

---

## Advanced: Creating Materials Programmatically

```cpp
// Example: Add material in code
Material myMat;
myMat.name = "Gold";
myMat.ambient = Vec3(0.24725f, 0.1995f, 0.0745f);
myMat.diffuse = Vec3(0.75164f, 0.60648f, 0.22648f);
myMat.specular = Vec3(0.628281f, 0.555802f, 0.366065f);
myMat.shininess = 51.2f;

// This functionality can be added to ObjLoader class
```

---

## Summary

### What's New:
✅ **Full material support** (.mtl files)
✅ **Texture loading** (PNG, JPG, BMP, etc.)
✅ **Automatic material application**
✅ **No external dependencies** (stb_image is header-only)

### What Works:
- Colors (ambient, diffuse, specular)
- Shininess
- Transparency
- Textures with UV mapping
- Multiple materials per model

### Export from Blender:
1. ☑ Write Materials
2. ☑ Include UVs
3. ☑ Triangulate Faces
4. ☑ Copy textures

### Load and View:
```powershell
./ObjViewer.exe your_model.obj
```

**That's it!** Materials and textures load automatically if the files are present. 🎨✨
