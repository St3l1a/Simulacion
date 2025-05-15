enum FlagType
{
   Structured,
   Shear,
   Bend
}


// Display and output parameters:
final int DRAW_FREQ = 100;                            // Draw frequency (Hz or Frame-per-second)
final int DISPLAY_SIZE_X = 1200;                      // Display width (pixels)
final int DISPLAY_SIZE_Y = 800;                      // Display height (pixels)
final int [] BACKGROUND_COLOR = {200, 210, 240};      // Background color (RGB)
final int [] TEXT_COLOR = {0, 0, 0};                  // Text color (RGB)
final String FILE_NAME = "p3data.csv";                // File to write the simulation variables

//Constantes
final PVector gravity = new PVector(0, 4.8);
final PVector b1 = new PVector (50,150); //Bandera 1
final PVector b2 = new PVector (450,150); //Bandera 2
final PVector b3 = new PVector (850,150); //Bandera 3

//Variables
final float TS = 0.001;          // Paso de simulación
final float mass = 0.5;         // Masa particulas
final float k = 0.5;              // Constante elastica
final float am = 0.3;  
final PVector NMUELLES = new PVector(4,4); //Nº de muelles
final PVector Lcuerda = new PVector(200,100);  //Longitud total bandera
final float R = 3; // Radio particula
final PVector dirViento = new PVector(1,0);
final float mViento = 1;
final float KA = 0.2;
