ArrayList<Projectile> projectiles = new ArrayList<Projectile>(); // Lista de proyectiles
float cy, cx;

void setup() {
  size(700, 500);
  cy = height;
  cx = width / 2; 
}

void draw() {
  background(255);
  
  float arrowLength = 100; // Longitud fija de la flecha
  
  // Calcula la dirección hacia el mouse
  float angle = atan2(mouseY - cy, mouseX - cx);
  
  // Calcula el punto final manteniendo la longitud constante
  float x2 = cx + arrowLength * cos(angle);
  float y2 = cy + arrowLength * sin(angle);
  fill(0,0,0);
  stroke(0,0,0); 
  drawArrow(cx, cy, x2, y2);
  
  // Dibujar y actualizar los proyectiles
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    p.update();
    p.display();
    
    // Elimina los proyectiles que salen de la pantalla
    if (p.isOffScreen()) {
      projectiles.remove(i);
    }
  }
}

void drawArrow(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  
  float arrowSize = 15;
  float angle = atan2(y2 - y1, x2 - x1);
  float x3 = x2 - arrowSize * cos(angle - PI / 6);
  float y3 = y2 - arrowSize * sin(angle - PI / 6);
  float x4 = x2 - arrowSize * cos(angle + PI / 6);
  float y4 = y2 - arrowSize * sin(angle + PI / 6);
  
  triangle(x2, y2, x3, y3, x4, y4);
}

void mousePressed() {
  float angle = atan2(mouseY - cy, mouseX - cx);
  projectiles.add(new Projectile(cx, cy, angle));
}

class Projectile {
  float x, y, speed, angle;
  
  Projectile(float startX, float startY, float angle) {
    this.x = startX;
    this.y = startY;
    this.angle = angle;
    this.speed = 3;
  }
  
  void update() {
    x += speed * cos(angle);
    y += speed * sin(angle);
  }
  
  void display() {
    fill(0,0,255);
    stroke(0,0,255); 
    ellipse(x, y, 10, 10);
  }
  
  boolean isOffScreen() {
    return x < 0 || x > width || y < 0 || y > height;
  }
}
