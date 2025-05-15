public class Ground {
  float x, y, z;   // Posición del suelo
  float _width, _height, depth;  // Dimensiones del suelo
  color c;  // Color del suelo
  float grosor;
  
  // Constructor de la clase
  Ground() {
    _width = tamSuelo/nCubosSuelo;
    _height = alturaSuelo;
    depth = _width;
    c = CSuelo;
    grosor = 2;
  }
  
  // Método para dibujar el suelo
  void display() {
    fill(c);
    stroke(0);
    pushMatrix();
    // Centrar el suelo en el origen
    translate(-nCubosSuelo*_width/2 + _width/2, _height, -nCubosSuelo*_width/2 + _width/2);

    
    for (int x = 0; x < nCubosSuelo; x++) {
      for (int z = 0; z < nCubosSuelo; z++) {
        pushMatrix();
        translate(x * _width, 0,z * _width);
        fill(c);
        box(_width, 0, depth); 
        popMatrix();
      }
    }
    popMatrix();
  }
 
}
