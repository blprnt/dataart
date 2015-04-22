//
//  Country.h
//  DataofCountry
//
//  Created by Minju Viviana Kim on 3/1/15.
//
//

#ifndef __DataofCountry__Country__
#define __DataofCountry__Country__

#include "ofMain.h"
#include <stdio.h>
#include <string>
#include <iostream>

using namespace std;

class Country {
public:
    void update();
    void draw();
    void setData();
    
    Country();
    Country(string _name, float _gnp, int _hit);
    
    string name;
    ofColor color;
    float gnp;
    int hit;
    float hitPerc;
    float finan;
    
};

#endif /* defined(__DataofCountry__Country__) */
