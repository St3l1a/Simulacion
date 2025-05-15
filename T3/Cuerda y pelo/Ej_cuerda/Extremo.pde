
class Extremo
{
  PVector loc; //posicion
  PVector vel; //velocidad
  PVector acc; //aceleracion
  float Ec, Ep; 
  PVector peso;
  int mode;
  
  //Estas variables servirán para indicar si está siendo modificado 
  PVector drag0;
  boolean dragging = false;
  
  Extremo(float x, float y)
  {
    loc = new PVector(x,y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    drag0 = new PVector(0,0);
   
    peso =  PVector.mult(gravity, mass);
  }
  
  void update()
  {
    vel.add(PVector.mult(acc,dt));
    loc.add(PVector.mult(vel,dt));
    
    acc = new PVector(0,0);
    
    applyForce(peso);
  }
  
  //Función que actualiza la aceleración mediante la fuerza que se le pasa como parámetro y la masa
  
  void applyForce(PVector force) //acumula la fuerza para luego dividirla con la masa
  {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }
  
  void display()
  {
    stroke(0);
    strokeWeight(2);
    fill(175, 120);
    
    if (dragging)
    {
      fill(50);
    }
  }
  
  //Determina si un extremo ha sido pulsado o no
  void clicked(int x, int y)
  {
    float d = dist(x,y,loc.x, loc.y);
    float umbral = 5;
    
    if(d < umbral)
    {
      dragging =true;
      drag0.x = loc.x - x;
      drag0.y = loc.y - y;
    }
  }
  
  void stopDragging()
  {
    dragging = false;
    
  }
  
  //Cambia la posición del extremo según la posición del ratón
  void drag(int mx, int my)
  {
    if(dragging)
    {
      loc.x = mx + drag0.x;
      loc.y = my + drag0.y;
    }
  }
  
}
  
