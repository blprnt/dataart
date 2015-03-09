/*NYTimes Best sellers gallery. By Yining Shi*/

/*In processing, I saved all images in my laptop. 
  In order to run the current sketch, one can uncomment the following code
  to save 640 images. Then run the current sketch. 
 "// String imageUrl = book.getString("image").toString();
  // img = loadImage(imageUrl);
  // img.save(m + ".jpg" );") */

PImage img, displayImg;
JSONArray books;
JSONArray hues;
int j = 0, k = 0, picWidth = 50, m = 0;

void setup() {
  size(displayWidth, displayHeight);
  colorMode(HSB, 360, 255, 255);
  
  hues = new JSONArray();
  float[] hueArray = {};
  
  books = loadJSONArray("data.json");
  for (int i = 0; i < books.size(); i++) {
    JSONObject book = books.getJSONObject(i);
    if(!book.isNull("image")){
      // String imageUrl = book.getString("image").toString();
      // img = loadImage(imageUrl);
      // img.save(m + ".jpg" );
      
      img = loadImage(m+".jpg");
      m++;
      img.resize(0, picWidth);
      
      loadPixels();
      img.loadPixels(); 
      int huee = 0;
        for (int y = 0; y < img.height; y++) {
          for (int x = 0; x < img.width; x++) {
           //int loc = x + y*width;
           int rgbcolor = img.get(x, y);
           float addhuee = brightness(rgbcolor);
           huee += addhuee;
          }
        }
      updatePixels();
      float mean = huee/(img.width*img.height);
      hueArray = append(hueArray, mean);

    }
  }
  
  
  
  
  float[] sorted = sort(hueArray);
  
  for(int i = 0; i < sorted.length; i++){
    
      int position = find(hueArray, sorted[i]);
    
      displayImg = loadImage(position+".jpg");
      displayImg.resize(0, picWidth);
      image(displayImg, k, j);
      k += displayImg.width;
      if(k > width){
        k = 0;
        j += displayImg.height;
      }
  }
}

int find(float[] arr, float element) {
  for(int i = 0; i<arr.length; i++){
    if (arr[i] == element)
      return i;
  }
  return -1;
}

void draw() {
      
}
