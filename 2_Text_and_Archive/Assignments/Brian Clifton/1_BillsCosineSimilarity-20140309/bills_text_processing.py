import json
import re
import nltk
import string
import math
from collections import Counter

with open('114_house_bills_votes_textSummary.json') as f:
    data = json.load(f)

for entry in data.keys():
    text = data[entry]['text']
    text = text.replace('_', '')
    re.sub(' +', ' ', text)
    data[entry]['text'] = text 

with open('114_house_bills_votes_textSummary-cleaned.json', 'w') as outfile:
    json.dump(data, outfile)

with open('114_house_bills_votes_textSummary-cleaned.json') as f:
    data = json.load(f)

black_list_words = ['title', 'i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x', 'part', 'subpart', 'program', 'act', 'sec']
# ignored = re.findall(r'[^A-Za-z]*', token)
stopwords   = set(nltk.corpus.stopwords.words('english'))
punctuation = string.punctuation

def normalize(text):
    for token in nltk.word_tokenize(text):
        token = token.lower()
#         token = lemmatizer.lemmatize(token)
        ignored = re.findall(r'[^A-Za-z]*', token)
        
        if token not in stopwords and token not in punctuation and token not in ignored and token not in black_list_words and len(token) > 2:
            yield token

def buildVector(iterable1, iterable2):
    counter1 = Counter(iterable1)
    counter2= Counter(iterable2)
    all_items = set(counter1.keys()).union( set(counter2.keys()) )
    vector1 = [counter1[k] for k in all_items]
    vector2 = [counter2[k] for k in all_items]
    return vector1, vector2

def cosim(v1, v2):
    dot_product = sum(n1 * n2 for n1,n2 in zip(v1, v2) )
    magnitude1 = math.sqrt (sum(n ** 2 for n in v1))
    magnitude2 = math.sqrt (sum(n ** 2 for n in v2))
    return dot_product / (magnitude1 * magnitude2)


bills_list = []
for bill in data.keys():
    bills_list.append(data[bill]['text'])

print bills_list[:5]




cosine_values = []

# mx = 20
# mx = len(bills_list)
mx = 100


for j in range(mx):
    temp = []
    print j
    for i, v in enumerate(bills_list):
        
        k = i + j
        if k == j: 
            pass
        elif k >= mx:
            pass
        else:
#             print j, k
            text1 = bills_list[j].split()
            text2 = bills_list[k].split()
            v1,v2= buildVector(text1, text2)
            cos = cosim(v1, v2)
            temp.append(cos)
            
    cosine_values.append(temp)
        
# print len(cosine_values)

import csv

f = open('cosine.csv', 'wb')
wr = csv.writer(f)
wr.writerow(cosine_values)