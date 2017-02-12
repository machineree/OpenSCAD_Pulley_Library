# OpenSCAD_Pulley_Library
### OpenSCAD library to create multiple types of pulleys from belt sizes in 3D

Thingiverse Thing: [2081445](http://www.thingiverse.com/thing:2081445)

*v.01 - February 12, 2017*

+ linkages.scad: 3D Pulleys

Add to your library folder in OpenSCAD and use the include function to begin using these modules.

```scad
include <pulleys.scad>
```    

[OpenSCAD Libraries (Manual)](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries "OpenSCAD Libraries")

Default units are inches.

### Pulley Modules

![alt text](https://github.com/machineree/OpenSCAD_Pulley_Library/blob/master/pics/pulleyex1.png?raw=true "Pulleys!")

1. `module pulley(type="4L", definedD, arborD, key=.125, res=60, padding=true, screw=false)`

  + **type:** type of belt: 2L, 3L, 4L, 5L, A, B, C, D, E, 3V, 5V, 8V
  + **definedD:** desired outer diameter of the pulley
  + **arbor:** arbor or spindle diameter, through the pulley
  + **key:** square key slot, default is 1/8"
  + **res:** resolution of the circles, default is $fn=60
  + **padding:** adds a layer on either side of the pulley dependant upon the belt width
  + **screw:** places a set screw hole to be tapped that is lined up with the key to be locked on the arbor/spindle

###Naming Strategy:

pulley
custompulley
step*n*
customstep*n*

###Examples!

Output of help within OpenSCAD console:

```openscad
include <pulleys.scad>

pulleyhelp();
```

![alt text](https://github.com/machineree/OpenSCAD_Pulley_Library/blob/master/pics/pulleyhelp.png?raw=true "pulleyhelp")
