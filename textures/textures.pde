//keyboard interaction
boolean up, down, left, right;

//World manipulation
int bs = 100;

//camera variables
float lx = 2500, ly = height/2 - bs/2, lz = 2500;
PVector direction = new PVector(0, -10);
PVector strafeDir = new PVector(10, 0);
float headAngle = 0;


//color pallette
color black = #000000;
color white = #FFFFFF;

PImage map;

//textures
PImage qblock, dT, dS, dB;




void setup() {
  size(800, 600, P3D);

  //load textures
  qblock = loadImage("qblock.png");
  dT     = loadImage("dirt_top.png");
  dS     = loadImage("dirt_side.jpg");
  dB     = loadImage("dirt_bottom.jpg");
  textureMode(NORMAL);

  //load map
  map         = loadImage("map.png");
}

void draw() {
  background(255);

  camera(lx,ly,lz,   direction.x+lx, ly+0, direction.y+lz,   0, 1, 0); 
  direction.rotate(headAngle);
  headAngle = -(pmouseX - mouseX) * 0.01;
  //headAngle = headAngle + 0.01;

  strafeDir = direction.copy();
  strafeDir.rotate(PI/2);

  if (up) {   
    lx = lx + direction.x;
    lz = lz + direction.y;
  }
  if (down) {
    lz = lz - 10;
  }
  if (left) {
    lx = lx - strafeDir.x;
    lz = lz - strafeDir.y;
  }
  if (right) { 
    lx = lx + strafeDir.x;
    lz = lz + strafeDir.y;
  }
  
  //direction.rotate(-(pmouseX - mouseX) * 0.01);

  drawMap();
  drawFloor();  

}

void drawFloor() {
  int x = 0;
  int y = 0 + bs/2;
  stroke(100);
  strokeWeight(1);
  while (x < map.width*bs) {
    line(x, y, 0, x, y, map.height*bs);
    x = x + bs;
  }

  int z = 0;
  while (z < map.height*bs) {
    line(0, y, z, map.width*bs, y, z);
    z = z + bs;
  }

  noStroke();
}



void drawMap() {
  int mapX = 0, mapY = 0;
  int worldX = 0, worldZ = 0;

  while ( mapY < map.height ) {
    //read in a pixel
    color pixel = map.get(mapX, mapY);

    worldX = mapX * bs;
    worldZ = mapY * bs;

    if (pixel == black) {
      texturedBox(dT, dS, dB, worldX, 0, worldZ, bs/2);
    }


    mapX++;
    if (mapX > map.width) {
      mapX = 0; //go back to the start of the row
      mapY++;   //go down to the next row
    }
  }
}

void texturedBox(PImage top, PImage side, PImage bottom, float x, float y, float z, float size) {
  pushMatrix();
  translate(x, y, z);
  scale(size);

  //rotateX(rotx);
  //rotateY(roty);

  beginShape(QUADS);
  noStroke();
  texture(side);

  // +Z Front Face
  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z Back Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // +X Side Face
  vertex(1, -1, 1, 0, 0);
  vertex(1, -1, -1, 1, 0);
  vertex(1, 1, -1, 1, 1);
  vertex(1, 1, 1, 0, 1);

  // -X Side Face
  vertex(-1, -1, 1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(bottom);

  // +Y Bottom Face
  vertex(-1, 1, -1, 0, 0);
  vertex( 1, 1, -1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  endShape();

  beginShape();
  texture(top);

  // -Y Top Face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  endShape();

  popMatrix();
}

void keyPressed() {
  if (keyCode == UP)    up = true;
  if (keyCode == DOWN)  down = true;
  if (keyCode == LEFT)  left = true;
  if (keyCode == RIGHT) right = true;
}

void keyReleased() {
  if (keyCode == UP)    up = false;
  if (keyCode == DOWN)  down = false;
  if (keyCode == LEFT)  left = false;
  if (keyCode == RIGHT) right = false;
}

void mouseDragged() {
  
  
//  rotx = rotx + (pmouseY - mouseY) * 0.01;
//  roty = roty - (pmouseX - mouseX) * 0.01;
}
