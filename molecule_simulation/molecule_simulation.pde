int totalBalls = 120;
Ball[] balls = new Ball[totalBalls];
float targetX, targetY;

int width, height;

void setup() {
    width = 1600;
    height = 800;
    size(1600, 800);
    noStroke();
    smooth();
    background(0);
    targetX = width / 2;
    targetY = height / 2;
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        Ball ball = new Ball();
        ball.x = random(width/4);
        ball.y = random(height);
        ball.vx = random(10) - 5;
        ball.vy = random(10) - 5;
        ball.radius = width * .01;
        ball.position=0;
        balls[i] = ball;
    }
};

void draw() {
    background(0);
    fill(color(255, 0, 0));
    stroke( #ffcc00 );
    line( width/2, height/2+width*.04, width/2, height );
    line( width/2, height/2-width*.04, width/2, 0 );
    stroke( color(255, 0, 0) );
    for (int i = 0; i < totalBalls; i++) {
        balls[i].x += balls[i].vx;
        balls[i].y += balls[i].vy;
        checkWallCollision(balls[i]);
        balls[i].render();
    }
    int right = 0;
    for (int i = 0; i < totalBalls; i++) {
        for (int j = i + 1; j < totalBalls; j++) {
            float dx = balls[j].x - balls[i].x;
            float dy = balls[j].y - balls[i].y;
            float dist = sqrt(dx * dx + dy * dy);
            if (dist < (balls[j].radius + balls[i].radius)) {
                // balls have contact so push back...
                float normalX = dx / dist;
                float normalY = dy / dist;
                float midpointX = (balls[i].x + balls[j].x) / 2;
                float midpointY = (balls[i].y + balls[j].y) / 2;
                balls[i].x = midpointX - normalX * balls[i].radius;
                balls[i].y = midpointY - normalY * balls[i].radius;
                balls[j].x = midpointX + normalX * balls[j].radius;
                balls[j].y = midpointY + normalY * balls[j].radius;
                float dVector = (balls[i].vx - balls[j].vx) * normalX;
                dVector += (balls[i].vy - balls[j].vy) * normalY;
                float dvx = dVector * normalX;
                float dvy = dVector * normalY;
                balls[i].vx -= dvx;
                balls[i].vy -= dvy;
                balls[j].vx += dvx;
                balls[j].vy += dvy;
            }
        }
        if(balls[i].x>width/2)right++;
    }
    text(right,width/2+20,height/2);
    text(totalBalls-right,width/2-20,height/2);
};


void checkWallCollision(Ball ball) {
  if(ball.position==0){
    if (ball.x < ball.radius) {
        ball.x = ball.radius;
        ball.vx *= -1;
    }
    if (ball.x > width/2 - (ball.radius)){
        if(ball.y<height/2+width*.03 && ball.y>height/2-width*.03){
          ball.position = 1;
        }else if(ball.vx>0){
          ball.x = width/2 - (ball.radius);
          ball.vx *= -1;
        }
    }
    if (ball.y < ball.radius) {
        ball.y = ball.radius;
        ball.vy *= -1;
    }
    if (ball.y > height - (ball.radius)) {
        ball.y = height - (ball.radius);
        ball.vy *= -1;
    }
  }else{
    if (ball.x > - ball.radius + width) {
        ball.x = - ball.radius + width;
        ball.vx *= -1;
    }
    if (ball.x < width/2 + (ball.radius)){
        if(ball.y<height/2+width*.03 && ball.y>height/2-width*.03){
          ball.position = 0;
        }else if(ball.vx<0){
          ball.x = width/2 + (ball.radius);
          ball.vx *= -1;
        }
    }
    if (ball.y < ball.radius) {
        ball.y = ball.radius;
        ball.vy *= -1;
    }
    if (ball.y > height - (ball.radius)) {
        ball.y = height - (ball.radius);
        ball.vy *= -1;
    }
  }
}

class Ball {
  float x = 0;
  float y = 0;
  float vx = 0;
  float vy = 0;
  float gravityX = 0;
  float gravityY = 0;
  float radius = 5.0;
  int position=0;

  void render() {
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
  }
}