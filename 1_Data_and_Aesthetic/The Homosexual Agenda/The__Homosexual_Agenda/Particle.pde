// Adapted from "The Nature of Code" by Daniel Shiffman
// http://natureofcode.com

// Initialise the physics world
VerletPhysics2D physics;

class Particle extends VerletParticle2D
{

  Particle(Vec2D loc) 
  {
    super(loc);
  }

  //A display() function for a VerletParticle
  void display() 
  {
    pushStyle();
    fill(fillColour/*, fillColour, fillColour,alphaVal*/);
    noStroke();
    ellipse(x, y, partRad, partRad);
    popStyle();
  }
}

