//PULLEY LIBRARY v.01

/*pulley values*/
function columnName(ID) =
ID == "width" ? 0:
ID == "height" ? 1:
ID == "angle" ? 2:
-1;

/*pulley table:
width, height, angle*/
function tableRow(ID) = 
ID == "2L" ? [1/4, 1/8, 40] :
ID == "3L" ? [3/8, 7/32, 40] :
ID == "4L" ? [1/2, 5/16, 40] :
ID == "5L" ? [21/32, 3/8, 40]:
ID == "A" ? [1/2, 5/16, 40]:
ID == "B" ? [21/32, 13/32, 40]:
ID == "C" ? [7/8, 17/32, 40]:
ID == "D" ? [1+1/4, 3/4, 40]:
ID == "E" ? [1+1/2, 20/32, 40]:
ID == "3V" ? [3/8, 5/16, 30]:
ID == "5V" ? [5/8, 17/32, 30]:
ID == "8V" ? [1, 29/32, 30]:
-1;

function tableEntry (rowName, fieldName) = tableRow(rowName)[columnName(fieldName)];
    
module pulley(type="4L", definedD, arborD, key=.125, res=60, padding=true, screw=false){
    if (tableRow(type) == -1)	
        echo(str("pulley ERROR: type of '",type,"' is undefined."));
 
//Pulley dimensions    
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//Pulley diameters
    innerD=definedD -(2*beltH);

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall and padding
    beltb=beltB-(2*x);

    scale([25.4,25.4,25.4])
    difference(){
        union(){    
            translate ([0,0,x/2+beltb/2]) cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
            cylinder(h=beltb, d=innerD, $fn=res, center=true);
            mirror ([0,0,1]) translate ([0,0,(x/2+beltb/2)]) cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
            if (padding == true) {
                translate ([0,0,3*x/2+beltb/2]) cylinder(h=x,d=definedD, $fn=res, center=true);
                translate ([0,0,-(3*x/2+beltb/2)]) cylinder(h=x,d=definedD, $fn=res, center=true);
            }
        }
        cylinder(h=100,d=arborD,$fn=res,center=true);
        translate ([0,key,0]) cube([key,arborD,100], center=true);
        if (screw==true){
            translate([0,definedD/4,0]) rotate([90,0,0]) cylinder(h=definedD/2, d=.8*beltb,$fn=res,center=true);
            echo(str("set screw hole size = ", .8*beltb));
        }
       
    }
    echo ("pulley default values:");    
    echo (str("pulley " ,type, " | pulley dia " , definedD, " | arbor dia " ,arborD, " | keyhole ",key, " | $fn=",res, " | padding=",padding, " | setscrew ", screw));
    echo ("2L, 3L, 4L, 5L, A, B, C, D, E, 3V, 5V, 8V pulley belts available");
}

module custompulley(beltB, beltH, beltangle, definedD, arborD, key=.125, res=60, padding=true, screw=false){
    
//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//Pulley diameters
    innerD=definedD -(2*beltH);

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    scale([25.4,25.4,25.4])
    difference(){
        union(){    
            translate ([0,0,x/2+beltb/2]) cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
            cylinder(h=beltb, d=innerD, $fn=res, center=true);
            mirror ([0,0,1]) translate ([0,0,(x/2+beltb/2)]) cylinder(h=x, d1=innerD,d2=definedD, $fn=res, center=true);
            if (padding == true) {
                translate ([0,0,3*x/2+beltb/2]) cylinder(h=x,d=definedD, $fn=res, center=true);
                translate ([0,0,-(3*x/2+beltb/2)]) cylinder(h=x,d=definedD, $fn=res, center=true);
            }
        }
        cylinder(h=100,d=arborD,$fn=res,center=true);
        translate ([0,key,0]) cube([key,arborD,100], center=true);
        if (screw==true){
            translate([0,definedD/4,0]) rotate([90,0,0]) cylinder(h=definedD/2, d=.8*beltb,$fn=res,center=true);
            echo(str("set screw hole size = ", .8*beltb));
        }
    }
    echo ("custom pulley values:");    
    echo (str("belt width " ,beltB, " | belt height " ,beltH, " | belt angle " ,beltangle, " | pulley dia " ,definedD, " | arbor dia " ,arborD, " | keyhole ",key, " | $fn=",res, " | padding=",padding, " | setscrew ", screw));
}

module step2 (type="",dia1,dia2,arborD,key=.125,res=60,padding=true){
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,1*(beltB+2*x)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
    pulley(type,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,1*(beltB)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
        pulley(type,dia1,arborD,key,res,padding);
    }
}

module step3 (type="",dia1,dia2,dia3,arborD,key=.125,res=60,padding=true){
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,2*(beltB+2*x)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
    pulley(type,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,2*(beltB)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
        pulley(type,dia1,arborD,key,res,padding);
    }
}

module step4 (type="",dia1,dia2,dia3,dia4,arborD,key=.125,res=60,padding=true){
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,3*(beltB+2*x)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
    pulley(type,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,3*(beltB)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
        pulley(type,dia1,arborD,key,res,padding);
    }
}

