class Novel {
  String word;
  float tSize;
  float tFill;
  PVector pos = new PVector();
  PVector tpos = new PVector();

  void update() { 
    pos.lerp(tpos, 0.1);
  }

  void render() {
    pushMatrix();
    {
      translate(pos.x, pos.y, pos.z);
      //text(firstName+" " + lastName, 0, 0);
      fill(255,tFill);
      textSize(tSize);
      text(word, 0,0);
    }
    popMatrix();
  }
}

