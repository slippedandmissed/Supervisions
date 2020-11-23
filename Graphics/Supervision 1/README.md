# Supervision 1 Questions

## Warm up questions

1. `i = 3(hx+y)`

2. Sampling is when a continuous signal is measured in discrete time intervals, while the measured values may still be continuous. Quantization is when measured values of a signal are rounded to discrete values.

3. 

4. When tracing rays from the eye, one can trace one ray from the eye through each pixel of the screen in order to determine what colour each pixel should be, thereby achieving the maximum resolution your display will allow. If instead a ray is traced from the scene, there's no guarantee it will even reach the eye. As such, it is difficult to know how many rays to trace and from which parts of the screen they should originate in order to determine the colour of every pixel in the display.

5. <br/><img src="https://latex.codecogs.com/gif.latex?3(1&plus;s)^2&space;=&space;1&space;\\&space;\therefore&space;(1&plus;s)^2&space;=&space;\frac{1}{3}&space;\\&space;\therefore&space;(1&plus;s)&space;=&space;\pm&space;\frac{1}{\sqrt{3}}&space;\\&space;\therefore&space;s&space;=&space;-1&space;\pm&space;\frac{1}{\sqrt{3}}" title="3(1+s)^2 = 1 \\ \therefore (1+s)^2 = \frac{1}{3} \\ \therefore (1+s) = \pm \frac{1}{\sqrt{3}} \\ \therefore s = -1 \pm \frac{1}{\sqrt{3}}" />

6. Trace multiple rays for each pixel and take the average of the result. The exact position in the pixel through which this ray passes can be determined using Poisson sampling.

7. In a pinhole camera, the aperture of the camera is a single point, resulting in perfect focus for objects at all distances from the camera. Whereas, in a finite aperture camera, the aperture is a plane (or other region) resulting in a "focal length" at which objects appear sharp and clear, while objects at other distances appear blurred. A finite aperture camera can be simulated by tracing multiple rays from random points on the camera's aperture which all intersect the focal plane at the same distance, and taking the average result thereof.

8. Triangles are good because any triplets of points are necessarily coplanar and so definitely form a triangle. Contrastingly, some quadruplets of points may not necessarily form a quad, as the fourth point may not lie in the plane defined by the other three. Triangles are also good because all polygons can be converted into triangles. However, triangles can be inconvenient because a complicated mesh (particularly those approximating a curved surface) can require a large number of triangles to approximate. An alternative might be to instead store the mathematical equations required to construct the object. For simple geometric objects &ndash; particularly curved ones like spheres &ndash; this would massively cut down on the amount of information needing to be stored. However, for complex geometry these equations would become increasibly cumbersome. This distinction is similar to that between bitmap and vector images.

9. When a shape undergoes a linear transformation, if its normals were to undergo the same transformation, the transformed normals would no longer be perpendicular to the transformed tangents.

## Longer questions

1. <object data="https://github.com/slippedandmissed/Supervisions/raw/master/Graphics/Supervision%201/figures/Intersection%20with%20cylinder.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="https://github.com/slippedandmissed/Supervisions/raw/master/Graphics/Supervision%201/figures/Intersection%20with%20cylinder.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="https://github.com/slippedandmissed/Supervisions/raw/master/Graphics/Supervision%201/figures/Intersection%20with%20cylinder.pdf">Download PDF</a>.</p>
    </embed>
</object>
