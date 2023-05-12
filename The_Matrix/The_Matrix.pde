static final int nCube = 2000;
static final int cubeSize = 48;
Cube[] cubes;
PFont myFont;
int nRow;
int nCol;
int black = 0;
void setup(){
    size(1280,720,P3D);
    //fullScreen(P3D);
    textFont(createFont("simfang.ttf",108));
    textAlign(CENTER);
    textSize(cubeSize);
    rectMode(CENTER);
    smooth();
    nRow = height/cubeSize;
    nCol = width/cubeSize;
    cubes = new Cube[nCube];
    for(int i=0;i<nCube;i++){
        cubes[i] = new Cube();
    }
}
void draw(){
    background(black);
    for(int i=0;i<nCube;i++){
        cubes[i].update();
        cubes[i].display();
    }
}
