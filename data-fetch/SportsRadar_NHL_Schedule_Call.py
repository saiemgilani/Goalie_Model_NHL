import http.client
import json
import io
import codecs
import requests

try:
    to_unicode = unicode
except NameError:
    to_unicode = str

for i in range(2015,2019):

    pbp_json = requests.get("https://api.sportradar.us/nhl/trial/v6/en/games/"+ str(i) +"/REG/schedule.json?api_key=zc5u6gc4bb84me6qw6vsvtgc")

    
    data = pbp_json.json()
    print(data)
    schedule_file = str(i)+"_NHL_RegSeason_Schedule.json"


    with open(schedule_file, 'w') as f:
        json.dump(data, f)
            
    # Read JSON file
    with open(schedule_file) as data_file:
        data_loaded = json.load(data_file)

    print(i,": ",data == data_loaded)

