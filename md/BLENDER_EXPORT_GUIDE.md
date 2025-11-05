# Blender Export Guide for OpenGL

## Quick Reference

### OBJ Export (Best for Learning)
**File → Export → Wavefront (.obj)**

**Settings:**
```
Include:
☑ Selection Only (if you want specific objects)
☑ Apply Modifiers
☑ Write Normals
☑ Include UVs
☑ Write Materials
☑ Triangulate Faces

Transform:
Forward: -Z Forward
Up: Y Up
Scale: 1.00

Geometry:
☑ Triangulate Faces
☑ Write Nurbs
☑ Polygroups
```

---

### GLTF/GLB Export (Best for Production)
**File → Export → glTF 2.0 (.gltf/.glb)**

**Settings:**
```
Format: glTF Binary (.glb)

Include:
☑ +Y Up
☑ Selected Objects (optional)
☑ Cameras
☑ Punctual Lights

Transform:
☑ Apply Modifiers

Geometry:
☑ UVs
☑ Normals
☑ Tangents
☑ Vertex Colors
☑ Materials: Export

Compression: None (or Draco if supported)
```

---

## Detailed Blender Workflow

### 1. Preparing Your Model in Blender

#### Check Face Orientation
```
Edit Mode → Mesh → Normals → Flip (if needed)
Viewport Overlays → Face Orientation
  Blue = correct orientation
  Red = flipped normals
```

#### Apply Transformations
```
Object Mode → Object → Apply → All Transforms
```
This ensures scale, rotation, and location are baked into the mesh.

#### Triangulate (Optional but Recommended)
```
Edit Mode → Select All (A) → Mesh → Triangulate Faces
or
Add Modifier → Triangulate → Apply
```

#### Clean Up Mesh
```
Edit Mode → Select All (A)
Mesh → Clean Up → 
  ☑ Delete Loose
  ☑ Degenerate Dissolve
  ☑ Merge by Distance
```

### 2. Setting Up Materials (if using)

```
Shading Workspace
Create Material → Principled BSDF
Set Base Color, Metallic, Roughness
Add Texture if needed
```

### 3. UV Unwrapping (if using textures)

```
Edit Mode → Select All (A)
UV → Smart UV Project or Unwrap
Check UV Editor to verify UVs
```

---

## File Format Comparison

### OBJ (.obj)
**Pros:**
- ✅ Simple text format
- ✅ Widely supported
- ✅ Easy to debug
- ✅ No special libraries needed
- ✅ Good for learning

**Cons:**
- ❌ Large file size
- ❌ No animation support
- ❌ Materials in separate .mtl file
- ❌ Limited features

**Best for:** Learning, simple static models

---

### GLTF/GLB (.gltf, .glb)
**Pros:**
- ✅ Modern standard
- ✅ Efficient binary format
- ✅ Full material support
- ✅ Animation support
- ✅ PBR materials
- ✅ Used in WebGL, game engines

**Cons:**
- ❌ Needs library (like Assimp)
- ❌ More complex to parse manually

**Best for:** Production, web graphics, games

---

### FBX (.fbx)
**Pros:**
- ✅ Industry standard
- ✅ Full feature support
- ✅ Animation, rigging, morphs
- ✅ Materials and textures

**Cons:**
- ❌ Proprietary format
- ❌ Needs library (Assimp)
- ❌ Large file size

**Best for:** Game development, professional work

---

### STL (.stl)
**Pros:**
- ✅ Very simple
- ✅ Good for 3D printing
- ✅ Easy to parse

**Cons:**
- ❌ Only geometry (triangles)
- ❌ No colors, materials, or textures
- ❌ No normals

**Best for:** 3D printing, engineering

---

### PLY (.ply)
**Pros:**
- ✅ Supports vertex colors
- ✅ Simple format
- ✅ Good for point clouds

**Cons:**
- ❌ Limited feature set
- ❌ Less common

**Best for:** Point clouds, scanned data

---

## Testing Your Export

### Create a Simple Test Cube

**In Blender:**
1. Delete default cube (X → Delete)
2. Add → Mesh → UV Sphere
3. Edit Mode → Select All (A)
4. Mesh → Triangulate Faces
5. File → Export → Wavefront (.obj)
6. Save as `test_sphere.obj`

**Test in OpenGL:**
```powershell
cd "d:\Thathak file\Matkul\Tugas\OpenGL project\OBJ_Loader"
./ObjViewer.exe test_sphere.obj
```

---

## Common Issues and Solutions

### Issue: Model appears black
**Solution:**
- Enable "Write Normals" in export
- Check lighting in OpenGL viewer (press 'L')
- Verify face orientation in Blender

### Issue: Model is too large/small
**Solution:**
- The OBJ loader auto-scales, but you can:
- In Blender: Select object → Press 'S' → Type '0.1' → Enter
- Or adjust scale in export settings

### Issue: Model is rotated wrong
**Solution:**
- In OBJ export, try different combinations:
  - Forward: -Z Forward
  - Up: Y Up
- In OpenGL, adjust the view with mouse rotation

### Issue: Textures not showing
**Solution:**
- The basic OBJ loader doesn't support textures yet
- Use the Assimp version (see ALTERNATIVE_ASSIMP.md)
- Or implement texture loading manually

### Issue: File not found
**Solution:**
- Use absolute path: `"C:\\Users\\YourName\\model.obj"`
- Or place .obj file in same directory as .exe
- Check for typos in filename

---

## Recommended Workflow

### For Learning (Start Here):
1. Use simple models (cube, sphere, torus)
2. Export as OBJ with Triangulate enabled
3. Use the custom OBJ loader provided
4. Focus on understanding the code

### For Projects:
1. Model in Blender with proper topology
2. Apply all transforms
3. Triangulate and clean mesh
4. Export as GLTF/GLB
5. Use Assimp library for loading
6. Add materials and textures

---

## Sample Models for Testing

Create these simple OBJ files for testing:

### Pyramid (pyramid.obj)
```obj
v 0.0 1.0 0.0
v -1.0 -1.0 1.0
v 1.0 -1.0 1.0
v 1.0 -1.0 -1.0
v -1.0 -1.0 -1.0

f 1 2 3
f 1 3 4
f 1 4 5
f 1 5 2
f 5 4 3 2
```

### Tetrahedron (tetrahedron.obj)
```obj
v 1.0 1.0 1.0
v -1.0 -1.0 1.0
v -1.0 1.0 -1.0
v 1.0 -1.0 -1.0

f 1 2 3
f 1 4 2
f 1 3 4
f 2 4 3
```

Save these as .obj files and test with your loader!
