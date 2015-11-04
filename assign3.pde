/*game 3*/
PImage bg1,bg2,enemy,fighter,hp,treasure,start1,start2,end1,end2;
float Hp=197;
float tSpeed=5;
float hpx;
float fx=550,fy=240;
float tx=random(41,601),ty=random(41,441);
int bgx1=641,bgx2=0;
int spacing=10;
float enemyWidth=61;
float enemyHeight=61;
float ex=0,ey;
float eStartY;
float eMoveX=-5*(spacing+enemyWidth);
float ey1,ey2;
int state;
int stateGame;

final int GAME_START=0;
final int GAME_RUN=1;
final int RUN1=0;
final int RUN2=1;
final int RUN3=2;

boolean upPressed,downPressed,rightPressed,leftPressed=false;

void setup()
{
  size(640,480);
  hpx=Hp;
  state=GAME_START;
  stateGame=RUN1;
  ey=random(0,height-enemyHeight);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  treasure=loadImage("img/treasure.png");
  fighter=loadImage("img/fighter.png");
  enemy=loadImage("img/enemy.png");
  hp=loadImage("img/hp.png");  
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
}
void draw()
{
  switch(state)
  {
    //------------------------------
    case GAME_START:
      {
          image(start2,0,0);  
          if(mouseX>207&&mouseX<454) //x:207-454,y:378-413
          {
              if(mouseY>378&&mouseY<413)
              {
                  image(start1,0,0);
                  if(mousePressed)
                    state=GAME_RUN;
              }
          }
          break;
      }
    //------------------------------
    case GAME_RUN:
      {
         //bg
        image(bg1,bgx1-640,0);
        bgx1+=3;
        bgx1%=1280;
        image(bg2,bgx2-640,0);
        bgx2+=3;
        bgx2%=1280;
        //treasure
        image(treasure,tx,ty);
        if((fx-tx)<41&&(tx-fx)<51)
        {
          if((fy-ty)<41&&(ty-fy)<51)
          {
            tx=random(41,601);
            ty=random(41,441);
          }
        }
        //fighter
        if(upPressed)
          fy-=tSpeed;
        if(downPressed)
          fy+=tSpeed;
        if(rightPressed)
          fx+=tSpeed;
        if(leftPressed)
          fx-=tSpeed;
        
        if(fx<0)
          fx=0;
        if(fx>590)
          fx=590;
        if(fy<0)
          fy=0;
        if(fy>429)
          fy=429;
          
        image(fighter,fx,fy);
        //enemy
        switch(stateGame)
        {
          case RUN1:
            for(int i=0;i<5;i++)
            {
              ex=eMoveX+(enemyWidth+spacing)*i;
              image(enemy,ex,ey);
            }
            eMoveX+=5;
            if(eMoveX>width)
            {
              eMoveX=-5*(spacing+enemyWidth);
              eStartY=random(140,height-enemyHeight); 
              stateGame=RUN2;
            }
            break;
           case RUN2:
             for(int i=0;i<5;i++)
            {
              ex=eMoveX+(enemyWidth+spacing)*i;
              ey=eStartY-30*i;
              image(enemy,ex,ey);
            }
            eMoveX+=5;
            if(eMoveX>width)
            {
              eMoveX=-5*enemyWidth;
              eStartY=random(0,175);
              stateGame=RUN3;
            }
            break;
            case RUN3:
                for(int i=0;i<5;i++)
                {
                  ex=eMoveX+enemyWidth*i;
                  if(i<=2)
                  {
                    ey1=eStartY+(2+i)*enemyHeight;
                    ey2=eStartY+(2-i)*enemyHeight;
                  }
                  if(i>=3&&i<5)
                  {
                    ey1=eStartY+(6-i)*enemyHeight;
                    ey2=eStartY+(i-2)*enemyHeight;
                  }
                  image(enemy,ex,ey1);
                  image(enemy,ex,ey2);
                }
                eMoveX+=5;
               if(eMoveX>width)
               {
                 eMoveX=-5*(spacing+enemyWidth);
                 ey=random(0,height-enemyHeight); 
                 stateGame=RUN1;
               }
               break;
        }
        //rect
        fill(255,0,0);
        rect(41,23,hpx,20);
        //hp
        image(hp,30,20);
        break;
      }
  } 
}


void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
        upPressed=true;
        break;
      case DOWN:
        downPressed=true;
        break;
      case RIGHT:
        rightPressed=true;
        break;
      case LEFT:
        leftPressed=true;
         break;
    }
  }
}
void keyReleased()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
      case LEFT:
        leftPressed=false;
         break;
    }
  }
}
