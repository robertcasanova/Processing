int num = 60;
int x,y;


float mx[] = new float[num];

float my[] = new float[num];


void setup() 
{
  size(window.innerWidth, window.innerHeight);
  smooth();

  noStroke();

  fill(255, 153); 
  frameRate( 15 );

}


void draw() 
{   
  if(pmouseX != mouseX)
  	x = mouseX;
  if(pmouseY != mouseY)	
  	y = mouseY;	
  background(51); 

  

  // Reads throught the entire array

  // and shifts the values to the left

  for(int i=1; i<num; i++) {

    mx[i-1] = mx[i];

    my[i-1] = my[i];

  } 

  // Add the new values to the end of the array

  mx[num-1] = x;

  my[num-1] = y;

  

  for(int i=0; i<num; i++) {

    ellipse(mx[i], my[i], i/2, i/2);

  }
  if(socket)
  	socket.emit('mousePos',{x:x,y:y});
}

socket.on('mousePos',function(data){
	x = data.x;
	y = data.y; 	
})



