//VARIABLES GLOBALES
float radius = 50; // Radio de la partícula (esférica)
float density = 0.0001; // Densidad del fluido (agua)
float g = 9.8; // Gravedad
float _timeStep = 0.1;
float M=1;
float KD = 0.08;

//Variables 
PVector posPart;
Particle p;
float hA; // Altura del agua


void setup() {
  size(800, 500);
  posPart = new PVector(width/2, radius);
  hA = height/2 + 50;
  p = new Particle(M, posPart, radius);
}
void keyPressed()
{
   if (key == 'r' || key == 'R')
      setup();
}
void draw() {
  background(255);
  p.update(_timeStep);
  // Dibujar agua
  fill(0, 0, 255, 100); 
  stroke(0, 0, 255, 100);
  rect(0, hA, width, height);
  p.draw();
}
