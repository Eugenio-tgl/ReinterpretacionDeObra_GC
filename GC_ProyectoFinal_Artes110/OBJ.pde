

class Modelos{
  PShape molino, caballo, caminadora, pla1, pla2, pla3, vestido, sirena, puerco;//Todas los objetos empleados
  int a;
  boolean r;
  
  float delta, delta2;
  float dx, dx2;
  
  float i,p;
  
  boolean[] comand = new boolean[8];//Este arreglo evita el llamado de un comando hasta que termine
  boolean[] menor = new boolean[8];//Cada comando tiene una variable que determina su tiempo (se escogieron ocho en caso de querer agregar más)
  float[] giros = new float[8];
  boolean puercoM;
  
  Modelos(){
    
    molino = loadShape("molino.obj");
    caballo = loadShape("caballo.obj");
    caminadora = loadShape("caminadora.obj");
    pla1 = loadShape("plataforma1.obj");
    pla2 = loadShape("plataforma2.obj");
    pla3 = loadShape("plataforma3.obj");
    vestido = loadShape("vestido.obj");
    sirena = loadShape("p7.obj");
    puerco = loadShape("p6.obj");
    
    a = 0;
    r = true;
    i = 0;
    p = .1;
    puercoM = false;
    
    for(int i = 0; i<8; i++)
      comand[i] = true;
      
    for(int i = 0; i<8; i++)
      menor[i] = true;
      
    for(int i = 0; i<8; i++)
      giros[i] = 0;
  }
  
  void Dibujar(){
         
      pushMatrix();//Las plataformas suben y bajan en sentidos contrarios dependiendo del grupo en el que esten
        translate(0,cos(i),0);
        Molino();
        Plat1();
        Sirena();
      popMatrix();
      
      pushMatrix();
        translate(0,-cos(i),0);
        Plat3();
        Plat2();
        Caballo();
        Caminadora();
        Vestido();
        if(puercoM)
          Puerco();
      
      popMatrix();
      
      Cielo();
      Comandos();
      
      i+= .1;
  }
  
  void Molino(){
    
    pushMatrix();
      if(comand[1])
        translate(158, -24, -50);
      if(!comand[1])
        GiraMolino();
      rotateZ(90);
      scale(15);
      rotateY(radians(90));
      rotateY(cos(i)*.1);
      shape(molino);
    popMatrix();
  
  }
  
  void Plat1(){
    pushMatrix();
      translate(105, -53, 83);
      rotateX(radians(82));
      rotateY(radians(195));
      if(comand[3])
        rotateZ(radians(-238));
      if(!comand[3])
        GiraPlat1_1();
      scale(-15);
      shape(pla1);
    popMatrix();
    
    pushMatrix();
      translate(-70, -52, -17);
      rotateX(radians(82));
      rotateY(radians(195));
      if(comand[4])
        rotateZ(radians(-238));
      if(!comand[4])
        GiraPlat1_2();
      scale(-15);
      shape(pla1);
    popMatrix();
    
    pushMatrix();
      translate(-14,-83,-14);
      rotateX(radians(92));
      rotateY(radians(5));
      if(comand[5])
        rotateZ(radians(99));
      if(!comand[5])
        GiraPlat1_3();
      scale(15);
      shape(pla1);
    popMatrix();
    
    pushMatrix();
      translate(47, -68, -143);
      rotateX(radians(-124));
      rotateY(radians(-239));
      if(comand[6])
        rotateZ(radians(136));
      if(!comand[6])
        GiraPlat1_4();
      scale(15);
      shape(pla1);
    popMatrix();
  }
  
  void Plat2(){
    pushMatrix();
      translate(74, -1, 111);
      rotateX(radians(-88));
      if(comand[7])
        rotateY(radians(1));
      if(!comand[7])
        GiraPlat2();
      rotateZ(radians(-69));
      scale(-15);
      shape(pla2);
    popMatrix();
  }
  
  void Plat3(){
    pushMatrix();
      translate(71, 14, -75);
      rotateX(radians(82));
      rotateY(radians(-200));
      rotateZ(radians(100));
      scale(-15);
      shape(pla3);
    popMatrix();
  }
  
  void Caballo(){
    pushMatrix();
      translate(104, 11, -28);
      rotateX(radians(-68));
      rotateY(radians(36));
      rotateZ(radians(265));
      rotateY(cos(i)*-.1);
      scale(-15);
      shape(caballo);
    popMatrix();
  }
  
  void Caminadora(){
    pushMatrix();
      translate(113, 13, -59);
      rotateX(radians(86));
      rotateY(radians(1));
      if(comand[2])
        rotateZ(radians(-377));
      if(!comand[2])
        GiraCaminadora();
      scale(10);
      shape(caminadora);
    popMatrix();
  }
  
