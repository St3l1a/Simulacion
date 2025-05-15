// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle(PVector v) {
    particles.add(new Particle(origin, v));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {//Coge todas las particulas y les dice que hagan 1 paso
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {//Les pregunta si están muertas al hacer el paso y si están las quita de la lista
        particles.remove(i);
      }
    }
  }
}
