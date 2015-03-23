import json
import string
import re
import urllib
import nltk
from nltk.stem.wordnet import WordNetLemmatizer
from bs4 import BeautifulSoup

lemmatizer = WordNetLemmatizer()
stopwords   = set(nltk.corpus.stopwords.words('english'))
punctuation = string.punctuation
black_list_words = ['title', 'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x', 'part', 'subpart', 'program', 'act', 'sec']


def get_all_bills(url):
    data = urllib.urlopen(url).read()
    soup = BeautifulSoup(data)
    a = soup.select('a')

    bills = []
    for item in a:
        i = item.text.replace('/', '')
        bills.append(i)

    return bills

def normalize(text):
    for token in nltk.word_tokenize(text):
        token = token.lower()
        token = lemmatizer.lemmatize(token)
        ignored = re.findall(r'[^A-Za-z]*', token)
        
        if token not in stopwords and token not in punctuation and token not in ignored and token not in black_list_words and len(token) > 2:
            yield token

def get_bills(billtype):
    for bill in bills_list:
        print bill


        text_url = 'https://www.govtrack.us/data/congress/114/bills/hr/%s/text-versions/ih/document.txt' % (bill)
        text_response = urllib.urlopen(text_url)
        text = text_response.read()
        # info_url = 'https://www.govtrack.us/data/congress/114/bills/%s/%s/data.json' % (billtype, bill)
        # info_response = billurllib.urlopen(info_url)
        # json_data = json.loads(info_response.read())

        # ALTERNATE VERSION:
        # filepath = '/Users/brianclifton/Desktop/DATA/GovTrack_Bills/bills/%s/%s/data.json' % (billtype, bill)
        # json_file = open(filepath)
        # json_str = json_file.read()
        # json_data = json.loads(json_str)

        # bill_type =  json_data['bill_type']
        # number = json_data['number']
        # bill_id = bill_type + number
        # congress = json_data['congress']
        # year = re.search('[0-9]{4}', json_data['introduced_at']).group(0)

        # text = json_data['summary']['text']

        ntext = normalize(text)
        counts  = nltk.FreqDist(ntext)
    
        bill_dict[bill]= {}
        bill_dict[bill]['frequency'] = counts.most_common(100)
        bill_dict[bill]['text'] = text
        
        # get_votes(bill)

    # print json.dumps(bill_dict, indent=1)


def get_votes(bill):
    url = 'https://www.govtrack.us/data/congress/114/votes/2015/%s/data.json' % bill
    votes_response = urllib.urlopen(url)
    votes_json = json.loads(votes_response.read())
    
    votes = {}
    for vote in votes_json['votes']:
        temp = []
        for member in votes_json['votes'][vote]:
            temp.append(member['id'])
        votes[vote] = temp
        
    bill_dict[bill]['votes'] = votes

    # data.update(bill_dict)
    


# with open('114_congress_bills_votes_textSummary.json') as f:
#     data = json.load(f)
bill_dict = {}
all_bills_url = 'https://www.govtrack.us/data/congress/114/bills/hr/'
bills_list = get_all_bills(all_bills_url)
bills_list.pop(0)

get_bills('hr')

print json.dumps(bill_dict, indent=1)
with open('114_house_bills_votes_textSummary.json', 'w') as outfile:
    json.dump(bill_dict, outfile)



