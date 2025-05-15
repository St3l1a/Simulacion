/**
 * Simple Particle System
 * by Daniel Shiffman.  
 * 
 * Particles are generated each cycle through draw(),
 * fall with gravity, and fade out over time.
 * A ParticleSystem object manages a variable size (ArrayList) 
 * list of particles. 
 */

ParticleSystem ps;//Crea el sistema de particulas
float dt;
float tasaEmision;
float partAEmitir;

void setup() {
  size(640, 360);
  ps = new ParticleSystem(new PVector(width/2, height));
  tasaEmision = 1000;
  dt = 0.01;
}
void keyPressed()
{
   if (key == '+'){
      tasaEmision+=10;}
   else if (key == '-'){
      tasaEmision-=10;}
}

void draw() {
  background(0);
  //ps.addParticle();//Si solo ponemos esto, en cada frame añade una particula
  
  partAEmitir = tasaEmision*dt;
  for(int i=0; i<partAEmitir;i++)
  {
    int n = i % (int)partAEmitir;
    float angle = -(60+10*n)*PI/180;
    float mag = 4;
    PVector v = PVector.fromAngle(angle);
    v.mult(mag);
    
    ps.addParticle(v); 
  }
   stroke(255);
   fill(255);   
   textSize(20);
   text("Tasa emision: " + tasaEmision,width*0.025, height*0.075);
   text("Particulas a emitir: " + partAEmitir,width*0.025, height*0.125);
  
  ps.run();
}
