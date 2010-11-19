import ddf.minim.analysis.*;
import ddf.minim.*;
import fullscreen.*;
import processing.opengl.*;

Minim minim;
AudioInput in;
FFT fft;
FullScreen fs;

PFont miso; 
PFont helv; 

int w;
float[] v = new float [64];
ArrayList waves;
float gain = 4;
//WAVE SETUP
int speed = 10;
int scalex = 6; //Width of wave
int waveamount = 40;
int marginbottom = 80;

//countdown
int trigger = 0;
int count = 10;
int startTime;
int interval = 1000; // i.e. 1 second
int c; //clock
int cmin;
int csec;
int cmil;
int climit = 10;
boolean countdown = true;

void setup (){
  size(800,600);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(60,7);
  //line setup
  stroke(255); //white
  w = width/fft.avgSize();
  strokeWeight(1);
  waves = new ArrayList();
//  frameRate(10);
  fs = new FullScreen(this);
  fs.setResolution(800, 600);  
  fs.setShortcutsEnabled(true);
  noCursor();
  miso = loadFont("Miso-48.vlw"); 
  helv  = loadFont("Helvetica-48.vlw");  
  textFont(miso, 36); 
  smooth();
}

void draw(){
  c = climit*60*1000 - millis();
  cmin = (c/(60*1000));
  csec = (c/(1000))%60;
  cmil = c%1000;
  println("MIN: "+cmin+" SEC: "+csec+" MIL: "+cmil);

  background(10);
  fft.forward(in.mix);
  
  if ((cmin<0) && (csec<0)){
    countdown = false;
  } else if (countdown == true){
//    text(cmin+":"+csec+":"+cmil, width/2-65, height-(marginbottom-20));
    text("Geräusch "+cmin+":"+csec+":"+cmil+" labor", width/2-150, height-(marginbottom-20));    
  }
  
  for(int i = 0; i < fft.avgSize();i++){ //iterating through all ands in spectrum
    v[i] = fft.getAvg(i) * gain;
  }

  waves.add(new Wave(v));

  for (int i = 0; i < waves.size(); i++){
    Wave selectedwave = (Wave) waves.get(i);
    selectedwave.display();
  }

  if (waves.size() > waveamount) {
  waves.remove(0);
  }



if ( keyPressed) {
  if (key == 'k'){
    gain=gain+0.5;
    text("GAIN "+gain, width/2, height-20);
  }
  if (key == 'j'){
    gain=gain-0.5;
    text("GAIN "+gain, width/2, height-20);    
  }
  if (key == '1'){
    speed = 10;
    text("Speed "+speed, width/2, height-20);    
  }
  if (key == '2'){
    speed = 1;
    text("Speed "+speed, width/2, height-20);    
  }
  if (key == '3'){
    speed = 0;
    text("Speed "+speed, width/2, height-20);    
  }
  if (key == '+'){
    climit++;
    countdown = true;
    //text("Speed "+speed, width/2, height-20);    
  }
  if (key == '-'){
    climit--;
    countdown = true;
    //text("Speed "+speed, width/2, height-20);    
  }  
}


if(count > -1) {
    // check that the set time interval has passed
    if(millis() >= startTime + interval){
      //println(count);
      count --;
      startTime = millis(); //reset timer
    }
  }


}
 



