// A simple Particle class
class Wave {
  
  int pos;
  float[] y = new float [64];
  int adjustx;
  int adjusty = -20;  
  
  Wave(float [] val) {
//    println("instantiated!");
    pos = height - marginbottom;
    arrayCopy(val,y);
  }

  void display(){
    pos = pos - speed;
    adjustx = (width/2) - ((scalex*y.length)/2);
       
    noFill(); 
    beginShape();
    for (int i = 0; i < y.length; i++){
      
    curveVertex(adjustx+(i*scalex), adjusty+(pos-y[i]));
    }
    endShape();
  }
  

}
