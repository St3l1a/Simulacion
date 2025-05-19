// Definitions:

enum CollisionDataType
{
   NONE,
   GRID,
   HASH
}

// Display and output parameters:

final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 800;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 800;                      // Display height (pixels)
final int [] BACKGROUND_COLOR = {200, 210, 240};      // Background color (RGB)
final int [] TEXT_COLOR = {0, 0, 0};                  // Text color (RGB)
final String FILE_NAME = "p3data.csv";                // File to write the simulation variables


// Parameters of the problem:

final float TS = 0.05;     // Initial simulation time step (s)
final float M = 0.1;       // Particles' mass (kg)
final int N = 100;           // Nº bolas
final float R = 10;       // Radio (m)
final float KD = 0.0001;   // Constante de proporcionalidad del rozamiento
final float CR1 = 0.5;     // Constante de pérdida de energía por cada colisión de cada bola-banda [0,1]
final float CR2 = 0.5;     // Constante de pérdida de energía por cada colisión de cada bola-bola [0,1]
final float KA = 0.2;   // Constante de atracción
final color C = color(255);
// Constants of the problem:

final color PARTICLES_COLOR = color(120, 150, 200);
final int SC_GRID = 50;             // Cell size (grid) (m)
final int SC_HASH = 50;             // Cell size (hash) (m)
final int NC_HASH = 1000;           // Number of cells (hash)
final PVector esquinaSupIzq = new PVector(200,300);
final PVector esquinaInfDer = new PVector(650, 700);
//
//
//
