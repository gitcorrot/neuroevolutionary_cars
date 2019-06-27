import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;

//-----------------------------------------------------------------------------------------//

final int MAX_DISTANCE = 75;
final int SPEED = 2;
final int THICKNESS = 150;

Car car;
ArrayList<Obstacle> obstacles;
PVector start, finish;

//-----------------------------------------------------------------------------------------//

void setup() {
  size(800, 600);
  start = new PVector(70, 50);
  finish = new PVector(2*THICKNESS, height-THICKNESS/2);

  initializeObstacle();

  car = new Car((int)start.x, (int)start.y, 30, 10, SPEED);
}

//-----------------------------------------------------------------------------------------//

void draw() {
  background(255, 255, 255);

  ellipseMode(CENTER);
  fill(120, 255, 55);
  ellipse(start.x, start.y, 55, 55);
  fill(255, 55, 120);
  ellipse(finish.x, finish.y, 55, 55);

  for (Obstacle o : obstacles) {
    o.show();
  }

  car.update();
  car.updateDistances(obstacles);
  car.show();
}

//-----------------------------------------------------------------------------------------//

void initializeObstacle() {

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
    car.rotateBy(-6);
  }
  if (key == 'd') {
    car.rotateBy(6);
  }
}
