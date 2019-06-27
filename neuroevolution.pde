import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;
import controlP5.*;

//-----------------------------------------------------------------------------------------//

static final int THICKNESS = 150;
static final int POPULATION_SIZE = 100;

static float MUTATION_RATE = 0.05;
static float MAX_DISTANCE = 75;
static float SPEED = 10;
static float TURNING_SPEED = 5;
static int generation;


PFont  myFont;

ArrayList<Obstacle> obstacles;
ArrayList<Car> cars;
PVector start, finish;

Obstacle finishLine;
GeneticAlgorithm ga;

ControlP5 GUI;
Slider slider_mutationRate;
Slider slider_speed;
Slider slider_turningSpeed;
Slider slider_maxDistance;
Button button_killAll;

//-----------------------------------------------------------------------------------------//

void setup() {
  size(800, 600);
  frameRate(60);
  //finish = new PVector(2*THICKNESS, height-THICKNESS/2);
  
  myFont = createFont("Microsoft Sans Serif", 16);

  finishLine = new Obstacle(width-THICKNESS, width-5, 50, 50);
  finishLine.c = color(0, 255, 0);

  start = new PVector(70, 50);
  finish = finishLine.getCenter();

  initializeGUI();
  initializeObstacles();

  ga = new GeneticAlgorithm();
  cars = ga.initPopulation();

  generation = 0;
}

//-----------------------------------------------------------------------------------------//

void draw() {
  background(255, 255, 255);

  MUTATION_RATE = slider_mutationRate.getValue();
  MAX_DISTANCE = slider_maxDistance.getValue();
  SPEED = slider_speed.getValue();
  TURNING_SPEED = slider_turningSpeed.getValue();

  ellipseMode(CENTER);
  stroke(0);
  fill(120, 255, 55);
  ellipse(start.x, start.y, 55, 55);
  fill(255, 55, 120);
  ellipse(finish.x, finish.y, 55, 55);

  textSize(24);
  textAlign(CENTER);
  text("Generation: " + generation, width/2, 50); 

  finishLine.show();

  for (Obstacle o : obstacles) {
    o.show();
  }

  if (ga.checkAllDead()) {
    cars = ga.newPopulation();
    generation++;
  }

  for (Car car : cars) {
    if (!car.dead) {
      car.updateDistances(obstacles);
      car.update();
      car.show();
    }
  }
}

//-----------------------------------------------------------------------------------------//

//public void controlEvent(ControlEvent theEvent) {

//  if(theEvent.getController().getName() == "Kill all") {
//    ga.killAll();
//  }
//}

public void KillAll(int theValue) {
  if (theValue == 1) {
    ga.killAll();
  }
}

//-----------------------------------------------------------------------------------------//

void initializeObstacles() {

  obstacles = new ArrayList();

  obstacles.add(new Obstacle(width - THICKNESS, width - THICKNESS, 5, height - THICKNESS));
  obstacles.add(new Obstacle(width - THICKNESS, THICKNESS, height - THICKNESS, height - THICKNESS));
  obstacles.add(new Obstacle(THICKNESS, THICKNESS, height - THICKNESS, 5));

  obstacles.add(new Obstacle(5, THICKNESS, 5, 5));
  obstacles.add(new Obstacle(width-THICKNESS, width-5, 5, 5));

  obstacles.add(new Obstacle(5, 5, 5, height-5));
  obstacles.add(new Obstacle(width-5, width-5, 5, height-5));
  obstacles.add(new Obstacle(5, width-5, height-5, height-5));

  // after finish
  //obstacles.add(new Obstacle(350, 350, height-THICKNESS, height-5));
}

//-----------------------------------------------------------------------------------------//

void initializeGUI() {
  GUI = new ControlP5(this);

  slider_mutationRate = 
    GUI.addSlider("Mutation rate")
    .setFont(myFont)
    .setPosition(width/3, 80)
    .setSize(200, 20)
    .setRange(0, 0.5)
    .setValue(MUTATION_RATE)
    .setColorCaptionLabel(color(20, 20, 20));

  slider_speed = 
    GUI.addSlider("Speed")
    .setFont(myFont)
    .setPosition(width/3, 120)
    .setSize(200, 20)
    .setRange(0, 20)
    .setValue(SPEED)
    .setColorCaptionLabel(color(20, 20, 20));

  slider_turningSpeed = 
    GUI.addSlider("Turning speed")
    .setFont(myFont)
    .setPosition(width/3, 160)
    .setSize(200, 20)
    .setRange(0, 10)
    .setValue(TURNING_SPEED)
    .setColorCaptionLabel(color(20, 20, 20));

  slider_maxDistance = 
    GUI.addSlider("Max sight distance")
    .setFont(myFont)
    .setPosition(width/3, 200)
    .setSize(200, 20)
    .setRange(0, 150)
    .setValue(MAX_DISTANCE)
    .setColorCaptionLabel(color(20, 20, 20));

  button_killAll =
    GUI.addButton("KillAll")
    .setFont(myFont)
    .setPosition(width/3, 240)
    .setSize(100, 50)
    .setColorCaptionLabel(color(20, 20, 20));
}

//-----------------------------------------------------------------------------------------//

// DEBUGGING
void keyPressed() {
  if (key == 'a') {
    cars.get(0).rotateBy(TURNING_SPEED);
  }
  if (key == 'd') {
    cars.get(0).rotateBy(-TURNING_SPEED);
  }
}
