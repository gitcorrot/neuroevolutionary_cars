class Obstacle {

  int x1, x2, y1, y2;
  color c;

  //-----------------------------------------------------------------------------------------//

  public Obstacle(int x1, int x2, int y1, int y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.c = color(0);
  }

  //-----------------------------------------------------------------------------------------//

  void show() {
    strokeWeight(5);
    stroke(c);
    line(x1, y1, x2, y2);
  }

  //-----------------------------------------------------------------------------------------//

  // returns distance to line (obstacle)
  float getDistanceFrom(PVector pos) {
    // pos.x, pos.y -> x0, y0
    return ( abs( (this.y2 - this.y1)*pos.x - (this.x2 - this.x1)*pos.y + this.x2*this.y1 - this.y2*this.x1)) 
      / sqrt( (this.y2 - this.y1)*(this.y2 - this.y1) + (this.x2 - this.x1)*(this.x2 - this.x1) );
  }

  //-----------------------------------------------------------------------------------------//

  // not relaible
  PVector getCenter() {
    return new PVector(this.x1 + abs(this.x2 - this.x1) / 2, this.y1 + abs(this.y2 - this.y1) / 2);
  }
}
