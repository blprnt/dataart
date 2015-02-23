//
//  nytRE.cpp
//  Data
//
//  Created by Minju Viviana Kim on 2/16/15.
//
//

#include "nytRE.h"

bool isdot(const char &c)
{
    return '.'==c;
}
bool iscomm(const char &c)
{
    return ','==c;
}
bool isdol(const char &c)
{
    return '$'==c;
}

float to(std::string s)
{
    s.erase(std::remove_if(s.begin(), s.end(), &isdot ),s.end());
    s.erase(std::remove_if(s.begin(), s.end(), &iscomm ),s.end());
    s.erase(std::remove_if(s.begin(), s.end(), &isdol ),s.end());
    
    
    
    std::stringstream ss(s);
    float v = 0;
    ss >> v;
    return v;
}


nytRE::nytRE()
{
    zip = "zip";
    price = "price";
    num = 0;
}

nytRE::nytRE(string _zip, string _price, int _num)
{
    num = _num;
    sortNum = num;
    zip = _zip;
    price = _price;
    fPrice = to(price);
    
    cout << num << "    " << zip << "    " << price << "    " << fPrice << endl;
}


void nytRE::update()
{
    cout << "update called" << endl;
    
}

void nytRE::draw()
{
    cout << "draw called" << endl;
    
}

