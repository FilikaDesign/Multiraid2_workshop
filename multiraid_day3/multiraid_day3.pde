// To get sound input or sound files data import minim lib
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioInput in;

import controlP5.*;

ControlP5 cp5;

// Import pdf library to use pdf methods
import processing.pdf.*;

int save;

int centerX;
int centerY;


// Rectangle variables
int rect_radius;
int rect_num;
int rect_w;
int rect_h;
int rect_thickness;
boolean drawRectangles;

// Line variables
int line_radius;
int line_num;
int line_w;
int line_thickness;
boolean drawLines;

// Circles variables
int circle_radius;
int circle_num;
int circle_r;
int circle_thickness;
boolean drawCircles;

void setup() {
  size(1024, 768);
  background(0);
  
  initSound();
  // set save var default value to false
  save = 0;

  // Default Rectangle variables
  rect_radius = 180;
  rect_num = 12;
  rect_w = 30;
  rect_h = 30;
  rect_thickness = 1;
  drawRectangles = true;

  // Default Line variables
  line_radius = 10;
  line_num = 12;
  line_w = 70;
  line_thickness = 1;
  drawLines = true;

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
  // create a toggle
  cp5.addToggle("drawLines")
    .setPosition(lineX, lineY)
      .setSize(10, 10)
        .setValue(drawLines)
          ;

  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("line_radius")
    .setPosition(lineX, 20+lineY + gapY)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(line_radius)
            ;

  cp5.addSlider("line_num")
    .setPosition(lineX, 20+lineY + (gapY)*2)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(line_num)
            ;
  cp5.addSlider("line_w")
    .setPosition(lineX, 20+lineY + (gapY)*3)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(line_w)
            ;

  cp5.addSlider("line_thickness")
    .setPosition(lineX, 20 + lineY + (gapY)*4)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(line_thickness)
            ;



  // RECTANGLES
  int rect_gap_x = 200;
  cp5.addToggle("drawRectangles")
    .setPosition(lineX + rect_gap_x, lineY)
      .setSize(10, 10)
        .setValue(drawRectangles)
          ;

  cp5.addSlider("rect_radius")
    .setPosition(lineX + rect_gap_x, 20 + lineY + gapY)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(rect_radius)
            ;

  cp5.addSlider("rect_num")
    .setPosition(lineX + rect_gap_x, 20 + lineY + gapY*2)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(rect_num)
            ;

  cp5.addSlider("rect_w")
    .setPosition(lineX + rect_gap_x, 20 + lineY + gapY*3)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(rect_w)
            ;

  cp5.addSlider("rect_h")
    .setPosition(lineX + rect_gap_x, 20 + lineY + gapY*4)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(rect_h)
            ;

  cp5.addSlider("rect_thickness")
    .setPosition(lineX + rect_gap_x, 20 + lineY + gapY*5)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(rect_thickness)
            ;


  // CIRCLES
  cp5.addToggle("drawCircles")
    .setPosition(lineX + rect_gap_x*2, lineY)
      .setSize(10, 10)
        .setValue(drawCircles)
          ;

  cp5.addSlider("circle_radius")
    .setPosition(lineX + rect_gap_x*2, 20 + lineY + gapY)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(circle_radius)
            ;

  cp5.addSlider("circle_num")
    .setPosition(lineX + rect_gap_x*2, 20 + lineY + gapY*2)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(circle_num)
            ;

  cp5.addSlider("circle_r")
    .setPosition(lineX + rect_gap_x*2, 20 + lineY + gapY*3)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(circle_r)
            ;

  cp5.addSlider("circle_thickness")
    .setPosition(lineX + rect_gap_x*2, 20 + lineY + gapY*4)
      .setSize(100, 10)
        .setRange(0, 255)
          .setValue(circle_thickness)
            ;

  cp5.addButton("SaveFile")
    .setValue(save)
      .setPosition(lineX + rect_gap_x*3,lineY)
        .setSize(120, 19)
          ;
}

public void SaveFile(int theValue) {
  save = theValue;
  
  println(save);
}

void draw() {
  
  // analyze sound
  analyzeInputSound();
  
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

  // RECTANGLES
  float x, y;

  // to make equal space around 360 degree of circle
  float anglePerRect = 360.0f / rect_num;  

  strokeWeight(rect_thickness);
  for (int num=0; num < rect_num; num+= 1) {

    float rad = num * anglePerRect * (PI / 180);

    x = centerX + (rect_radius * cos(rad));
    y = centerY + (rect_radius * sin(rad));

    noFill();
    pushMatrix();

    translate(x, y);
    rectMode(CENTER);
    rotate(rad);
    //radians(num * anglePerRect)
    stroke(255);

    if (drawRectangles == true) {
      rect(0, 0, rect_w, rect_h);
    }

    rectMode(CORNER);
    popMatrix();
  }
  // RECTANGLE END


  // LINES
  strokeWeight(line_thickness);
  float xl, yl;

  // to make equal space around 360 degree of circle
  float anglePerLine = 360.0f / line_num;  

  for (int num=0; num < line_num; num+= 1) {

    float rad = num * anglePerLine * (PI / 180);

    xl = centerX + (line_radius * cos(rad));
    yl = centerY + (line_radius * sin(rad));

    noFill();
    pushMatrix();

    translate(xl, yl);
    rotate(rad);
    stroke(255);

    if (drawLines == true) {
      line(0, 0, line_w, 0);
    }

    rectMode(CORNER);
    popMatrix();
  }

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
/*
  if (keyPressed && key == 'q') {
    rect_radius++;
  }

  if (keyPressed && key == 'a') {
    rect_radius--;
  }

  if (keyPressed && key == 'w') {
    rect_num++;
  }

  if (keyPressed && key == 's') {
    rect_num--;
  }*/
}

void keyPressed() {

  if (key >= 'r') {
    //save = 1;
  }

/*
  if (key == '1') {
    drawRectangles = !drawRectangles;
  }

  if (key == '2') {
    drawLines = !drawLines;
  }

  if (key == '3') {
    drawCircles = !drawCircles;
  }

  if (key == 'a') {
    rect_radius--;
  }*/
}

void initSound() {
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}


void analyzeInputSound() {
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line_radius = 100 + int(in.left.get(i)*2500);
    circle_radius = -50 + int(in.right.get(i)*1000);
    rect_radius = 200 + int(in.left.get(i)*1000);
    //println(in.left.get(i));
    //line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    //line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
  }
  
  //rect_radius = int(in.getGain());  
}