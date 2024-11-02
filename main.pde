float time = 0;
PVector position = new PVector();
FloatList posX = new FloatList();
FloatList posY = new FloatList();
float scale;
int num = 5;
String text;
boolean re = true, im = true;

void setup() {
  size(1000, 800);
}

void draw() {
  background(50);

  float x = 0;
  float y = 0;
  float sum_radius = (2/ PI);

  for (int i = 1; i < num; i++) sum_radius += (2/(i * PI));
  scale = height/(3*sum_radius);

  position.x = scale*sum_radius;
  position.y = height/2;
  sum_radius = scale;
  pushMatrix();
  translate(position.x, position.y);

  stroke(0);
  line(0, -position.y, 0, height-position.y);
  line(-position.x, 0, width-position.x, 0);
  for (int i = 1; i < num; i++) {
    float prevx = x;
    float prevy = y;
    float radius = (2/(i * PI)) * scale;
    float theta = i*time;
    sum_radius += radius;
    stroke(255, 100);
    noFill();
    circle(prevx, prevy, 2*radius);

    x += radius * cos(theta);
    y += radius * sin(theta);

    //fill(255);
    stroke(255, 255);
    strokeWeight(2);
    line(prevx, prevy, x, y);
    //circle(x, y, 8);
  }

  posX.reverse();
  posY.reverse();
  if (posX.size() > width - position.x) {
    posX.remove(0);
    posY.remove(0);
  }
  posX.append(x);
  posY.append(y);
  posX.reverse();
  posY.reverse();

  pushMatrix();
  translate(position.x, 0);

  beginShape();
  stroke(100, 100, 255);
  strokeWeight(1);
  noFill();
  if (re)
    for (int i = 0; i < posX.size(); i++) vertex(i, posX.get(i));
  endShape();

  beginShape();
  stroke(100, 255, 100);
  strokeWeight(1);
  noFill();
  if (im)
    for (int i = 0; i < posY.size(); i++) vertex(i, posY.get(i));
  endShape();
  popMatrix();

  beginShape();
  stroke(255, 255, 100);
  for (int i = 0; i < posX.size(); i++) {
    curveVertex(posX.get(i), posY.get(i));
  }
  endShape();

  popMatrix();
  time -= 0.05;
  if (time < -TWO_PI) time = time%TWO_PI;

  text = "n: " + (num-1);
  textSize(20);
  text(text, 20, 20);
}

void keyPressed() {
  if (keyCode == UP && num < 31) {
    num++;
    posX.clear();
    posY.clear();
  }
  if (keyCode == DOWN && num > 2) {
    num--;
    posX.clear();
    posY.clear();
  }
  if (keyCode == RIGHT) re = !re;
  if (keyCode == LEFT) im = !im;
}
