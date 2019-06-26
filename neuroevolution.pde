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

  PVector closest_obst = car.findObstacles(obstacles, -60);
  if (closest_obst != null 
    && closest_obst.x != 0 
    && closest_obst.y != 0) { // to avoid pointing 0,0 
    line(car.pos.x, car.pos.y, closest_obst.x, closest_obst.y);
  }

  PVector closest_obst2 = car.findObstacles(obstacles, 60);
  if (closest_obst2 != null 
    && closest_obst2.x != 0 
    && closest_obst2.y != 0) { // to avoid pointing 0,0 
    line(car.pos.x, car.pos.y, closest_obst2.x, closest_obst2.y);
  }
  
  PVector closest_obst3 = car.findObstacles(obstacles, 0);
  if (closest_obst3 != null 
    && closest_obst3.x != 0 
    && closest_obst3.y != 0) { // to avoid pointing 0,0 
    line(car.pos.x, car.pos.y, closest_obst3.x, closest_obst3.y);
  }

  car.update();
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
