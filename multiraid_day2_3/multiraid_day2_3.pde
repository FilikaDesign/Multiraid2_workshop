import controlP5.*;

ControlP5 cp5;

// Import pdf library to use pdf methods
import processing.pdf.*;
int save;


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

  // GUI
  cp5 = new ControlP5(this);

  int lineX = 20;
  int lineY = 20;
  int gapY  = 15;

  // CIRCLES
  cp5.addToggle("drawCircles")
    .setPosition(lineX, lineY)
    .setSize(10, 10)
    .setValue(drawCircles)
    ;

  cp5.addSlider("circle_radius")
    .setPosition(lineX, 20 + lineY + gapY)
    .setSize(100, 10)
    .setRange(0, 255)
    .setValue(circle_radius)
    ;

  cp5.addSlider("circle_num")
    .setPosition(lineX, 20 + lineY + gapY*2)
    .setSize(100, 10)
    .setRange(0, 255)
    .setValue(circle_num)
    ;

  cp5.addSlider("circle_r")
    .setPosition(lineX, 20 + lineY + gapY*3)
    .setSize(100, 10)
    .setRange(0, 255)
    .setValue(circle_r)
    ;

  cp5.addSlider("circle_thickness")
    .setPosition(lineX, 20 + lineY + gapY*4)
    .setSize(100, 10)
    .setRange(0, 255)
    .setValue(circle_thickness)
    ;


  cp5.addButton("SaveFile") // This is the callback function of the "SaveFile" Button 
    .setValue(save)
    .setPosition(lineX, lineY + gapY*5 + 20)
    .setSize(120, 19)
    ;
}

// Callback function of the SaveFile Button
public void SaveFile(int theValue) {
  save = theValue;
  save = 1;
  
  println(theValue);
}

void draw() {

  // ---------------------------------------------------------------
  // Begin Recording...
  // ---------------------------------------------------------------
  if (save == 1) 
  {
    int d = day();    // Values from 1 - 31
    int m = month();  // Values from 1 - 12
    int y = year();   // 2003, 2004, 2005, etc.
    int h = hour();
    int mi = minute();
    int s = second();

    // Convert to string
    String cday = String.valueOf(d);
    String cmonth = String.valueOf(m);
    String cyear = String.valueOf(y);
    String chour = String.valueOf(h);
    String cminute = String.valueOf(mi);
    String csecond = String.valueOf(s);

    beginRecord(PDF, "name-surname-"+ cyear + "-" + cmonth + "-" + cday + "-" + chour + "." + cminute + "." + csecond +".ai");
  }
  // ---------------------------------------------------------------


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

  // ---------------------------------------------------------------
  // Stop Recording...
  // ---------------------------------------------------------------
  if (save == 1) 
  {
    endRecord();
    save = 0;  // Set it to false to record just single frame
  }
  // ---------------------------------------------------------------
}