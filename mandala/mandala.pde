int order = 4;
float angle;
int len =  1500;
color red  = #f71e1b;
color green = #33c441;
color yellow  = #e2dc2b;
color pink  = #e23bdd;
color blue  = #2758dd;
color lblue = #1ee8e4;
color w =  #FFFFFF;
color current_color = red;


float x,y;
float iterationCounter = 0;


float a = 2.5;
float b = 2.4;


float incrVal = -0.01;


color[] colors = {red,green,yellow,pink,lblue};



void setup()
{

 
  size(1400,1400);
  
  x = width/2;
  y = height/2;
  
  
  angle = 2 * PI / pow(2,order);
  background(0);
  translate(width/2,height/2);
  for(int i = 0 ; i < pow(2,order) ; i++)
  {
    rotate(-angle);
    stroke(0,0,0,100);
    line(0,0,len,0);
  }


}

void draw()
{
  

  
  translate(width/2,height/2);
  if(frameCount%20==0)saveFrame("GifPhotos/Photo-#####.png");
  
  iterationCounter+=1;
  float value = iterationCounter/5;
  
  if(iterationCounter % 3 == 0)
  {
    current_color = getNextColor();
  }
  
  
  b += incrVal;
  
  if(b<= -2.4)
    incrVal = 0.01;
  if(b>=2.4)
    incrVal = -0.01;
    
    

  
//  x = (a + b*value) * cos(value) + width/2;
//  y = (a + b*value) * sin(value) + height/2;
//  placeEllipse(x,y);
}


void placeEllipse(float xPos,float yPos)
{
  for(int i = 0 ; i < pow(2,order) ; i++)
  {
    rotate(-angle);
    fill(current_color);
    noStroke();
    ellipse(xPos-width/2,yPos-height/2,4,4);
  }
}

color getNextColor()
{
  int randIt = int(random(1,4));
  return colors[randIt];
}


void mouseDragged()
{
  placeEllipse(mouseX,mouseY);
}

void keyPressed()
{
  switch(key)
  {
    case 'r' : current_color = red;
                break;
    case 'b' : current_color = blue;
                break;
    case 'g' : current_color = green;
                break;
   case  'p' : current_color = pink;
               break;
    case 'y' : current_color = yellow;
               break;
    case 'l' : current_color = lblue;
               break;
    case 'w' : current_color = w;
               break;
    case 's' : saveFrame();
  }
}
