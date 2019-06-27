class Car {

  int size_w, size_h, speed;
  float rotation;
  float dist1, dist2, dist3;
  boolean dead;
  float fitness;
  PVector pos;
  ArrayList<Ray> rays;

  //-----------------------------------------------------------------------------------------//

  Car(int x, int y, int w, int h, int speed) {
    this.pos = new PVector(x, y); 
    this.size_w = w;
    this.size_h = h;
    this.speed = speed;
    this.rotation = 90; // to head forward
    this.dead = false;
    this.fitness = 0;
    this.dist1 = MAX_DISTANCE;
    this.dist2 = MAX_DISTANCE;
    this.dist3 = MAX_DISTANCE;

    rays = new ArrayList() {
      {
        add(new Ray(0));
        add(new Ray(60));
        add(new Ray(-60));
      }
    };
  }

  //-----------------------------------------------------------------------------------------//

  void rotateBy(float angle) {
    if (!dead)
      this.rotation += angle;
  }

  //-----------------------------------------------------------------------------------------//

  void updateDistances(ArrayList<Obstacle> obs) {
    this.dist1 = constrain(rays.get(0).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    this.dist2 = constrain(rays.get(1).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    this.dist3 = constrain(rays.get(2).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    println("dist1: " + this.dist1 + "  dist2: " + this.dist2 + "  dist3: " + this.dist3);
  }

  //-----------------------------------------------------------------------------------------//

  void update() {
    if (!this.dead) {

      if (this.dist1 < 10 || this.dist2 < 10 || this.dist3 < 10) 
        this.dead = true;

      if (PVector.dist(this.pos, finish) < 25) 
        this.dead = true; 

      if (this.rotation >  360 || this.rotation < -360) 
        this.rotation = this.rotation % 360;

      PVector vel = PVector.fromAngle(radians(this.rotation));
      this.pos.add(vel.mult(this.speed));
    }
  }

  //-----------------------------------------------------------------------------------------//

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
