float SV_LEFT = 5;
float SV_TOP = 5;
float SV_SIDE = 300;
float SV_DIFF = 3;

float H_LEFT = 320;
float H_TOP = 5;
float H_WIDTH = 25;
float H_HEIGHT = 303;

float I_LEFT = 345;
float I_RIGHT = 360;

float H_MAX = 300;
float S_MAX = 100;
float V_MAX = 100;

float B_LEFT = 360;
float B_TOP = 5;
float B_SIDE = 303;

float HSV_VALUE_LEFT = 680;
float HSV_VALUE_TOP = 50;
float RGB_VALUE_LEFT = 800;
float RGB_VALUE_TOP = 50;

float hIter = 150;
float sIter = 150;
float vIter = 150;

boolean canDragSV = false;
boolean canDragH = false;

void setup(){
    size(1000,310);
    rectMode(CORNER);
    textSize(48);
    textAlign(LEFT);
    colorMode(HSB,H_MAX,S_MAX,V_MAX);
}

void draw(){
    background(255);
    // region box
    noStroke();
    for(int i=0;i<=S_MAX;i++){
        for(int j=0;j<=V_MAX;j++){
            fill(color(hIter,i,j));
            rect(SV_LEFT + i*SV_DIFF,
                 SV_TOP  + j*SV_DIFF,
                 SV_DIFF,
                 SV_DIFF);
        }
    }
    // fill color
    strokeWeight(1);
    for(int i=0;i<=H_MAX;i++){
        stroke(color(i,S_MAX,V_MAX));
        line(H_LEFT,
             i+H_TOP,
             H_LEFT + H_WIDTH,
             i+H_TOP);
    }
    
    // draw iter
    noStroke();
    fill(hIter,100,100);
    triangle(I_LEFT,hIter+H_TOP,I_RIGHT,hIter+H_TOP-5,I_RIGHT,hIter+H_TOP+5);
    
    // draw color box
    fill(hIter,sIter,vIter);
    rect(B_LEFT,B_TOP,B_SIDE,B_SIDE);
    noFill();
    stroke(hIter,sIter,vIter);
    strokeWeight(5);
    circle(SV_LEFT+sIter*SV_DIFF,SV_TOP+vIter*SV_DIFF,20);
    fill(0);
    text("H:"+str(int(1.2*hIter))+"\nS:"+str(int(sIter))+"\nV:"+str(int(sIter)),HSV_VALUE_LEFT,HSV_VALUE_TOP);
    int[] rgb = HSVToRGB(hIter,sIter/S_MAX,vIter/V_MAX);
    text("R:"+str(rgb[0])+"\nG:"+str(rgb[1])+"\nB:"+str(rgb[2]),RGB_VALUE_LEFT,RGB_VALUE_TOP);
}

void mouseDragged(){
    // ::sv
    if(canDragSV && mouseX>=SV_LEFT && mouseX<=SV_LEFT + SV_SIDE){
        sIter = (mouseX-SV_LEFT)/SV_DIFF;
    }
    if(canDragSV && mouseY>=SV_TOP && mouseY<=SV_TOP + SV_SIDE){
        vIter = (mouseY-SV_TOP)/SV_DIFF;
    }
    // ::h
    if(canDragH && mouseY>=H_TOP && mouseY<=H_TOP + H_HEIGHT)
    {
        hIter = mouseY-H_TOP;
    }
}

void mousePressed(){
    // ::sv
    if(mouseX>=SV_LEFT && 
       mouseX<=SV_LEFT + SV_SIDE && 
       mouseY>=SV_TOP && 
       mouseY<=SV_TOP + SV_SIDE)
    {
        canDragSV = true;
        sIter = (mouseX-SV_LEFT)/SV_DIFF;
        vIter = (mouseY-SV_TOP)/SV_DIFF;
    }
    // ::h
    if(mouseX>=H_LEFT && 
       mouseX<=H_LEFT + H_WIDTH && 
       mouseY>=H_TOP && 
       mouseY<=H_TOP + H_HEIGHT)
    {
        canDragH = true;
        hIter = mouseY-H_TOP;;
    }
}

void mouseReleased(){
    canDragSV = false;
    canDragH = false;
}

int[] HSVToRGB(float h,float s,float v){
    int[] rgb = new int[3];
    float c = v*s;
    float x = c*(1-abs((h/60)%2-1));
    float m = v-c;
    float r1=0;
    float g1=0;
    float b1=0;
    if(h>=0 && h<60){
        r1 = c;
        g1 = x;
        b1 = 0;
    }else if(h>=60 && h<120){
        r1 = x;
        g1 = c;
        b1 = 0;
    }else if(h>=120 && h<180){
        r1 = 0;
        g1 = c;
        b1 = x;       
    }else if(h>=180 && h<240){
        r1 = 0;
        g1 = x;
        b1 = c;       
    }else if(h>=240 && h<300){
        r1 = x;
        g1 = 0;
        b1 = c;       
    }else if(h>=300 && h<360){
        r1 = c;
        g1 = 0;
        b1 = x;       
    }
    rgb[0] = int((r1+m)*255);
    rgb[1] = int((g1+m)*255);
    rgb[2] = int((b1+m)*255);
    return rgb;
}
