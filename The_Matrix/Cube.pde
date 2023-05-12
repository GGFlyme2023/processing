int activatedColor = color(169,250,199,255);    //若是激活的，颜色看起更亮一点
int normalColor = color(20,105,58,255);
int nColor = 5;
//float startChar = float('"');    //输入给random函数
//float endChar = float('~')+1;    //ASCII中所有可打印字符
float startChar = 0x3040;
float endChar = 0x31ff;    // 日语平假名

class Cube{
    char myChar;
    boolean activated;
    float x,y,downSpeed;
    Cube(){
        initChar();
        resetPos();
        activated = (random(1)<1./3)?true:false;
        downSpeed = random(0.1,1);
    }
    
    void display(){
        fill(activated?activatedColor:normalColor);
        text(myChar,x,y);
    }
    
    void update(){
        y += mousePressed?10*downSpeed:downSpeed;
        if(y>height+downSpeed){
            resetPos();
            initChar();
        }
    }

    void initChar(){
        myChar = (char)int(random(startChar,endChar));
    }

    void resetPos(){
        initX();
        initY();
    } 
    
    void initX(){
        x = cubeSize*int(random(0,nCol+1));
    }
    
    void initY(){
        y = cubeSize*int(random(-nRow,nRow+1)); 
    }
}
