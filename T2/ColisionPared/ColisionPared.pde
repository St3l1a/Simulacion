ArrayList<Particle> particles;
Pared pared;

void setup() {
  size(600, 400);
  pared = new Pared(new PVector(200, 100), new PVector(400, 300));
  particles = new ArrayList<Particle>();
}


void draw() {
  background(200);
  pared.display();
  for (Particle p : particles) {
    p.update();
    p.checkCollisionLinea(pared);
    p.checkCollisionParticles(particles);
    p.display();
  }
}


void mousePressed() {
  color c = color(255,0,0);
  
  particles.add(new Particle(mouseX, mouseY, random(-2, 2), random(-2, 2), 10, c));
  
}
