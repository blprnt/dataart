#include "ofApp.h"
#include <iostream>



//--------------------------------------------------------------
void ofApp::setup(){
    
    
    ofBackground(0);
    ofSetBackgroundAuto(false);
    
    frameCount = 610;
    setupCountries();
    
    myfont.loadFont(OF_TTF_MONO, 11);
    
//        ofApp::setDataforSpiral();
        ofApp::setDataforTriangle();
//        ofApp::setDataforRectangle();
    
    snapCounter = 0;
    bSnapshot = false;
    
}

//--------------------------------------------------------------
void ofApp::update(){
    
    if(ofGetFrameNum()<Couns.size()) {
        
//                ofApp::updateSpiral();
                ofApp::updateTriangle();
//                ofApp::updateRectangle();
    }
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    if(ofGetFrameNum()<frameCount) {
        
//                ofApp::drawSpiral();
                ofApp::drawTriangle();
//                ofApp::drawRectangle();
        
    }
    
    if (bSnapshot == true){

        grapImg.grabScreen(0,0,ofGetWidth(),ofGetHeight());
        
        string fileName = "snapshot_"+ofToString(10000+snapCounter)+".png";
        grapImg.saveImage(fileName);
        snapCounter++;
        bSnapshot = false;
    }
    
    
    
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    
    if (key == 's'){
        bSnapshot = true;
        cout << "shot!" << bSnapshot << endl;
    }
    
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    
}

bool isquo(const char &c)
{
    return (c < 65 | c > 122);
}
bool isquo2(const char &c)
{
    return '"'==c;
}

bool iscomm(const char &c)
{
    return ','==c;
}

float to(std::string s)
{
    s.erase(std::remove_if(s.begin(), s.end(), &iscomm ),s.end());
    
    std::stringstream ss(s);
    float v = 0;
    ss >> v;
    return v;
}

void ofApp::setupCountries() {
    
    string countries[]= {
        "Korea", "China", "India", "US", "Indonesia", "Brazil", "Pakistan", "Nigeria", "Bangladesh", "Russia", "Japan"
        , "Mexico", "Philippines", "Ethiopia", "Egypt", "Germany", "Iran", "Turkey", "Congo", "Thailand"
    };
    
    csv.loadFile(ofToDataPath("gnp.csv"));
//    cout << csv.numRows<< endl;
//    cout << csv.data[1].size() << endl;
//    cout << csv.data[117][0] << endl;
//    cout << csv.data[117][57] << endl;
    string name = csv.getString(117, 0);
    cout << name.length() << endl;
    name.erase(std::remove_if(name.begin(), name.end(), &isquo ),name.end());
    cout << name << name.length() << endl;
    const char* c = name.c_str();
    if( std::strcmp(c,"Korea") == 0 ) {
        cout << "Yes" << endl;
        cout << csv.getString(117,57) << endl;
    } else {
        cout << "No"<< name << endl;
    }
    

    Countries.resize(sizeof(countries)/sizeof(string));
    for(int i=0; i <sizeof(countries)/sizeof(string); i++){
        
        string hitUrl = "http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + countries[i] + "&begin_date=20041001&end_date=20141231&api-key=d9475e759c0c00a9ee53cae4d35521c7:7:71035975";
        
        bool parsingSuccessful = json.open(hitUrl);
        
        if(parsingSuccessful){
            //ofLogNotice("ofApp::setup") << json.getRawString(true);
        } else {
            //ofLogNotice("ofApp::setup") << "Failed to parse JSON";
        }
        
        int hit = json["response"]["meta"]["hits"].asInt();
        float gnp;
        
        for(int j=0; j < csv.numRows -1 ; j++) {
            string name = csv.getString(j,0);
            name.erase(std::remove_if(name.begin(),name.end(), &isquo ), name.end());
            const char* c = name.c_str();
            if(std::strcmp(c,countries[i].c_str())==0) {
                cout << "yes!" << j << "  :  " << csv.getString(j,57) << endl;
                string sGnp = csv.getString(j,57);
                sGnp.erase(std::remove_if(sGnp.begin(),sGnp.end(), &isquo2 ), sGnp.end());
                gnp = to(sGnp);
                break;
            }
        }
        //string _name, double _gnp, int _hit
        Countries[i].name = countries[i];
        Countries[i].gnp = gnp;
        Countries[i].hit = hit;
        cout << Countries[i].name  << ": " << Countries[i].gnp << " : "<< Countries[i].hit << "\n" << endl;
    }
    
    setVector();
    
}

void ofApp::setVector() {
    
    float hit = 0;
    float gnp = 0;
    float sHit;
    int nCheck=0;
    
    for(int i = 0; i < Countries.size(); i++) {
        
        hit = Countries[i].hit + hit;
        gnp = Countries[i].gnp + gnp;
        
    }
    
    sHit = hit/frameCount;
    
    for(int i = 0; i < Countries.size(); i++) {
        
        Countries[i].hitPerc = Countries[i].hit/sHit/5;
        cout<< Countries[i].name << " : " <<Countries[i].hitPerc << endl;
        
        // 10%
        if(Countries[i].gnp > gnp/Countries.size()*2.0) {
            Countries[i].color = ofColor(255,226,59);
        } else if (Countries[i].gnp < gnp/Countries.size()*2.0 && Countries[i].gnp > gnp/Countries.size()*1.5 ){
            Countries[i].color = ofColor(170,150,40);
        } else if (Countries[i].gnp < gnp/Countries.size()*1.5 && Countries[i].gnp > gnp/Countries.size()*0.8 ){
            Countries[i].color = ofColor(117,104,27);
        } else if (Countries[i].gnp < gnp/Countries.size()*0.8 && Countries[i].gnp > gnp/Countries.size()*0.3 ){
            Countries[i].color = ofColor(96,97,78);
        } else {
            Countries[i].color = ofColor(46,47,38);
        }
        
        
        cout << Countries[i].name.length() << endl;
        nCheck = nCheck + Countries[i].name.length()*int(Countries[i].hitPerc+1);
        
    }
    
    cout << nCheck << endl;
    int f = 0;
    
    for(int i = 0; i < Countries.size(); i++) {
        for(int j=0; j< Countries[i].hitPerc+1; j++) {
            for(int r = 0; r < Countries[i].name.length(); r++) {
                Couns.push_back(Countries[i].name[r]);
                Colors.push_back(Countries[i].color);
                cout<< Countries[i].name[r] << endl;
                cout<< Countries[i].color << endl;
                cout<< Couns[f] << endl;
                cout<< Colors[f] << endl;
                f++;
            }
        }
    }
    
}

