PVector paraca;
PVector velocidad;
float dt;


void setup(){
  size(600,400);
  paraca = new PVector(100,300);
  velocidad = new PVector (1,1);
  textSize(24);
  dt =0.1;
}

void draw(){
  background(255);
  strokeWeight(2);
  noFill();

 dibujar_vector(paraca,velocidad);
 
 paraca = euler(paraca,velocidad);
 velocidad = euler(velocidad, dv_dt(velocidad));
 
 text("posicion: " + paraca,20,30);
  text("v(euler): " + velocidad,20,30);
}


//aceleracion
PVector dv_dt(PVector v)
{
  float m = 60;
  float c = 80;
  PVector g = new PVector(0,-9.8);
 return PVector.sub(g, PVector.mult(v,c/m));
}


  
PVector euler(PVector velocidad,PVector dv_dt)
{
  PVector res;
  res = PVector.add(velocidad, PVector.mult(dv_dt, dt));
  return res;
}
  

  
  
  
