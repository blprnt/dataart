import org.json.*;


String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch";
String apiKey = "4698524e56e2d0fdf3643a20bfce408c:2:71035995";

void setup() {

size(1280,720,P3D);
smooth(9);
background(255);

String[] words = {"fifty shades of grey movie", "satisfying", "questionable"};
color[] colors = {#FF0000, #00FF00, #0000FF};

int barSize = 25;
int startY = 80;

String start = "20141201";
String end = "20150215";

for (int i = 0; i < words.length; i++) {
   int freq = getArticleKeywordCount( words[i], start, end);
   fill(colors[i]);
   rect(0, startY + (barSize * i), freq/5, barSize);
};
};

void draw() {

};

int getArticleKeywordCount(String word, String beginDate, String endDate) {
String request = baseURL + "?query=" + word + "&begin_date=" + beginDate + "&end_date=" + endDate + "&api-key=" + apiKey;
String result = join( loadStrings( request ), "");

int total = 0;

try {
JSONObject nytData = new JSONObject(join(loadStrings(request), ""));
JSONArray results = nytData.getJSONArray("results");
total = nytData.getInt("total");
println ("There were " + total + " occurences of the term " + word + " between " + beginDate + " and " + endDate);
}
catch (JSONException e) {
println ("There was an error parsing the JSONObject.");
};

return(total);
};
