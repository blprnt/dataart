//
//  Country.cpp
//  DataofCountry
//
//  Created by Minju Viviana Kim on 3/1/15.
//
//

#include "Country.h"

Country::Country()
{
    name = "name";
    hit = 0;
    gnp = 0;
    color = ofColor(255,255,255);
    
}

Country::Country(string _name, float _gnp, int _hit)
{
    name  = _name;
    gnp = _gnp;
    hit = _hit;
    
}

void Country::update()
{
    cout << "Called" << endl;
}

void Country::draw()
{
    cout << "Called" << endl;
}

