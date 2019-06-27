class Car {

  final int size_w, size_h, speed;
  PVector pos;
  float rotation;
  float fitness;
  double dists[] = new double[4]; // 0-2 sight, 3 - dist to finish
  boolean dead;
  ArrayList<Ray> rays;

  MultiLayerPerceptron brain;

  //-----------------------------------------------------------------------------------------//

  Car(int x, int y, int w, int h, int speed) {
    this.pos = new PVector(x, y); 
    this.size_w = w;
    this.size_h = h;
    this.speed = speed;
    this.rotation = 90; // to head forward
    this.dead = false;
    this.fitness = 0;
    this.dists[0] = MAX_DISTANCE;
    this.dists[1] = MAX_DISTANCE;
    this.dists[2] = MAX_DISTANCE;
    this.dists[3] = 10000;

    rays = new ArrayList() {
      {
        add(new Ray(0));
        add(new Ray(60));
        add(new Ray(-60));
      }
    };

    this.brain = new MultiLayerPerceptron(4, 4, 1);

    //println("\n\nWEIGHTS\n\n");
    //println(this.brain.getWeights());
  }

  //-----------------------------------------------------------------------------------------//

  Car(int x, int y, int w, int h, int speed, MultiLayerPerceptron b) {
    this.pos = new PVector(x, y); 
    this.size_w = w;
    this.size_h = h;
    this.speed = speed;
    this.rotation = 90; // to head forward
    this.dead = false;
    this.fitness = 0;
    this.dists[0] = MAX_DISTANCE;
    this.dists[1] = MAX_DISTANCE;
    this.dists[2] = MAX_DISTANCE;
    this.dists[3] = 10000;

    rays = new ArrayList() {
      {
        add(new Ray(0));
        add(new Ray(60));
        add(new Ray(-60));
      }
    };

    this.brain = b;
  }

  //-----------------------------------------------------------------------------------------//

  void rotateBy(float angle) {
    if (!dead)
      this.rotation += angle;
  }

  //-----------------------------------------------------------------------------------------//

  void updateDistances(ArrayList<Obstacle> obs) {
    this.dists[0] = constrain(rays.get(0).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    this.dists[1] = constrain(rays.get(1).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    this.dists[2] = constrain(rays.get(2).findObstacles(obs, this.pos, this.rotation), 0, MAX_DISTANCE);
    this.dists[3] = PVector.dist(this.pos, finish);

    // println("dist0: " + this.dists[0] + "  dist1: " + this.dists[1] + "  dist2: " + this.dists[2]);
  }

  //-----------------------------------------------------------------------------------------//

  void update() {
    if (!this.dead) {

      if (this.dists[0] < 10 || this.dists[1] < 10 || this.dists[2] < 10) 
        this.kill();

      if (dists[3] < 30) 
        this.win(); 

      if (this.rotation >  360 || this.rotation < -360) 
        this.rotation = this.rotation % 360;

      PVector vel = PVector.fromAngle(radians(this.rotation));
      this.pos.add(vel.mult(this.speed));

      this.brain.setInput(getInputs());
      this.brain.calculate();

      if (this.brain.getOutput()[0] > 0.5) 
        rotateBy(-TURNING_SPEED);
      else
        rotateBy(TURNING_SPEED);
      //if (this.brain.getOutput()[1] > 0.5) 
      //  rotateBy(6);
    }
  }

  //-----------------------------------------------------------------------------------------//

  void calculateFitness() {
    float d = PVector.dist(this.pos, finish);
    this.fitness = 1/d;
    // println("Fitness: " + this.fitness);
  }

  //-----------------------------------------------------------------------------------------//

  void kill() {
    this.dead = true;
    this.calculateFitness();
  }

  //-----------------------------------------------------------------------------------------//

  void win() {
    this.dead = true;
    this.fitness = 1;
  }

  //-----------------------------------------------------------------------------------------//

  double[] getInputs() {
    double[] i = new double[4];

    i[0] = map((float)dists[0], 0, MAX_DISTANCE, 0, 1);
    i[1] = map((float)dists[1], 0, MAX_DISTANCE, 0, 1);
    i[2] = map((float)dists[2], 0, MAX_DISTANCE, 0, 1);
    i[3] = 1 / dists[3];

    return i;
  }

  //-----------------------------------------------------------------------------------------//

  void show() {
    fill(0, 0, 255, 100);
    strokeWeight(1);
    stroke(0);

    pushMatrix();
    rectMode(CENTER);
    translate(this.pos.x, this.pos.y);
    rotate(radians(rotation));
    rect(0, 0, this.size_w, this.size_h);
    popMatrix();
  }
}
