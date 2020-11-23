# Supervision 1 Questions

## Warm up questions

1. `i = 3(hx+y)`

2. Sampling is when a continuous signal is measured in discrete time intervals, while the measured values may still be continuous. Quantization is when measured values of a signal are rounded to discrete values.

3. Occlusion, shading, familiar size, relative size, colour, texture gradient, shadow and foreshadowing, relative brightness, atmosphere, distance to horizon, and focus can be displayed on a 2D screen. Focal depth requires a special 3D display.

4. When tracing rays from the eye, one can trace one ray from the eye through each pixel of the screen in order to determine what colour each pixel should be, thereby achieving the maximum resolution your display will allow. If instead a ray is traced from the scene, there's no guarantee it will even reach the eye. As such, it is difficult to know how many rays to trace and from which parts of the screen they should originate in order to determine the colour of every pixel in the display.

5. <br/><img src="https://latex.codecogs.com/gif.latex?3(1&plus;s)^2&space;=&space;1&space;\\&space;\therefore&space;(1&plus;s)^2&space;=&space;\frac{1}{3}&space;\\&space;\therefore&space;(1&plus;s)&space;=&space;\pm&space;\frac{1}{\sqrt{3}}&space;\\&space;\therefore&space;s&space;=&space;-1&space;\pm&space;\frac{1}{\sqrt{3}}" title="3(1+s)^2 = 1 \\ \therefore (1+s)^2 = \frac{1}{3} \\ \therefore (1+s) = \pm \frac{1}{\sqrt{3}} \\ \therefore s = -1 \pm \frac{1}{\sqrt{3}}" />

6. Trace multiple rays for each pixel and take the average of the result. The exact position in the pixel through which this ray passes can be determined using Poisson sampling.

7. In a pinhole camera, the aperture of the camera is a single point, resulting in perfect focus for objects at all distances from the camera. Whereas, in a finite aperture camera, the aperture is a plane (or other region) resulting in a "focal length" at which objects appear sharp and clear, while objects at other distances appear blurred. A finite aperture camera can be simulated by tracing multiple rays from random points on the camera's aperture which all intersect the focal plane at the same distance, and taking the average result thereof.

8. Triangles are good because any triplets of points are necessarily coplanar and so definitely form a triangle. Contrastingly, some quadruplets of points may not necessarily form a quad, as the fourth point may not lie in the plane defined by the other three. Triangles are also good because all polygons can be converted into triangles. However, triangles can be inconvenient because a complicated mesh (particularly those approximating a curved surface) can require a large number of triangles to approximate. An alternative might be to instead store the mathematical equations required to construct the object. For simple geometric objects &ndash; particularly curved ones like spheres &ndash; this would massively cut down on the amount of information needing to be stored. However, for complex geometry these equations would become increasibly cumbersome. This distinction is similar to that between bitmap and vector images.

9. When a shape undergoes a linear transformation, if its normals were to undergo the same transformation, the transformed normals would no longer be perpendicular to the transformed tangents.

## Longer questions

1. <br/><img src="https://github.com/slippedandmissed/Supervisions/raw/master/Graphics/Supervision%201/figures/cylinder.png" />

2.
    - Ambient reflection is that from a light source whose illumination distributes constantly throughout the entire scene. It is undirected, and so it alone allows for only the silhouette of the object to be lit. Diffuse reflection represents the light that gets scattered uniformly in all directions from a dull surface. Specular reflection represents the highlights caused by perfect mirror reflection of light on a shiny surface.

    - If the incoming ray of light is incident to the surface parallel to the normal, more light is scattered, whereas if the light is incident close to perpendicular to the surface normal, little to no light is scattered. This is captured by the fact that the amount of light scattered is proportional to the cosine of the angle between the light ray and the normal.

    - The ambient component approximates the small amount of light which is scattered about the entire scene.

    - When the camera moves, the ambient and diffuse components remain the same, but the specular component changes.

3.
    - Recursively trace a ray from the point of intersection, the direction of which is the reflection of the original ray in the normal of the surface. If this ray intersects another object, determine the illumination of this object at that point, and add it as a contribution to the original object's illumination. Repeat this recursively for a predetermined number of steps

 - Trace a new ray from the point of intersection, the direction of which can be determined using Snell's law, where the ratio of the sines of the angles of incidence and refraction respectively is equal to the ratio of the refractive indices of the boundary media. The illumination of the resulting ray should be used as that of the original, or can be combined with reflection (as described above) in some pre-defined ratio.

 - For each light source, cast a ray from the point of intersection to the light source, and detect the nearest intersection of that ray with any object in the scene. If such an intersection exists, and the distance thereto is less than the distance to the light source, ignore that light source's contributions to the diffuse and ambient components.

4. All linear transformations (matrices) have a property whereby when applied to the origin, the result is unchanged. This is to say that a linear transformation cannot move the zero vector. This illustrates the fact that if we were to use Cartesian vectors to represent points in space, we could not represent translations using matrices, as there would be no matrix which, when applied to the zero vector, would result in anything other than the zero vector. Using homogeneous coordinates allows us to represent all points in 3D space with a non-zero vector, and so we can use matrices for translations. Furthermore, the zero vector in homogeneous coordinates is analogous to a point at infinity, which should indeed not be affected by a translation.

5. The modelling transformation converts a point from "object coordinates" to "world coordinates" i.e. from a coordinate system in which the origin is the centre of the object to one in which the origin is the centre of the scene. Each object has its own modelling transformation matrix. The view transformation converts a point from "world coordinates" to "viewing coordinates" i.e. from a coordinate system in which the origin is the centre of the scene to one in which the origin is the camera and the screen is a set distance from the camera. The projection transformation converts a point from "viewing coordinates" to 2D "screen coordinates" i.e. from a 3D point in space relative to the camera to a 2D pixel location on the display.