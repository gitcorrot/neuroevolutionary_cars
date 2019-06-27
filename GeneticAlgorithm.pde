class GeneticAlgorithm {

  float totalFitness;

  //-----------------------------------------------------------------------------------------//

  ArrayList<Car> newPopulation() {

    ArrayList<Car> mCars = new ArrayList();

    for (int i = 0; i < POPULATION_SIZE; i++) {
      mCars.add(new Car((int)start.x, (int)start.y, 30, 10, SPEED));
    }
    return mCars;
  }

  //-----------------------------------------------------------------------------------------//

  void calculateTotalFitness() {
    float fitness = 0;

    for (Car c : cars) {
      fitness += c.fitness;
    }
    this.totalFitness = fitness;
  }

  //-----------------------------------------------------------------------------------------//

  boolean checkAllDead() {
    for (Car c : cars) {
      if (!c.dead) return false;
    }
    return true;
  }

  //-----------------------------------------------------------------------------------------//

  void killAll() {
    for (Car c : cars) {
      c.kill();
    }
  }
}
