Sphere_packing_enumeration and display
==========================


Enumeration and display of all sphere packing of an arbitrary number of  three different kind of spheres according to contact graph criteria, in MATLAB .


Author  : Jean-Baptiste gastineau, jb.gastineau@gmail.com
Licence : Without restriction , for my own code. I used the (matlab)  PSO implementation of Brian Bridge.
          See the file licence in the so called PSO repository, and see the restrictions from the PSO implementaton used.

To use this programmn clone this repository, one doawnload the sources files.
Run the sphere_packing.m file with matlab, and use the graphical interface that has been launch.

Alternatively you can doawnload the binary version of the programm together with the matlab compiler environement
at (in a self extracting archive ): https://drive.google.com/file/d/0BxkHnQ0ydEPtUWg5QmdsWllkTXM/edit?usp=sharing 

To know how the code works, see the comments, writen in the generate_graphs.m file, and all other files 
because they are fully commented.

Here are the files contained in this repository :

contact_equation.m    : objective function for PSO minimization
contact_quality.m     : check if the sphere packing proposed by the PSO minimization trial are real
generate_comb.m       : generate successive  combinations
generate_graphs.m     : main functions called by the graphical interface
packing.m             : container 
Single_graph.m        : contact graph object
sphere_packing.m      : graphical interface
sphere_packing.fig    : matlab fig file (not useful)
visible_sphere.m      : sphere object.

Don't hesitate to give me feedback at jb.gastineau@gmail.com, or to fork this repository
If you are curious you can see this video :  http://vimeo.com/65402744
that's all !
