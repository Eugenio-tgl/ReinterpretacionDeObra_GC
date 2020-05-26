//Código por Eugenio y Gustavo Torres García Luna
import processing.sound.*;

Modelos Isla;

PImage img1;
int x = 0, y = 0, z = 0;

float Camera, luz = 0;
boolean trueno = false, sonido = false;
int rayos = 1;

SoundFile impactrueno, cancion;

void setup() {
  size(1000, 700, P3D);

  Isla = new Modelos();
  impactrueno = new SoundFile(this, "trueno1.mp3");
  cancion = new SoundFile(this, "cancion.mp3");

  cancion.loop();
}


void draw() {

  background(0);
  Luces();

  camera(300, map(mouseY, 0, height, -15, 15), map(mouseX, 0, width, -15, 15), 0, 0, 0, 0, 1, 0);
  perspective();
  Isla.Dibujar();


  if (keyPressed)
    keyPressed();
}

void Luces() {

  if (trueno)
  {

    if (sonido) {
      impactrueno.play();
      sonido = false;
    }

    switch(rayos) {

    case 1:
      directionalLight(255, 255, 255, 0, 0, -1);
      ambientLight(102, 102, 102);
      if (luz > 10) 
      {
        luz = 0;
        rayos++;
      }
      break;

    case 2:
      directionalLight(126, 126, 126, 0, 0, -1);
      ambientLight(102, 102, 102);
      if (luz > 5) 
      {
        luz = 0;
        rayos++;
      }
      break;

    case 3:
      directionalLight(255, 255, 255, 0, 0, -1);
      ambientLight(102, 102, 102);
      if (luz > 5) 
      {
        luz = 0;
        rayos++;
        
      }
      break;

    case 4:
      directionalLight(126, 126, 126, 0, 0, -1);
      ambientLight(102, 102, 102);
      if (luz > 5) 
      {
        luz = 0;
        rayos++;
      }
      break;

    case 5:
      directionalLight(255, 255, 255, 0, 0, -1);
      ambientLight(102, 102, 102);
      if (luz > 5) 
      {
        trueno = false;
        luz = 0;
        rayos=1;
        Isla.comand[0]=true;
        Isla.puercoM=false; 
      }
      break;
    } 
    luz++;
  } else if (!trueno)
  {
    directionalLight(126, 126, 126, 0, 0, -1);
    ambientLight(102, 102, 102);
  }
}
