import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;

Car car;
ArrayList<Obstacle> obstacles = new ArrayList();
int thickness = 150;
int speed = 2;
PVector start, finish;

void setup() {
  size(800, 600);
  start = new PVector(70, 50);
  finish = new PVector(2*thickness, height-thickness/2);

  initializeObstacle();

  car = new Car((int)start.x, (int)start.y, 30, 10, speed);
}

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
  println(car.dead);
  car.updateDistances(obstacles);
  car.show();
}


void keyPressed() {
  if (key == 'a') {
    car.rotateBy(-6);
  }
  if (key == 'd') {
    car.rotateBy(6);
  }
}

void initializeObstacle() {

  obstacles.add(new Obstacle(width - thickness, width - thickness, 5, height - thickness));
  obstacles.add(new Obstacle(width - thickness, thickness, height - thickness, height - thickness));
  obstacles.add(new Obstacle(thickness, thickness, height - thickness, 5));

  obstacles.add(new Obstacle(5, thickness, 5, 5));
  obstacles.add(new Obstacle(width-thickness, width-5, 5, 5));

  obstacles.add(new Obstacle(5, 5, 5, height-5));
  obstacles.add(new Obstacle(width-5, width-5, 5, height-5));
  obstacles.add(new Obstacle(5, width-5, height-5, height-5));
}
