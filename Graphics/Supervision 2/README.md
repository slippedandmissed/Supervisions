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

9. Display-encoded colours are intended for efficient encoding, easier interpretation of colour, and perceptual uniformity.

10. 
    1. sRGB

    2. HSV / HLS

    3. CIE Lab / CIE Luv

11. Luma is gamma-encoded whereas luminance is linear.

12. They are a compromise between clipping and contrast compression. They mimic the response of analog film.

13. It is an optical illusion which tricks the brain into thinking that a percieved colour is brighter than that same colour but with no glare.

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

8. When a certain colour of light enters the eye it produces responses from the L, M, and S cones. The idea behind XYZ colour matching functions is that for a given colour, the same LMS cone responses can be produced by a linear combination of three independent reference colours, and so the brain would perceive the same colour. The relationship between them is therefore that the XYZ values for a given colour should produce the same LMS cone responses as the colour itself would produce.

9. Gamma-corrected colour values are perceived to be more uniform than linear colour values. This allows colours to be stored more efficiently and to be more easily interpreted. However, while colour values can be transformed from one linear colour space to another, it is much more difficult to convert between gamma-corrected colour spaces.

10. ITU r709 is the specification for linear SDR colour space. ITU r2020 is the specification for linear HDR colour space.

11. Tone mapping is an important part of the rendering process because in a light simulation the illumination of certain pixels can span tens of orders of magnitudes, whereas the human eye can detect only around 4 orders of magnitude, and a conventional display can only emit around 3 orders of magnitude. Tone mapping is therefore important so that we can squeeze the huge range of possible simulated illuminations into the small range of displayable illuminations. Tone mapping can also perform cosmetic changes to the scene such as colour grading, the simulation of night vision, motion blur, and making the scene look more realistic. Display encoding is another important part of the render pipeline because it allows colour values to be efficiently stored in the raster buffer.