import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;

//-----------------------------------------------------------------------------------------//

static final int MAX_DISTANCE = 75;
static final int SPEED = 5;
static final int TURNING_SPEED = 3;
static final int THICKNESS = 150;
static final int POPULATION_SIZE = 500;
static final float MUTATION_RATE = 0.1;

static int generation;

ArrayList<Obstacle> obstacles;
ArrayList<Car> cars;
PVector start, finish;

Obstacle finishLine;
GeneticAlgorithm ga;

//-----------------------------------------------------------------------------------------//

void setup() {
  size(800, 600);
  frameRate(60);
  //finish = new PVector(2*THICKNESS, height-THICKNESS/2);

  finishLine = new Obstacle(width-THICKNESS, width-5, 50, 50);
  finishLine.c = color(0, 255, 0);

  start = new PVector(70, 50);
  finish = finishLine.getCenter();

  initializeObstacles();

  ga = new GeneticAlgorithm();
  cars = ga.initPopulation();

  generation = 0;
}

//-----------------------------------------------------------------------------------------//

void draw() {
  background(255, 255, 255);

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

// DEBUGGING
void keyPressed() {
  if (key == 'a') {
    cars.get(0).rotateBy(TURNING_SPEED);
  }
  if (key == 'd') {
    cars.get(0).rotateBy(-TURNING_SPEED);
  }
}
