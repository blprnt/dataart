#pragma once

#include "ofMain.h"
#include "ofxJSON.h"
#include "nytRE.h"
#include <iostream>

using namespace std;
#define AREAS 10


class ofApp : public ofBaseApp{
    
public:
    
    
    void setup();
    void update();
    void draw();
    void setdata();
    void decending();
    void keyPressed(int key);
    void keyReleased(int key);
    
    
    ofxJSONElement json;
    nytRE** myNytRE;
    ofImage bgImg;
    ofImage grapImg;
    bool bSnapshot;
    int snapCounter;
    int outputIndex[AREAS];
    
    
};
