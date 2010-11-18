import ddf.minim.analysis.*;
import ddf.minim.*;
import fullscreen.*;

Minim minim;
AudioInput in;
FFT fft;
FullScreen fs;

int w;
float[] v = new float [64];
ArrayList waves;
float gain = 4;

void setup (){
  size(640,480);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(60,7);
  //line setup
  stroke(255); //white
  w = width/fft.avgSize();
  strokeWeight(1);
  waves = new ArrayList();
  frameRate(10);
  fs = new FullScreen(this);
  fs.setShortcutsEnabled(true);
  noCursor();
}

void draw(){
   
  background(10);

  fft.forward(in.mix);

  for(int i = 0; i < fft.avgSize();i++){ //iterating through all ands in spectrum
    v[i] = fft.getAvg(i) * gain;
  }

  waves.add(new Wave(v));

  for (int i = 0; i < waves.size(); i++){
    Wave selectedwave = (Wave) waves.get(i);
    selectedwave.display();
    println(i);
  }

  if (waves.size() > 30) {
  waves.remove(0);
  }



if ( keyPressed) {
  if (key == 'k')  gain++;
  if (key == 'j')  gain--;
}



}
 



