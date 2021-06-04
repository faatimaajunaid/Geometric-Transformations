# Geometric-Transformations
Geometric transformations using spatial transformations and grey level interpolation 

Developed a GUI which input an image and after applying geometric transformation, restores the image back to the original as close as possible (using CVIP tools).

Geometric transformations require two basic functions:
1. Spatial transformations
2. Grey level interpolation

We tried to find out the best guessed tri points both in the input and output images to later develop bilinear simulatanoeus equations for each quadrilateral of spatial transform and if required grey level ineterpolation to assign most appropriate values.
