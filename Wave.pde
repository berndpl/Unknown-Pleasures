// A simple Particle class
class Wave {
  
  int pos;
  int speed;
  float[] y = new float [64];
  
  Wave(float [] val) {
    println("instantiated!");
    speed = 10;
    pos = 400;
//    y = val;
    arrayCopy(val,y);
    //y[30]=30;
  }

  void display(){
    pos = pos - speed;
    noFill(); 
    beginShape();
    for (int i = 0; i < y.length; i++){
    curveVertex((i*4), pos-y[i]);
    }
    endShape();
  }
  

}
