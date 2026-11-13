int order = 4; // The order of the mandala
float angle; // The angle of rotation for each line
int len = 1500; // The length of the lines in the mandala
color red  = #f71e1b; // A red color
color green = #33c441; // A green color
color yellow  = #e2dc2b; // A yellow color
color pink  = #e23bdd; // A pink color
color blue  = #2758dd; // A blue color
color lblue = #1ee8e4; // A light blue color
color w =  #FFFFFF; // A white color
color current_color = red; // The current color of the mandala

float x,y; // The x and y coordinates of the ellipse
float iterationCounter = 0; // A counter for the iterations of the draw loop

float a = 2.5; // A variable for controlling the shape of the mandala
float b = 2.4; // A variable for controlling the shape of the mandala

float incrVal = -0.01; // The increment value for the b variable

color[] colors = {red, green, yellow, pink, lblue}; // An array of colors for the mandala

void setup() {
  size(1400,1400); // Set the size of the canvas
  
  x = width/2; // Set the x coordinate of the ellipse to the center of the canvas
  y = height/2; // Set the y coordinate of the ellipse to the center of the canvas
  
  angle = 2 * PI / pow(2,order); // Calculate the angle of rotation for each line
  background(0); // Set the background to black
  
  // Set the center of the canvas as the origin for the transformation
  translate(width/2,height/2); 
  
  // Draw the lines of the mandala
  for(int i = 0 ; i < pow(2,order) ; i++) {
    rotate(-angle); // Rotate the canvas around the z axis
    stroke(0,0,0,100); // Set the stroke color and transparency
    line(0,0,len,0); // Draw a line from the center of the canvas to the edge
  }
}

void draw() {
  // Set the center of the canvas as the origin for the transformation
  translate(width/2,height/2);
  
  // Save the current frame as a PNG image if the frame count is a multiple of 20
  if(frameCount%20==0) saveFrame("GifPhotos/Photo-#####.png");
  
  iterationCounter += 1; // Increment the iteration counter
  float value = iterationCounter/5; // Calculate a value based on the iteration counter
  
  // Change the current color of the mandala every three iterations
  if(iterationCounter % 3 == 0) {
    current_color = getNextColor();
  }
  
  // Increment the b variable by the increment value
  b += incrVal;
  
  // Reverse the direction of the increment value when b reaches the limits of its range
  if(b <= -2.4) incrVal = 0.01;
  if(b >= 2.4) incrVal = -0.01;
  
    // Calculate the x and y coordinates of the ellipse based on the a and b variables
  x = (a + b*value) * cos(value) + width/2;
  y = (a + b*value) * sin(value) + height/2;
  
  // Rotate the canvas around the x and y axes
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);
  
  // Draw the ellipse at the calculated coordinates
  placeEllipse(x,y);
}

// A function for drawing the ellipse at a given position
void placeEllipse(float xPos,float yPos) {
  for(int i = 0 ; i < pow(2,order) ; i++) {
    rotate(-angle); // Rotate the canvas around the z axis
    fill(current_color); // Set the fill color
    noStroke(); // Disable the stroke
    ellipse(xPos-width/2,yPos-height/2,4,4); // Draw an ellipse at the given position
  }
}

// A function for selecting a random color from the colors array
color getNextColor() {
  int randIt = int(random(1,4)); // Generate a random index for the colors array
  return colors[randIt]; // Return the color at the random index
}

// A function for placing an ellipse at the current mouse position when the mouse is dragged
void mouseDragged() {
  placeEllipse(mouseX,mouseY);
}

// A function for handling key presses
void keyPressed() {
  // Change the current color of the mandala based on the key pressed
  switch(key) {
    case 'r' : current_color = red; break;
    case 'b' : current_color = blue; break;
    case 'g' : current_color = green; break;
    case  'p' : current_color = pink; break;
    case 'y' : current_color = yellow; break;
    case 'l' : current_color = lblue; break;
    case 'w' : current_color = w; break;
    case 's' : saveFrame(); // Save the current frame as a PNG image
  }
}
