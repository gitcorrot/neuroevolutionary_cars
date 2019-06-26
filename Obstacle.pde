class Obstacle {
 
  int x1, x2, y1, y2;
  
  public Obstacle(int x1, int x2, int y1, int y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
  
  void show() {
    strokeWeight(5);
    line(x1,y1,x2,y2);    
  }

}
