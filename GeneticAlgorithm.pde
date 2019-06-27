class GeneticAlgorithm {

  float totalFitness;

  //-----------------------------------------------------------------------------------------//

  ArrayList<Car> initPopulation() {

    ArrayList<Car> mCars = new ArrayList();

    for (int i = 0; i < POPULATION_SIZE; i++) {
      mCars.add(new Car((int)start.x, (int)start.y, 30, 10, SPEED));
    }
    return mCars;
  } 

  //-----------------------------------------------------------------------------------------//

  ArrayList<Car> newPopulation() {

    ArrayList<Car> mCars = new ArrayList();

    this.calculateTotalFitness();

    for (int i = 0; i < POPULATION_SIZE; i++) {
      mCars.add(crossover(selection(), selection()));
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

    // println("TOTAL Fitness: " + this.totalFitness);
  }

  //-----------------------------------------------------------------------------------------//

  // Roulette Wheel Selection
  Car selection() {
    float r = random(this.totalFitness);
    float sum = 0;
    int index = 0;

    while (sum < r) {
      sum += cars.get(index).fitness; 
      index += 1;
    }

    return cars.get(index-1);
  }

  //-----------------------------------------------------------------------------------------//

  Car crossover(Car c1, Car c2) {   

    MultiLayerPerceptron newBrain = new MultiLayerPerceptron(4, 4, 1);

    Double[] weights1 = c1.brain.getWeights();
    Double[] weights2 = c2.brain.getWeights();

    double[] newWeights = new double[weights1.length];

    if (weights1.length == weights2.length) {
      for (int i = 0; i < weights1.length; i++) {
        if (random(1) < 0.5) {
          newWeights[i] = weights1[i];
        } else {
          newWeights[i] = weights2[i];
        }
      }
    } else 
    println("ERROR!!! Different weights lengths!");

    newBrain.setWeights(newWeights);
    
    if (random(1) < MUTATION_RATE) {
      newBrain = mutation(newBrain);
    }
    
    return new Car((int)start.x, (int)start.y, 30, 10, SPEED, newBrain);
  }

  //-----------------------------------------------------------------------------------------//

  MultiLayerPerceptron mutation(MultiLayerPerceptron b) {
    Double[] w = b.getWeights();
    double[] newWeights = new double[w.length];

    for (int i = 0; i < w.length; i++) {
      if (random(1) < 0.3) 
        newWeights[i] = random(-1, 1);
      else 
        newWeights[i] = w[i];
    }

    b.setWeights(newWeights);
    return b;
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
