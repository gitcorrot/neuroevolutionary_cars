class Car {

  int size_w, size_h, speed;
  float rotation;
  float dist1, dist2, dist3;
  boolean dead;
  PVector pos;
  ArrayList<Ray> rays;

  Car(int x, int y, int w, int h, int speed) {
    this.pos = new PVector(x, y); 
    this.size_w = w;
    this.size_h = h;
    this.speed = speed;
    this.rotation = 90; // to head forward
    this.dead = false;
    dist1 = 999;
    dist2 = 999;
    dist3 = 999;

    rays = new ArrayList() {
      {
        add(new Ray(0));
        add(new Ray(60));
        add(new Ray(-60));
      }
    };
  }

  void rotateBy(float angle) {
    if (!dead)
      this.rotation += angle;
  }

  void updateDistances(ArrayList<Obstacle> obs) {
    dist1 = rays.get(0).findObstacles(obs, this.pos, this.rotation);
    dist2 = rays.get(1).findObstacles(obs, this.pos, this.rotation);
    dist3 = rays.get(2).findObstacles(obs, this.pos, this.rotation);
    //println("dist1: " + dist1 + "  dist2: " + dist2 + "  dist3: " + dist3);
  }

  void update() {
    if (dist1 < 10 || dist2 < 10 || dist3 < 10) {
      this.dead = true;
    } else {
      if (rotation >  360 || rotation < -360) rotation = rotation % 360;

      PVector vel = PVector.fromAngle(radians(this.rotation));
      this.pos.add(vel.mult(speed));
    }
  }

  void show() {
    fill(0, 0, 255);
    strokeWeight(1);
    pushMatrix();
    rectMode(CENTER);
    translate(this.pos.x, this.pos.y);
    rotate(radians(rotation));
    rect(0, 0, this.size_w, this.size_h);
    popMatrix();
  }
}
