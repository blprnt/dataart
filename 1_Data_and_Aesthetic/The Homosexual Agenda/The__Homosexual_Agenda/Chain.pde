// adapted from SoftStringPendulum, in Nature of Code by Dan Shiffman
//this class uses global variables from the main method

class Chain 
{

  // String properties
  float totalLength;  // How long
  float numPoints;      // How many points

    // list of particles in the chain
  ArrayList<Particle> particles;

  // an extra reference to the tail and head particles; last and first particles in the arraylist
  Particle tail;
  Particle head;

  // Chain constructor

  Chain()
  {
  }


  Chain(int l, float x, float y, ArrayList<Particle> arr, char c) //length, starting x and starting y, ring to attach to a character (where L is horizontal Left, R is horizontal right, v is vertical, d is diagonal)
  {
    particles = new ArrayList<Particle>();

    totalLength = l;
    numPoints = l/partRad;

    float xpos=x, ypos=y;   

    // Here is the real work, go through and add particles to the chain itself
    for (int i=0; i < numPoints; i++) 
    {
      // Make a new particle as the start
      Particle particle=new Particle(new Vec2D(xpos, ypos));

      //update the position to add the next particle on the chain, depending on vertical, horizontal, diagonal
      if (c=='v') //vertical
      {
        ypos+=partRad-1;
      } else if (c=='R') //for horizontal, adds links to the right
      {
        xpos+=partRad-1;
      } else if (c=='L')
      {
        xpos-=partRad-1;
      } else if (c=='d')
      {
        xpos+=partRad-1;
        ypos+=sin(maleTailAngle)*partRad;
      }


      // Put the particles both in physics and in our own ArrayList
      physics.addParticle(particle);
      particles.add(particle);

      // Connect the particles with a Spring (except for the head)
      if (i != 0)
      {
        /*
        Particle previous = particles.get(i-1);
         VerletSpring2D spring = new VerletSpring2D(particle, previous, springLen, springStr);
         */
        //try: connect to random particles on the corresponding ring
        VerletSpring2D spring = new VerletSpring2D(arr.get(int(random(0, numParts))), particle, springLen*10, springStr/100);
        // Add the spring to the physics world
        physics.addSpring(spring);
      }
    }

    // Store the head reference
    head=particles.get(0);

    // Store reference to the tail
    tail = particles.get(int(numPoints-1));
  }

  // Draw the chain
  void display() 
  {
    for (Particle p : particles) 
    {
      p.display();
    }
  }
}