void ofApp::setDataforSpiral(){
    
    theta = 5;
    
}

void ofApp::setDataforTriangle(){
    
    x = 0;
    y = 0;
    space = 45;
    height = 3;
    baseline = 45;
    baseFlag = true;
    margine = 5;
    
    count = 0;
}

void ofApp::setDataforRectangle(){
    
    space = 30;
    margine = 10;
    x = space;
    y = -1 * space;
    count = 0;
    
    xPlusFlag = false;
    xMinFlag = false;
    yPlusFlag = true;
    yMinFlag = false;
    xCheck = -1;
    yCheck = 1;
    
    preXStand = x;
    preYStand = y;
    xStand = preXStand + (xCheck)*(count+2)*space;
    yStand = preYStand + (yCheck)*(count+2)*space;
    
    
}

void ofApp::drawSpiral(){
    
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2,ofGetHeight()/2);
    ofPushMatrix();
    ofTranslate(x*radian, y*radian);
    ofRotate(theta*180/PI+90);
    
    ofSetColor(Colors[ofGetFrameNum()]);
    ofFill();
    //ofCircle(0,0,10);
    myfont.drawString(ofToString(Couns[ofGetFrameNum()]), 0, 0);
    
    ofPopMatrix();
    ofPopMatrix();
    
}

void ofApp::drawTriangle(){
    
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2,ofGetHeight()/2+50);
    ofPushMatrix();
    ofTranslate(x, y);
    
    //    myfont.drawString("S", 0, 0);
    
    ofSetColor(Colors[ofGetFrameNum()]);
    if(!baseFlag) {
        if(x<0) {
            ofRotate(300);
            myfont.drawString(ofToString(Couns[ofGetFrameNum()]), 0, 11);
            
        } else {
            ofRotate(60);
            myfont.drawString(ofToString(Couns[ofGetFrameNum()]), 0, 0);
            
        }
    } else {
        ofRotate(180);
        myfont.drawString(ofToString(Couns[ofGetFrameNum()]), -11, 11);
    }
    
    //    myfont.drawString("K", 0, 0);
    ofPopMatrix();
    ofPopMatrix();
}

void ofApp::drawRectangle(){
    
    ofPushMatrix();
    ofTranslate(ofGetWidth()/2, ofGetHeight()/2);
    ofPushMatrix();
    ofTranslate(x,y);
    if(yPlusFlag){
        ofRotate(90);
    } else if(xMinFlag) {
        ofRotate(180);
    } else if(yMinFlag) {
        ofRotate(270);
    } else if(xPlusFlag) {
        //NONE
    }
    ofSetColor(Colors[ofGetFrameNum()]);
    myfont.drawString(ofToString(Couns[ofGetFrameNum()]), 0, 0);
    ofPopMatrix();
    ofPopMatrix();
}

void ofApp::updateSpiral(){
    
    theta = theta + TWO_PI/144*(50/theta);
    
    x = cos(theta);
    y = sin(theta);
    radian = theta*4.5;
    
}

void ofApp::updateTriangle(){
    
    if(baseFlag) {
        if(x > -1*(((1+1/sqrt(height))*space*count + sqrt(height)*baseline)/sqrt(height))) {
            x = x - 2*margine;
        } else {
            count++;
            baseFlag = false;
        }
    } else {
        if(x < ((1+1/sqrt(height))*space*count + sqrt(height)*baseline -space)/sqrt(height)){
            x = x + margine;
            y = x/abs(x) * sqrt(height) * x - (baseline*sqrt(height)+(count -1)*space);
        }else {
            baseFlag = true;
        }
    }
    
}

void ofApp::updateRectangle(){
    
    if(yPlusFlag) {
        if(y<=yStand) {
            y = y + (yCheck)*margine;
        } else {
            count++;
            yPlusFlag = false;
            xMinFlag = true;
            yCheck = yCheck * -1;
            preYStand = yStand;
            yStand = preYStand + (yCheck)*(count+2)*space;
        }
    }else if(xMinFlag) {
        if(x >= xStand) {
            x = x + (xCheck)*margine;
        } else {
            xMinFlag = false;
            yMinFlag = true;
            xCheck = xCheck * -1;
            preXStand = xStand;
            xStand = preXStand + (xCheck)*(count+2)*space;
        }
    } else if(yMinFlag) {
        if(y >=yStand){
            y = y + (yCheck)*margine;
        } else {
            count++;
            yMinFlag = false;
            xPlusFlag = true;
            yCheck = yCheck * -1;
            preYStand = yStand;
            yStand = preYStand + (yCheck)*(count+2)*space;
        }
    }else if(xPlusFlag) {
        if(x <= xStand) {
            x = x + (xCheck)*margine;
        } else {
            xPlusFlag = false;
            yPlusFlag = true;
            xCheck = xCheck * -1;
            preXStand = xStand;
            xStand = preXStand + (xCheck)*(count+2)*space;
        }
    }
    
}