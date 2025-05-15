/*
 Simular el movimiento de una partcula que se mueve a tramos de velocidad (ej. con pendientes distintas en cada tramo y velocidades en funcion de las pendientes ).

*/

//Variables globales
PVector particula;
int radio, ntramos, tramo;
PVector [] carretera; //La carretera será un array de puntos que tiene P1 y P2
PVector [] velocidades; //Pondremos una velocidad en cada tramo
float dt;
//Inicializamos variables en setup
void setup() 
{
  size(640, 360, P3D);//Tamaño pantalla
  radio = 20;//Radio particula
  particula = new PVector(radio, height/2);//Posicion inicial particula
  
  tramo = 0;
  dt = 0.2;
  
  //Añado los tramos que quiero y sus posiciones
  ntramos = 4;
  carretera = new PVector[ntramos];
  carretera[0] =  new PVector(particula.x,particula.y);
  carretera[1] = new PVector(width/3, radio);
  carretera[2] = new PVector(width/2, height-radio);
  carretera[3] = new PVector(width-radio, height/3);
    
  //Calculamos las velocidades 
  velocidades = new PVector[ntramos-1];
  for(int i=0; i<ntramos; i++)
  {
    if(i+1 < ntramos)
    {      
      PVector c = PVector.sub(carretera[i+1], carretera[i]); //Calculamos la resta entre el punto actual y el siguiente
      //La velocidad es la direccion del tramo y modulo que queramos
      c.normalize(); //Normalizamos c para obtener la dirección normalizada
      velocidades[i] = c.mult(random(50)+10); //Ahora cambia el valor de c con el resultado de la multiplicación, si queremos que no modifique el valor de c al multiplicar PVector.mult(c,50)
  
    }
  }
  
}

void draw() {
  background(255);
  
  //CARRETERA 
  fill(10);
  for(int i=0; i<ntramos; i++)
  {
    ellipse(carretera[i].x, carretera[i].y, radio, radio); 
      if(i+1<ntramos)
       line(carretera[i].x, carretera[i].y,carretera[i+1] .x, carretera[i+1].y);
  }
    
  //PARTICULA
  fill(255,0,0); //Rellena la figura
  
  //Miramos en que tramo estamos para actualizar la velocidad
   
     if(particula.dist(carretera[tramo+1]) < radio)
     {
         particula.set(carretera[tramo+1]);
          tramo += 1;
     }
    if(tramo < ntramos-1)
    {
      //Dibuja la particula
      particula.add(PVector.mult(velocidades[tramo],dt)); //Actualizamos particula sumandole la multiplicacion de velocidades con dt, el valor de velocidades no lo cambiamos
      ellipse(particula.x, particula.y, radio, radio); //Posicion X, Posicion Y, radio X, radio Y
    }
    else
    {
      setup();
    }
  
}
