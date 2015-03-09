import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

//The two rings and other parts
ArrayList <Particle> maleRing;
ArrayList <Particle> femaleRing;
Chain femaleNef; 
Chain femaleTransR; //transept on right
Chain femaleTransL; // transept on left
Chain maleNef;
float maleTailAngle; //angle of the male tail 
Chain maleTransL; //transept on left
Chain maleTransD; //transept going down

//radii and centers of rings, for easy calculations
float maleCentreX; //centres of the rings
float femaleCentreX;
int maleCentreY; 
int femaleCentreY;
int maleRad; //radii
int femaleRad;

//other ring dimensions
float numParts; //number of particles in each RING!!
float partRad; //radius of each particle
float numNef; //number of particles in the Nef of the female;
float springLen; //for the rings
float springStr;

//Data
Table myTable;
ArrayList <Integer> dataList; //arrayList to store all the data, converted to mapped values


//the fill colour of the particles
int fillColour=30;
float alphaVal=0.2;

void setup()
{
  background(255);
  size(1280, 720);

  //deal with the data
  myTable = loadTable("gayData.csv");
  dataList=new ArrayList<Integer>();
  for (int i = 0; i < myTable.getRowCount (); i++) //add each element of table to the list
  {
    TableRow r = myTable.getRow(i);
    dataList.add((int)(map(r.getInt(0), 722, 8977, 0, 500)));
  }


  //initialise the physics
  physics=new VerletPhysics2D();
  // Set the world's bounding box
  physics.setWorldBounds(new Rect(0, 0, width, height));

  //add side forces
  physics.addBehavior(new GravityBehavior(new Vec2D(-10, 0)));
  physics.addBehavior(new GravityBehavior(new Vec2D(10, 0)));
  physics.addBehavior(new GravityBehavior(new Vec2D(0, -10)));
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 10)));

  //Ring dimensions
  femaleCentreX=0.45*width; //the abscissa 
  maleCentreX=0.55*width;
  maleCentreY=height/2; //the ordinate
  femaleCentreY=height/2;
  maleRad=170; //the radii of the rings
  femaleRad=170;
  numParts=3600; //number of particles in the ring
  partRad=3; //radius of each particle

  //Spring constants . Actually, might not even need forces is these are cool.
  springLen=dataList.get(15); /*<<---------------------------------THE IMPORTANT LINE!---------------------------------------------------------*/
  println(dataList.get(3));
  springStr=0.01;   //length 20 and strength 0.0001 is interesting. Also length 20 and str 0.01 needs no forces
  //increaing length speeds up the breakdown: good mapping maybe? [this is for springs attached in a ring]. 15 is a good start point... 5? 1? 800 or 1000 is a good ending?

  /*--------------------MAKE MALE RING--------------------------------*/
  //Each ring is a collection of Particle objects in a ring shape
  maleRing=new ArrayList<Particle>();
  for (int i=0; i<numParts; i++)
  {
    Particle tempP=new Particle(new Vec2D(maleCentreX+maleRad*cos(i*TAU/numParts), maleCentreY+maleRad*sin(i*TAU/numParts)));
    maleRing.add(tempP);
    physics.addParticle(tempP); ///add to the Physics world
  }


  //each particle connected to neighbours with springs
  for (int i=0; i<numParts; i++) 
  {
    if (i!=numParts-1)
    {
      VerletSpring2D s1=new VerletSpring2D(maleRing.get(i), maleRing.get(i+1), springLen, springStr);
      physics.addSpring(s1); ///add to the Physics world
    } else
    {
      VerletSpring2D s2=new VerletSpring2D(maleRing.get(int(numParts-1)), maleRing.get(0), springLen, springStr);
      physics.addSpring(s2); ///add to the Physics world
    }
  }

  //make the male tail
  maleTailAngle=radians(330);
  float maleNefX=maleCentreX+cos(maleTailAngle)*(maleRad);
  float maleNefY=maleCentreY+sin(maleTailAngle)*(maleRad);
  maleNef=new Chain(3*maleRad/4, maleNefX, maleNefY, maleRing, 'd'); //tail extends from angle (360-30) at the top right of the ring
  maleTransL=new Chain(maleRad/3, maleNef.tail.x, maleNef.tail.y, maleRing, 'L');
  maleTransD=new Chain(maleRad/3, maleNef.tail.x, maleNef.tail.y, maleRing, 'v');


  /*-------------------------------------------------------------------*/



  /*--------------------MAKE FEMALE RING------------------------------*/
  //Each ring is a collection of Particle objects in a ring shape
  femaleRing=new ArrayList<Particle>();
  for (int i=0; i<numParts; i++)
  {
    Particle tempP=new Particle(new Vec2D(femaleCentreX+femaleRad*cos(i*TAU/numParts), femaleCentreY+femaleRad*sin(i*TAU/numParts)));
    femaleRing.add(tempP);
    physics.addParticle(tempP); ///add to the Physics world
  }

  //connect ring particles to each other
  for (int i=0; i<numParts; i++) 
  {
    if (i!=numParts-1)
    {
      VerletSpring2D s1=new VerletSpring2D(femaleRing.get(i), femaleRing.get(i+1), springLen, springStr);
      physics.addSpring(s1); ///add to the Physics world
    } else
    {
      VerletSpring2D s2=new VerletSpring2D(femaleRing.get(int(numParts-1)), femaleRing.get(0), springLen, springStr);
      physics.addSpring(s2); ///add to the Physics world
    }
  }

  //make the tail arrays, both nef and transept
  femaleNef=new Chain(femaleRad, femaleRing.get(int(90*numParts/360)).x, femaleRing.get(int(180*numParts/360)).y+femaleRad, femaleRing, 'v'); //head is the particle on the ring located at 270 degrees.
  femaleTransR=new Chain(femaleRad/2, femaleCentreX, femaleCentreY+5*femaleRad/4, femaleRing, 'R');
  femaleTransL=new Chain(femaleRad/2, femaleCentreX, femaleCentreY+5*femaleRad/4, femaleRing, 'L');



  /*numNef=numParts/(2*PI);   //for now, the nef is as long as the radius
   femaleNef=new ArrayList<Particle>();
   femaleNef.add(new Particle(femaleRing.get(int(270*numParts/360)))); //add the particle on the ring to the nef. It's the particle located at 270 degrees. Remember there are 3600 particles.
   for(float j=0; j<numNef; j++)
   {
   Particle tempP= new Particle(new Vec2D(femaleNef.get(0).x,(i*partRad)+femaleNef.get(0).y));
   femaleNef.add(tempP);
   physics.addParticle(tempP);
   }
   */



  //println(femaleNef.size());

  /*-------------------------------------------------------------------*/
}

