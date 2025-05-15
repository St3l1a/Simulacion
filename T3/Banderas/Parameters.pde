

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


//Variables
final float TS = 0.001;          // Paso de simulación
final float mass = 0.5;         // Más masa = más inercia = más estabilidad
final float k = 0.8;              // Constante de muelle más baja
final float am = 0.8;  
final PVector NMUELLES = new PVector(3,3); //Nº de muelles
final PVector Lcuerda = new PVector(200,100);  //Longitud total bandera
final float R = 3; // Radio particula
final PVector dirViento = new PVector(1,0);
final float mViento = 1;
final float KA = 0.2;
