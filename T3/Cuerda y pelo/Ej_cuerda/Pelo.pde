
class Pelo
{
  float longitud;
  int nmuelles;
  float Lmuelle;
  PVector origen;
  
  Extremo[] vExtr = new Extremo[NMUELLES+1];
  Muelle[] vMuelles = new Muelle[NMUELLES];
  
  Pelo (float _longitud, int _nmuelles, PVector _origen)
  {
    longitud = _longitud;
    nmuelles = _nmuelles;
    Lmuelle = longitud/nmuelles;
    origen = _origen;
    
    for(int i = 0; i < vExtr.length; i++)
      vExtr[i] = new Extremo (origen.x + i *Lmuelle, origen.y); //inicialización de extremos
    
    for (int i = 0; i<vMuelles.length; i++)
      vMuelles[i] = new Muelle(vExtr[i], vExtr[i+1], Lmuelle); //inicialización de los muelles que unen los extremos
  }
  
  void update()
  {
    //primero actualiza los muelles
    for (Muelle s: vMuelles)
    {
      s.update();
      s.display();
    }
    //Luego actualiza las particulas
    //El bucle deberá empezar desde 1 (y no de 0) para que el primer punto del pelo se quede fijo en la pantalla
    for (int i = 1; i < vExtr.length; i++)
    {
      vExtr[i].update();
      vExtr[i].display();
      vExtr[i].drag(mouseX, mouseY); //recogida de coordenadas de ratón
    }
  }
  
  void on_click()
  {
    for(Extremo b: vExtr)
      b.clicked(mouseX, mouseY); //recogida de coordenadas de ratón
  }
  
  void release()
  {
    for (Extremo b: vExtr)
      b.stopDragging();
  }
  
}
