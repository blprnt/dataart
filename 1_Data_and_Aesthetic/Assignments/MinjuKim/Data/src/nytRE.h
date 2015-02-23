//
//  nytRE.h
//  Data
//
//  Created by Minju Viviana Kim on 2/16/15.
//
//

#ifndef NYT_RE_h
#define NYT_RE_h

#include "ofMain.h"
#include <iostream>
#include <string>
#include <sstream>
#include <algorithm>

using namespace std;

class nytRE {
public:
    void update();
    void draw();
    void setImg(ofImage _img);
    nytRE();
    nytRE(string _zip, string _price, int _num);
    
    string zip;
    string price;
    float fPrice;
    int num;
    int sortNum;
    //ofImage img;
};

#endif
