import requests

url = "https://mvclouds-c8-dev-ed.develop.my.salesforce.com/services/Soap/c/60.0/00D5g00000LQNlF/0DFJ1000000Kykx"
ids = ["001J1000002edqbIAA","001J1000002edqcIAA"]
ids_string = ""
for id in ids:
    ids_string+=f"<ids>{id}</ids>\n"

payload = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tns=\"http://soap.sforce.com/schemas/class/SOAP\">\n<soap:Header>\n    <tns:SessionHeader>\n      <sessionId>00D5g00000LQNlF!ARcAQOmhgf.yEKloZOpnoWw1H7UecEB0SAbSUmpLwfX6cp18RZxGQUpgloEGfj3poeM6Dr9fDNqO2R3Aq1d8N1cErcsT9Iue\n      </sessionId>\n    </tns:SessionHeader>\n</soap:Header>\n  <soap:Body>\n    <delete xmlns=\"urn:enterprise.soap.sforce.com\">\n      "+ids_string+"    </delete>\n  </soap:Body>\n</soap:Envelope>\n"

headers = {
  'Content-Type': 'text/xml; charset=utf-8',
  'SOAPAction': 'POST',
  'Cookie': 'BrowserId=zbo5Xe2JEe6K-yOLwgNipQ; CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1'
}

response = requests.request("POST", url, headers=headers, data=payload)

print("Delete response ==> ",response.text)