  void Vestido(){
    pushMatrix();
      translate(125, 10, -96);
      rotateX(radians(-87));
      rotateY(radians(-10));
      rotateZ(radians(265));
      scale(-10);
      shape(vestido);
    popMatrix();
  }
  
  void Sirena(){
    pushMatrix();
      translate(163, -42, 20+cos(i)*3);
      rotateX(radians(7));
      rotateY(radians(-48));
      rotateZ(radians(34));
      rotateZ(cos(i)*-.1);
      scale(-10);
      shape(sirena);
    popMatrix();
  }
  
  void Puerco(){
    pushMatrix();
      translate(20, 61, 146);
      rotateX(radians(8));
      rotateY(radians(-120));
      rotateZ(radians(193));
      scale(30);
      shape(puerco);
    popMatrix();
  }
  
  void Cielo(){//Uso de ruido para creación de mar y cielo
    strokeWeight(10);
    
    dx+=0.01;
    delta+= 0.001;
    dx2+=0.04;
    delta2 += 0.02;
    for(int i = 200; i>-40; i-=4){
      for(int j = 370; j>-370; j-=4){
        noStroke();
        stroke(noise(i*0.01+dx,j*0.01,delta)*43,noise(i*0.01+dx,j*0.01,delta)*115, noise(i*0.01+dx,j*0.01,delta)*92);
        strokeWeight(13);
        pushMatrix();
          translate(0,180,0);
          scale(-1);
        point(map(i,0,180,0,70),i,j);
        popMatrix();
      }
    }
    
    for(int i = -450; i<440; i+=4){
      for(int j = -400; j<0; j+=4){
        noStroke();
        stroke(noise(i*0.01+dx2,j*0.01,delta2)*155);
        strokeWeight(13);
        point(-200,j,i);
      }
    } 
  }
  
  void Comandos(){//Control de todos los comandos
    if(keyPressed){
      switch(key){
        
        case 't':
        if(comand[0])
        {
          comand[0]=false;
          trueno = true;
          sonido = true;
          puercoM=true;
        }
        break;
        
        case '1':
        comand[1] = false;
        break;
        
        case '2':
        comand[2] = false;
        break;
        
        case '3':
        comand[3] = false;
        break;
        
        case '4':
        comand[4] = false;
        break;
        
        case '5':
        comand[5] = false;
        break;
        
        case '6':
        comand[6] = false;
        break;
        
        case '7':
        comand[7] = false;
        break;
      }
    } 
  }
  //Todos las plataformas con comandos tienen las variables que determinan su movimiento en estas funciones
  void GiraMolino(){
    translate(158, -24+giros[0], -50+cos(giros[0])*giros[0] +sin(giros[0]));//Movimiento de una curva paramétrica
    
    if(giros[0] > 15)
      menor[0] = false;
      
    if(menor[0])
      giros[0] += .2;
      
    else if(!menor[0])
      giros[0] -= .2;

    if(giros[0]<0)
    {
     comand[1] = true;
     giros[0] = 0;
     menor[0] = true;
    }
  }
  
  void GiraCaminadora(){
    rotateZ(radians(-377+sin(giros[1])*50));
    
    giros[1]+= .1;

    if(giros[1]>3*PI)
    {
     comand[2] = true;
     giros[1] = 0;
     menor[1] = true;
    }
  }
  
  void GiraPlat1_1(){
    rotateZ(radians(-238+sin(giros[2])*20));
    
    giros[2]+= .04;

    if(giros[2]>6*PI)
    {
     comand[3] = true;
     giros[2] = 0;
     menor[2] = true;
    }
  }
  
  void GiraPlat1_2(){
    rotateZ(radians(-238+sin(giros[3])*20));
    
    giros[3]+= .04;

    if(giros[3]>6*PI)
    {
     comand[4] = true;
     giros[3] = 0;
     menor[3] = true;
    }
  }
  
  void GiraPlat1_3(){
    rotateZ(radians(99+sin(giros[4])*30));
    
    giros[4]+= .05;

    if(giros[4]>6*PI)
    {
     comand[5] = true;
     giros[4] = 0;
     menor[4] = true;
    }
  }
  
  void GiraPlat1_4(){
    rotateZ(radians(136+sin(giros[5])*20));
    
    giros[5]+= .05;

    if(giros[5]>6*PI)
    {
     comand[6] = true;
     giros[5] = 0;
     menor[5] = true;
    }
  }
  
  
  void GiraPlat2(){
    rotateY(radians(1+sin(giros[6])*6));
    
    giros[6]+= .1;

    if(giros[6]>5*PI)
    {
     comand[7] = true;
     giros[6] = 0;
     menor[6] = true;
    }
  }
      
}
