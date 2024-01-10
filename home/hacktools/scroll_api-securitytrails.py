import requests, argparse, time
from json import dumps, loads

#Input and output args
parser = argparse.ArgumentParser()
parser.add_argument('-o', '--output', default='result.json')
args = parser.parse_args()
outFile = args.output

#variables
API_KEY = "oP3nDLgRfxoHcnfasdfasdfasdf"
headers = {"Content-Type": "application/json","APIKEY": API_KEY}

def scroll_query(scroll_id, i):
    url = f'https://api.securitytrails.com/v1/scroll/{scroll_id}?apikey={API_KEY}&include_ips=true'
    try:
        response = requests.request("GET", url, headers=headers)
        response_json = response.json()
    except Exception as e:
        response_json = {"Page": i, "error":e}
    return response_json

def dsl_query(query):
    url = "https://api.securitytrails.com/v1/domains/list"
    querystring = {"scroll":"true", "include_ips":"true"}
    payload = "{\"query\":\""+query+"\"}"
    response = requests.request("POST", url, data=payload, params=querystring, headers=headers)
    #print(f"Downloading page 1/{total_pages}")
    try:
        response_json = response.json()
    except Exception as e:
        response_json = {"Page": 1, "error":e}
    return response_json
        
def main():
    query = input("Please enter query paramether:\n")
    first_page = dsl_query(query.replace('"',"'"))
    time.sleep(1)
    try:
        scroll_id = first_page['meta']['scroll_id']
        total_pages = first_page['meta']['total_pages']
        print(f"Downloading page 1/{total_pages}")
        with open(outFile, "a") as out:
            out.write(dumps(first_page) + "\n")
        if total_pages > 1:
            for i in range(2,total_pages+1):
                print(f"Downloading page {i}/{total_pages}")
                scrolling = scroll_query(scroll_id, i)
                time.sleep(1)
                with open(outFile, "a") as out:
                    out.write(dumps(scrolling) + "\n")
        elif total_pages == 0:
            print("No data for this request")
            print(first_page)
            time.sleep(1)
    except Exception as e:
        print("Error happened")
        print(first_page)
        time.sleep(1)

if __name__ == "__main__":
    main()
