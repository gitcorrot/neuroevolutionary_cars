class Car {

  int size_w, size_h, speed;
  float rotation;
  PVector pos;

  Car(int x, int y, int w, int h, int speed) {
    this.pos = new PVector(x, y); 
    this.size_w = w;
    this.size_h = h;
    this.speed = speed;
    this.rotation = 90; // to head forward
  }

  void rotateBy(float angle) {
    this.rotation += angle;
  }

  PVector findObstacles(ArrayList<Obstacle> obstacles, float offset) {

    ArrayList<PVector> intersections = new ArrayList();

    for (Obstacle o : obstacles) {
      float x1 = o.x1;
      float y1 = o.y1;
      float x2 = o.x2;
      float y2 = o.y2;

      float x3 = this.pos.x;
      float y3 = this.pos.y;
      // add 0.0001 to avoid vector being 0.
      float x4 = this.pos.x + PVector.fromAngle(radians(this.rotation + offset)).x + 0.0001;
      float y4 = this.pos.y + PVector.fromAngle(radians(this.rotation + offset)).y + 0.0001;

      float den = ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));

      if (den == 0) return null;

      float t =  ((x1 - x3)*(y3 - y4) - (y1 - y3)*(x3 - x4)) / den;
      float u = -((x1 - x2)*(y1 - y3) - (y1 - y2)*(x1 - x3)) / den;

      if (t > 0 && t < 1 && u > 0) {
        //intersections.add(new PVector(x1 + t*(x2 - x1), y1 + t*(y2 - y1)));
        intersections.add(new PVector(x3 + u*(x4 - x3), y3 + u*(y4 - y3)));
      }
    }

    return getNearest(intersections, this.pos);
  }

  PVector getNearest(ArrayList<PVector> vectors, PVector position) {
    PVector shortest = new PVector();
    float dist = 10000000; // it should never be bigger.
    for (PVector v : vectors) {
      if (PVector.dist(position, v) < dist) {
        dist = PVector.dist(position, v);
        shortest.set(v.x, v.y);
      }
    }

    return shortest;
  }

  void update() {
    if (rotation >  360) rotation = rotation % 360;
    if (rotation < -360) rotation = rotation % 360;

    PVector vel = PVector.fromAngle(radians(this.rotation));
    this.pos.add(vel);
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
