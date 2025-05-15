class Particle {
  PVector position, velocity;
  float radius;
  float elasticity = 0.8; // Factor de rebote
  color particleColor;
  
  Particle(float x, float y, float vx, float vy, float r, color c) {
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    radius = r;
    particleColor = c;
  }
  
  void update() {
    position.add(velocity);
  }
  
  void checkCollisionLinea(Pared pd) {
    PVector a = pd.getA();
    PVector ap = PVector.sub(position, a);
    PVector ab = pd.getAB();
    float t = PVector.dot(ap, ab) / PVector.dot(ab, ab);
    t = constrain(t, 0, 1);
    PVector closest = PVector.add(a, PVector.mult(ab, t));
    float distance = PVector.dist(position, closest);
    
    if (distance < radius) {
      PVector normal = PVector.sub(position, closest).normalize();
      float nv = PVector.dot(normal, velocity);
      PVector Vn = PVector.mult(normal, nv);
      PVector Vt = PVector.sub(velocity, Vn);
      velocity = PVector.sub(Vt, PVector.mult(Vn, elasticity));
      position.add(PVector.mult(normal, radius - distance));
    }
  }
  
  void checkCollisionParticles(ArrayList<Particle> particles) {
    for (Particle other : particles) {
      if (other == this) continue;
      float d = PVector.dist(position, other.position);
      if (d < radius * 2) {
        PVector normal = PVector.sub(position, other.position).normalize();
        PVector relativeVelocity = PVector.sub(velocity, other.velocity);
        float nv = PVector.dot(normal, relativeVelocity);
        if (nv < 0) {
          PVector impulse = PVector.mult(normal, -nv * (1 + elasticity));
          velocity.add(impulse);
          other.velocity.sub(impulse);
        }
      }
    }
  }
  
  void display() {
    fill(particleColor);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
