void setup() 
{
  size(screenWidth, screenHeight);
  noStroke();
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);
  frameRate( 15 );

}

var x,y;

void draw() 
{   
  if(pmouseX != mouseX)
  	x = mouseX;
  if(pmouseY != mouseY)	
  	y = mouseY;	
  background(51); 
  fill(255, 80);
  rect(x, height/2, y/2+10, y/2+10);
  fill(255, 80);
  rect(width-x, height/2, ((height-y)/2)+10, ((height-y)/2)+10);
  if(socket)
  	socket.emit('mousePos',{x:x,y:y});
}

socket.on('mousePos',function(data){
	x = data.x;
	y = data.y; 	
})



