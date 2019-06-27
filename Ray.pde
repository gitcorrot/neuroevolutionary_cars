class Ray {

  int offset;
  
  //-----------------------------------------------------------------------------------------//

  Ray(int offset) {
    this.offset = offset;
  }
  
  //-----------------------------------------------------------------------------------------//

  float findObstacles(ArrayList<Obstacle> obstacles, PVector pos, float rotation) {

    ArrayList<PVector> intersections = new ArrayList();

    for (Obstacle o : obstacles) {
      float x1 = o.x1;
      float y1 = o.y1;
      float x2 = o.x2;
      float y2 = o.y2;

      float x3 = pos.x;
      float y3 = pos.y;
      // add 0.0001 to avoid vector being 0.
      float x4 = pos.x + PVector.fromAngle(radians(rotation + offset)).x + 0.0001;
      float y4 = pos.y + PVector.fromAngle(radians(rotation + offset)).y + 0.0001;

      float den = ((x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4));

      if (den == 0) return 0;

      float t =  ((x1 - x3)*(y3 - y4) - (y1 - y3)*(x3 - x4)) / den;
      float u = -((x1 - x2)*(y1 - y3) - (y1 - y2)*(x1 - x3)) / den;

      if (t > 0 && t < 1 && u > 0) {
        //intersections.add(new PVector(x1 + t*(x2 - x1), y1 + t*(y2 - y1)));
        intersections.add(new PVector(x3 + u*(x4 - x3), y3 + u*(y4 - y3)));
      }
    }

    return PVector.dist(pos, getNearest(intersections, pos));
  }
  
  //-----------------------------------------------------------------------------------------//

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
}