module step5 (type="",dia1,dia2,dia3,dia4,dia5,arborD,key=.125,res=60,padding=true){
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,4*(beltB+2*x)*25.4]) pulley(type,dia5,arborD,key,res,padding); 
    translate([0,0,3*(beltB+2*x)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
    pulley(type,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,4*(beltB)*25.4]) pulley(type,dia5,arborD,key,res,padding); 
        translate([0,0,3*(beltB)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
        pulley(type,dia1,arborD,key,res,padding);
    }
}

module step6 (type="",dia1,dia2,dia3,dia4,dia5,dia6,arborD,key=.125,res=60,padding=true){
    beltB=tableEntry (type, "width");
    beltH=tableEntry (type, "height");
    beltangle=tableEntry (type, "angle");

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,5*(beltB+2*x)*25.4]) pulley(type,dia6,arborD,key,res,padding); 
    translate([0,0,4*(beltB+2*x)*25.4]) pulley(type,dia5,arborD,key,res,padding); 
    translate([0,0,3*(beltB+2*x)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
    pulley(type,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,5*(beltB)*25.4]) pulley(type,dia6,arborD,key,res,padding); 
        translate([0,0,4*(beltB)*25.4]) pulley(type,dia5,arborD,key,res,padding); 
        translate([0,0,3*(beltB)*25.4]) pulley(type,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) pulley(type,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) pulley(type,dia2,arborD,key,res,padding,screw=true);
        pulley(type,dia1,arborD,key,res,padding);
    }
}

module customstep2 (beltB, beltH, beltangle, dia1,dia2, arborD, key=.125, res=60, padding=true){

//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,1*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
    custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,1*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
        custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);
    }
}

module customstep3 (beltB, beltH, beltangle, dia1,dia2,dia3, arborD, key=.125, res=60, padding=true){

//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,2*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
    custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,2*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
        custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);
    }
}

module customstep4 (beltB, beltH, beltangle, dia1,dia2,dia3,dia4, arborD, key=.125, res=60, padding=true){

//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,3*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
    custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,3*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
        custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);
    }
}

module customstep5 (beltB, beltH, beltangle, dia1,dia2,dia3,dia4,dia5, arborD, key=.125, res=60, padding=true){

//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,4*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia5,arborD,key,res,padding); 
    translate([0,0,3*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
    custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,4*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia5,arborD,key,res,padding); 
        translate([0,0,3*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
        custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);
    }
}

module customstep6 (beltB, beltH, beltangle, dia1,dia2,dia3,dia4,dia5,dia6, arborD, key=.125, res=60, padding=true){

//beltB = belt width
//beltH = belt height
//beltangle = manufacturer supplied angle

//belt calculations
    theta=(180-beltangle)/2;
    x=beltH/(tan(theta)); //also height of pulley wall
    beltb=beltB-(2*x);

    translate([0,0,5*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia6,arborD,key,res,padding); 
    translate([0,0,4*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia5,arborD,key,res,padding); 
    translate([0,0,3*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
    translate([0,0,2*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
    translate([0,0,1*(beltB+2*x)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
    custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);

    if (padding!=true){
        translate([0,0,5*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia6,arborD,key,res,padding); 
        translate([0,0,4*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia5,arborD,key,res,padding); 
        translate([0,0,3*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia4,arborD,key,res,padding);     
        translate([0,0,2*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia3,arborD,key,res,padding);    
        translate([0,0,1*(beltB)*25.4]) custompulley(beltB, beltH, beltangle,dia2,arborD,key,res,padding,screw=true);
        custompulley(beltB, beltH, beltangle,dia1,arborD,key,res,padding);
    }
}

module pulleyhelp(){
    echo ("OpenSCAD Pulley Library v.01 - designed by Machineree");
    echo ("Single and Step Pulleys using manufacturer values of belt sizes include:");
    echo ("2L, 3L, 4L, 5L, A, B, C, D, E, 3V, 5V, 8V");
    echo("");
    echo ("Custom modules can be entered in Belt Width, Belt Height, and Belt Angle for complete optimization");
    echo("");
    echo("Default Pulley Values/Variables:");
    echo ("pulley(type=4L, definedD, arborD, key=.125, res=60, padding=true, screw=false)");
    echo("custompulley(beltB, beltH, beltangle, definedD, arborD, key=.125, res=60, padding=true, screw=false)");
    echo("stepn(type=4L,dia1,dia2,...,dian,arborD,key=.125,res=60,padding=true)");
    echo("customstepn(beltB,BeltH,beltangle,dia1,dia2,...,dian,arborD,key=.125,res=60,padding=true)");
    echo("Step Pulleys have set screw located on 2nd pulley always");
    echo("All pulley dimensions are in inches");
    echo("");
    echo("Check for updates & more details on machineree.com, GitHub, and Thingiverse!");

}