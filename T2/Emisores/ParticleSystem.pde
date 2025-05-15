// Class for a particle system controller
class ParticleSystem
{
   PVector _location;
   ArrayList<Particle> _particles;
   int _nextId;
   
   

   ParticleSystem(PVector location)
   {
      _location = location;
      _particles = new ArrayList<Particle>();
      _nextId = 0;

   }

   void addParticle(float mass, PVector initPos, PVector initVel, float radius, color c, float lifeSpan)
   {
      
      _particles.add(new Particle(this, _nextId, mass, initPos, initVel, radius, c, lifeSpan));
      _nextId++;
   }

   void restart()
   {
      _particles.clear();
   }
  


   int getNumParticles()
   {
      return _particles.size();
   }

   ArrayList<Particle> getParticleArray()
   {
      return _particles;
   }


   void update(float timeStep)
   {
      int n = _particles.size();
      for (int i = n - 1; i >= 0; i--)
      {
         Particle p = _particles.get(i);
          if (!p.isDead())
            p.update(timeStep);
         else
            _particles.remove(i);
      }
      
   }

   void draw()
   {
      int n = _particles.size();
      for (int i = 0; i < n; i++)
      {
         Particle p = _particles.get(i);
         p.draw();
      }
   }
}
