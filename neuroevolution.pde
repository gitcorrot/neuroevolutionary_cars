import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;

//-----------------------------------------------------------------------------------------//

static final int MAX_DISTANCE = 75;
static final int SPEED = 2;
static final int THICKNESS = 150;
static final int POPULATION_SIZE = 10;

//Car car;
ArrayList<Obstacle> obstacles;
ArrayList<Car> cars;
PVector start, finish;

Obstacle finishLine;
GeneticAlgorithm ga;

//-----------------------------------------------------------------------------------------//

void setup() {
  size(800, 600);
  //finish = new PVector(2*THICKNESS, height-THICKNESS/2);

  finishLine = new Obstacle(300, 300, height-THICKNESS, height-5);
  finishLine.c = color(0, 255, 0);

  start = new PVector(70, 50);
  finish = finishLine.getCenter();

  initializeObstacles();

  ga = new GeneticAlgorithm();
  cars = ga.newPopulation();
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

  for (Obstacle o : obstacles) {
    o.show();
  }

  finishLine.show();

  if (ga.checkAllDead()) {
    ga.calculateTotalFitness();
  }

  for (Car car : cars) {
    car.update();
    car.updateDistances(obstacles);
    car.show();
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
}

//-----------------------------------------------------------------------------------------//

// DEBUGGING
void keyPressed() {
  if (key == 'a') {
    cars.get(0).rotateBy(-6);
  }
  if (key == 'd') {
    cars.get(0).rotateBy(6);
  }
}
