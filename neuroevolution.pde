import org.neuroph.core.*;
import org.neuroph.nnet.*;
import org.neuroph.util.*;

import java.util.*;

ArrayList<Obstacle> obstacles = new ArrayList();
Car car;
int thickness = 150;
int speed = 10;
int start_x = 70;
int start_y = 50;

void setup() {
  size(800, 600);
  initializeObstacle();

  car = new Car(start_x, start_y, 40, 10, speed);
}

void draw() {
  background(255, 255, 255);
  
  for (Obstacle o : obstacles) {
    o.show();
  }

  PVector obst = car.llIntersection(obstacles);
  if (obst != null) {
    line(car.pos.x, car.pos.y, obst.x, obst.y);
    println("x: " + obst.x + "  y: " + obst.y);
  }

  car.update();
  car.show();
}


void keyPressed() {
  if (key == 'a') {
    car.rotateBy(-5);
  }
  if (key == 'd') {
    car.rotateBy(5);
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
