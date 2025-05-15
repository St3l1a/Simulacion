/*
 LLEVAR UNA PARTICULA P1 A P2
a) Podemos definir el punto P2

b) Podemos definir un vector c que sea la carretera
  c que tiene su modulo y su argumento = (1,-1)
  El vector velocidad del coche no es el mismo que el carretera, pueden valer lo mismo pero no confundirlos

*/

//Variables globales
PVector particula;
int radio, ntramos, tramo;
PVector [] carretera; //La carretera será un array de puntos que tiene P1 y P2
PVector [] velocidades; //Pondremos una velocidad en cada tramo
float dt;
//Inicializamos variables en setup
void setup() {
  size(640, 360, P3D);
  radio = 20;
  ntramos = 2;
  particula = new PVector(radio, height/2);
  
  carretera = new PVector[ntramos];
  carretera[0] =  new PVector(particula.x,particula.y);
  for(int i=1; i<ntramos; i++)
    carretera[i] = new PVector(width/2, radio);
    
  velocidades = new PVector[ntramos];
  for(int i=0; i<ntramos; i++)
  {
    if(i+1<ntramos)
    {      
      PVector c = PVector.sub(carretera[i+1], carretera[i]); //restamos
      //La velocidad es la direccion del tramo y modulo que queramos. Usaremos 50
      c.normalize(); //Normalizamos c para obtener la dirección normalizada
      velocidades[i] = c.mult(random(50)); //Ahora cambia el valor de c con el resultado de la multiplicación, si queremos que no modifique el valor de c al multiplicar PVector.mult(c,50)
     // println("Velocidad tramo " + str(i), velocidades[i]);
  
    }
  }
  tramo = 0;
  dt = 0.2;
}

void draw() {
  background(255); //Color de fondo, se puede poner en rgb
  
  //CARRETERA 
  fill(10);
  for(int i=0; i<ntramos; i++)
  {
    ellipse(carretera[i] .x, carretera[i].y, radio, radio); 
      if(i+1<ntramos)
       line(carretera[i] .x, carretera[i].y,carretera[i+1] .x, carretera[i+1].y); //Le pasamos P1.x,P1.y,P2.x,P2.y
  }
    
  //PARTICULA
  fill(255,0,0); //Rellena la figura
  //stroke(100,0,0); //Color de borde de la figura
  
  //Miramos en que tramo estamos para actualizar la velocidad
  if(tramo == 0)
    if(particula.dist(carretera[1]) < radio)
      tramo += 1;
      
  if(tramo < ntramos-1){
  particula.add( PVector.mult(velocidades[tramo],dt)); //Actualizamos particula sumandole la multiplicacion de velocidades con dt, el valor de velocidades no lo cambiamos
  ellipse(particula.x, particula.y, radio, radio); //Posicion X, Posicion Y, radio X, radio Y
  }
  else
  {
    setup();
  }
}
