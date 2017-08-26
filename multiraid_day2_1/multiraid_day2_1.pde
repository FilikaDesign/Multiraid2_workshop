int centerX;
int centerY;

// Circles variables
int circle_radius;
int circle_num;
int circle_r;
int circle_thickness;
boolean drawCircles;

void setup() {
  size(1024, 768);
  background(0);

  // Default Circle variables
  circle_radius = 30;
  circle_num = 12;
  circle_r = 10;
  circle_thickness = 1;
  drawCircles = true;

  // Window Center position
  centerX = int(width) / 2;
  centerY = int(height) / 2;
}


void draw() {


  background(0);


  // CIRCLES
  float xc, yc;
  strokeWeight(circle_thickness);

  // to make equal space around 360 degree of circle
  float anglePerCircle = 360.0f / circle_num;  

  for (int num=0; num < circle_num; num+= 1) {

    float rad = num * anglePerCircle * (PI / 180);

    xc = centerX + (circle_radius * cos(rad));
    yc = centerY + (circle_radius * sin(rad));

    noFill();
    pushMatrix();

    translate(xc, yc);
    rotate(rad);
    stroke(255);

    if (drawCircles == true) {
      ellipse(0, 0, circle_r, circle_r);
    }

    rectMode(CORNER);
    popMatrix();
  }
}