////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
void draw()
{
  background(255);

  for (Particle p : maleRing)
    p.display();

  for (Particle p : femaleRing)
    p.display();

  femaleNef.display();
  femaleTransR.display();
  femaleTransL.display();

  maleNef.display();
  maleTransL.display();
  maleTransD.display();
}
////////////////////////////////////////////////////////
///////////////////////////////////////////////////////

void mouseClicked()
{
  //alphaVal+=1;

  //update physics
  for (int i=0; i<10; i++)
    physics.update();
}

void keyPressed()
{
  save("1995.jpeg");
  
  /* year, table correspondance
  0--1980
  5--1985
  10--1990
  15--1995
  20-2000
  25--2005
  30--2010
  34--2014*/
}


// OLD STUFF

/* //alternate Spring model. Each particle connected to the centre by a Spring
 
 //for Srping model 2
 Particle maleAnchor;
 Particle femaleAnchor;
 
 
 maleAnchor= new Particle(new Vec2D(maleCentreX, maleCentreY));
 physics.addParticle(maleAnchor);
 maleAnchor.lock();
 for (int i=0; i<numParts; i++) 
 {
 VerletSpring2D s=new VerletSpring2D(maleAnchor, maleRing.get(i), SpringLen, SpringStr);
 physics.addSpring(s); ///add to the Physics world
 }*/
