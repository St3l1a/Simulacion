// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l, PVector v) {
    acceleration = new PVector(0, 0.05);
    velocity = v;
    velocity.mult((random(1,1.2)));
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {//Observamos que usa euler simpletico
    velocity.add(acceleration);//Calcula integrando con paso=1 porque no les importa mucho la precision
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    stroke(0,0,255, lifespan);
    fill(0,0,255, lifespan);
    ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
