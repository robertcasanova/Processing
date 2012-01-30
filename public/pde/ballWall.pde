/* Pong game with Processing */
Point p;
Ball b,b1,b2;
Obstacles obs;


void setup() {
   size(800,600);
   frameRate(60);
   fill(#000000);
   noStroke();

   b = new Ball(new Point(100,100), 20, 10);
   b1 = new Ball(new Point(100,100), 20, 10);
   b2 = new Ball(new Point(100,100), 20, 10);

   
   obs = new Obstacles();
   obs.add(new Wall(new Point(0,0), new Point(800,20)));
   obs.add(new Wall(new Point(0,0), new Point(20,600)));
   obs.add(new Wall(new Point(0,580), new Point(800,600)));
   obs.add(new Wall(new Point(780,0), new Point(800,600)));

}
void draw() {
  background(#FFFFFF);
  obs.draw();    
  b.move();b1.move();b2.move();
  b.draw();b1.draw();b2.draw();
}

/* have fun, delete */
Point p1,p2;
void mousePressed() {
  p1 = new Point(mouseX,mouseY);
}
void mouseDragged() {
  int[] coords = p1.getCoords();
  rect(coords[0],coords[1],(mouseX-coords[0]),(mouseY-coords[1]),10,10,10,10);
}
void mouseReleased() {
  p2 = new Point(mouseX,mouseY);
  obs.add(new Wall(p1,p2));
  obs.draw();
}
/* have fun, delete */


class Point {
  int x,y;
  Point (int x, int y) {
    this.x = x;
    this.y = y;
  }
  int[] getCoords() {
       int[] coords = {this.x,this.y};
       return coords; 
  }
  Point add( Point vector) {
     int[] coords = vector.getCoords();
     return new Point(this.x+coords[0],this.y+coords[1]) ; 
  }
  boolean cross(Point startPoint,Point endPoint) {
    boolean crossX=false,crossY=false;
    int[]coords_1 = startPoint.getCoords();
    int[]coords_2 = endPoint.getCoords();
    if(this.x > coords_1[0] && this.x < coords_2[0]) {
      crossX = true;
    }    
    if(this.y > coords_1[1] && this.y < coords_2[1]) {
      crossY = true;
    }
    return (crossX && crossY);
  }
   
}

class Ball {
 Point position;
 int r,speed;
 float direction = random(2*PI); // da sistemare
 boolean collision = false;

 Ball(Point startPosition,int r, int speed) {
   this.r=r;
   this.speed=speed;
   this.position = startPosition;
 } 
 void reset() {
   //this.position = new Point() 
 } 
 void draw() {
    //disegna sfera al punto position con raggio r
    int[] coords = this.position.getCoords();
    ellipse(coords[0],coords[1],this.r,r);
 }
 void move() {
   //determina nuova position
   int moveX =  round(sin(this.direction)*speed);
   int moveY =  round(cos(this.direction)*speed);
   

   Point newPosition = this.position.add(new Point(moveX,moveY));
   //checkCollision(newPosition)
   //if(obstacles.checkCollision())
   if(obs.checkCollision(newPosition)) {
     //if(scena.outOfBoundaries(newPosition))
     if (false) { //outOdBoundaries
        //end of game 
     } else {
       if(!this.collision) {
         this.direction = PI - direction;
       } else { 
         this.direction = PI + direction; 
       }
       this.collision = true;
       move();
     }
      
   } else {
     this.collision = false;
     this.position = newPosition;
   }
 }
  
}

class Obstacles {
  ArrayList obs;
  Obstacles(){
   obs = new ArrayList();
  }
  void add(Obstacle ob) {
     obs.add(ob);
  }
  Obstacle get(int index) {
    return (Obstacle)obs.get(index); 
  } 
  void remove(int index) {
    obs.remove(index);  
  }
  boolean checkCollision(Point p){
    for(int i = 0; i< obs.size(); i++) {
      if(((Obstacle)obs.get(i)).checkCollision(p)){
        return true;
      }
    }
    return false;
  }
  void draw() {
    for(int i = 0; i< obs.size(); i++) {
      ((Obstacle)obs.get(i)).draw();
    }
  }
}

interface Obstacle{
  boolean checkCollision(Point newPosition);
  void draw();
}

class Wall implements Obstacle {
  Point fromPoint,toPoint;
  Wall(Point fromPoint, Point toPoint) {
    this.fromPoint = fromPoint;
    this.toPoint = toPoint;
  }
  void draw() {
    int[] coords_1 = this.fromPoint.getCoords();
    int[] coords_2 = this.toPoint.getCoords();
    rect(coords_1[0],coords_1[1],(coords_2[0]-coords_1[0]),(coords_2[1]-coords_1[1]),10,10,10,10);
  }
  boolean checkCollision(Point newPosition){
    return newPosition.cross(this.fromPoint,this.toPoint);
  }
}

