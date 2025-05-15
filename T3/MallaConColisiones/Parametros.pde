
enum WaveType
{
   Simple,
   Radial,
   Gerstner
}

// Display and output parameters:

final boolean FULL_SCREEN = false;
final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
int DISPLAY_SIZE_X = 1000;                            // Display width (pixels)
int DISPLAY_SIZE_Y = 1000;                            // Display height (pixels)
final int [] BACKGROUND_COLOR = {150, 210, 240};      // Background color (RGB)
final int [] TEXT_COLOR = {0, 0, 0};                  // Text color (RGB)

final float FOV = 60;                          
final float NEAR = 0.01;                          
final float FAR = 5000.0;    
final float CAMERA_DIST = 200.0;


// Simulation values:
final boolean REAL_TIME = true;
final float TIME_ACCEL = 0.01;     // To simulate faster (or slower) than real-time
final float TS = 0.01;           // Initial simulation time step (s)
final float G = 4.2;

//SUELO
final float tamSuelo = 200;
final float nCubosSuelo = 10;
final float alturaSuelo = 30;
final color CSuelo = color(80,80,80); //color del suelo
final float KES = 0.5;

//Malla
final int NC = 11;  // número de nodos por vertice de la malla
final float MC = 0.5; // masa de los nodos de la malla
final float SC = 50; // tamaño de la malla
final float HC = -20; // altura inicial a la que se sitúa la malla

//PARTICULA
final color CNodo = color(255,0,255); // color del nodo
final float R = 0.5; // radio del nodo

//MUELLE
final float KE = 10; //Rango de constante elástica de los muelles del cubo
final float KA = 0.1; // Rango de constante de amortiguamiento lineal de los muelles del cubo
final float CR = 0.001; // Constante de pérdida de energía por cada colisión
final color CMuelle = color(255,255,0); // color del muelle

//Bola
final float RB = 5;
final float KD = 0.1;
final color cPart = color(255,0,0);
