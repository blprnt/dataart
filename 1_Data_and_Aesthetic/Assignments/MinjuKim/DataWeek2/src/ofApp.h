#pragma once

#include "ofMain.h"
#include "ofxJSON.h"
#include "ofxCsv.h"
#include <iostream>
#include "Country.h"

using namespace wng;

class ofApp : public ofBaseApp{
public:
    void setup();
    void update();
    void draw();
    void setupCountries();
    void setVector();
    void setDataforSpiral();
    void setDataforTriangle();
    void setDataforRectangle();
    void drawSpiral();
    void drawTriangle();
    void drawRectangle();
    void updateSpiral();
    void updateTriangle();
    void updateRectangle();
    
    void keyPressed(int key);
    void keyReleased(int key);
    
    ofTrueTypeFont myfont;
    ofxJSONElement json;
    ofxCsv csv;
    ofxCsv csvRecorder;
    vector<Country> Countries;
    vector<char> Couns;
    vector<ofColor> Colors;
    
    float x;
    float y;
    float space;
    float margine;
    float count;
    int frameCount;
    
    
    
    //for Spiral
    float theta;
    float radian;
    
    //for Triangle
    float baseline;
    float height;
    bool baseFlag;
    
    //for Rectangle
    bool xPlusFlag;
    bool xMinFlag;
    bool yPlusFlag;
    bool yMinFlag;
    int xCheck;
    int yCheck;
    float xStand;
    float preXStand;
    float yStand;
    float preYStand;

    ofImage grapImg;
    bool bSnapshot;
    int snapCounter;

    
    
};
