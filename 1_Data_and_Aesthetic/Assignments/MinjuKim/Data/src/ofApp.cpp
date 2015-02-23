#include "ofApp.h"

void ofApp::setup(){
    
    
    myNytRE = new nytRE*[AREAS];
    string myZipcode[AREAS] = {"10040","10032","10031","10027","10025","10021","10019","10016","10009","10002"};
    for(int i=0; i<AREAS; i++)
    {
        string nytUrl = "http://api.nytimes.com/svc/real-estate/v2/listings/percentile/100.json?geo-extent-level=zip&geo-extent-value=" + myZipcode[i] + "&date-range=2015-02&api-key=2ddc2922ba93f98d3c7b6e447657f6d5:17:71035958";
        
//        cout << nytUrl << endl;
        bool parsingSuccessful = json.open(nytUrl);
        
        if(parsingSuccessful)
        {
            ofLogNotice("ofApp::sepup") << json.getRawString(true);
        } else {
            ofLogNotice("ofApp::setup") << "Failed to parse JSON.";
        }
        
        string zipcode = json["results"][0]["zip"].asString();
        string listing_price = json["results"][0]["listing_price"].asString();
//        cout << "zipcode:" << zipcode << endl;
//        cout << "listing price:" << listing_price << endl;
        myNytRE[i] = new nytRE(zipcode,listing_price, i);
    
    }
    
//    bgImg.loadImage("jg.jpg");
//    bgImg.loadImage("sf1.jpg");
//    bgImg.loadImage("map.jpg");
//    bgImg.loadImage("vc2.jpg");
    bgImg.loadImage("img.jpg");
    decending();
    
    snapCounter = 0;
    bSnapshot = false;
    
}

void ofApp::update(){
    
    ofBackground(0);
    
}

void ofApp::draw(){
    
    ofSetColor(255);
    for(int i=0; i<AREAS; i++)
    {
        bgImg.drawSubsection(0, i*bgImg.getHeight()/AREAS, bgImg.getWidth(), bgImg.getHeight()/AREAS,0, outputIndex[i] * bgImg.getHeight()/AREAS,bgImg.getWidth(), bgImg.getHeight()/AREAS);
    }
    
    if (bSnapshot == true){
        cout << " ??? " << endl;
        // grab a rectangle at 200,200, width and height of 300,180
        grapImg.grabScreen(0,0,bgImg.getWidth(),bgImg.getHeight());
        
        string fileName = "snapshot_"+ofToString(10000+snapCounter)+".png";
        grapImg.saveImage(fileName);
        cout << fileName.c_str() << endl;
        snapCounter++;
        bSnapshot = false;
    }

}

void ofApp::decending()
{
    
    for(int i=0; i<AREAS; i++)
    {
        outputIndex[i] = i;
    }
    
    for(int i=0; i< AREAS; i++)
    {
        float currentMax = myNytRE[i]->fPrice;
        int maxIndex = i;
        for( int j = i+1; j<AREAS; j++)
        {
            if(currentMax<=myNytRE[j]->fPrice)
            {
                currentMax = myNytRE[j]->fPrice;
                maxIndex = j;
            }
        }
        
        myNytRE[maxIndex]->fPrice = myNytRE[i]->fPrice;
        myNytRE[i]->fPrice = currentMax;
        int temp = outputIndex[maxIndex];
        outputIndex[maxIndex] = outputIndex[i];
        myNytRE[maxIndex]->sortNum = outputIndex[i];
        outputIndex[i] = temp;
        myNytRE[i]->sortNum = temp;
        
    }
    


}

void ofApp::keyPressed  (int key){
    
    cout << " ? " << endl;
    if (key == 's'){
        bSnapshot = true;
        cout << " ?? " << bSnapshot << endl;
    }
}
void ofApp::keyReleased(int key){
    
}
