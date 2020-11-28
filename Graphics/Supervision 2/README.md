# Supervision 2 Questions

## Warm up questions

1. When the triangle is split into 3 sub-triangles with the extra vertex at a point `P`, the barycentic coordinates of `P` are the proportions of the triangle's area taken up by each of the sub-triangles.

2. Diffuse

3. OpenGL and Vulcan are cross-platform and open-source whereas DirectX is just for Windows/Xbox, and is propriatary. OpenGL is geared towards 3D graphics in general, whereas DirectX has a focus on games, and Vulcan on game engines. Vulcan has lower overhead for high performance graphics but often requires thousands of lines of code to perform simple tasks, and the code must be very well optimised.

4. GPGPU is the use of the GPU for general purpose computing, rather than just graphics. APIs such as CUDA and OpenCL can be used for GPGPU.

5. `in` variables are the inputs to the shader and are passed in by OpenGL as part of the render pipeline. `out` variables are the outputs of the shader and their values are calculated within the shader's code itself. `uniform` variables are constants set within Java (or whichever language is using the OpenGL API).

6. If no mipmap is used, when screen pixel is larger than a texture pixel, either the texture will have to be downsampled on the fly (i.e. the mipmap values would have to be calculated at runtime) or a sample might have to be taken from the middle of the covered region of the texture. In the former case, there would be no visual artefacts but there would be a notable hit to performance. In the latter case, small objects might just completely disappear from the texture.

7. If the bumps are supposed to be very pronounced and are in a direction parallel to the screen, it will be clear that if a bump map is used that the object's geometry is still actually flat, which will not be the case with a displacement map.

8. Two different light spectra which appear to have the same colour.

9. 

10. 

11. 

12. 

13. 

## Longer questions

1. 

2. Vertex shader, Primitive assembly, Clipping, Rasterization, Fragment shader

3. 
    - Array buffer: An array which contains the 3D coordinates of vertices

    - Element array buffer: An array which contains indices of the array buffer to reference a vertex. Each triplet of indices represent a tiangle made out of the corresponding vertices

    - Vertex array: A pair of an array buffer and an element array buffer.

4. 24

5. 
    - 2D: Each coordinate (u, v) could correspond to a proportion of the way through the longitude and the latitude ranges of the sphere.

    - 3D: Each coordinate in the texture could directly correspond to a point on the sphere's surface in cartesian coordinates.

    - Cubemap: Project a ray through the circle's centre through a point on its surface, and sample the cubemap at the intersection point of this ray with the cube.

6. 
    - Upsampling: interpolate between neighbouring texels by selecting the nearest one (nearest neighbour), or by performing linear interpolation between the two texels above the point and the two below, and then between the results of these (bilinear), etc.

    - Downsampling: Take the average of all of the texels covered by the screen pixel. The result of this downsampling can be done in advance and stored in a mipmap, and then when a colour is needed, OpenGL can interpolate between the relevant mipmaps

7. You could use two buffers: a front buffer which is shown on the screen, and a back buffer which is being drawn to by the GPU. When drawing is finished, swap the front and back buffers, and then start rendering the next frame. However, this creates some inefficiency during the periods of time during which the GPU has finished rendering the next frame but cannot start rendering the frame after until the buffers are swapped. A potential solution to this is to use three buffers so that in the down-time, the GPU can start rendering the next frame to the third buffer. However this requires 50% more memory.

8. 

9. 

10. 

11. 