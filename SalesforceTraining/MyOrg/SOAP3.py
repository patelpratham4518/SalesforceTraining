import requests

objstring = ""
# for i in range(1, 11):
#     objstring += f"           <urn:sObjects xsi:type=\"urn1:Account\">\n                <urn:Name>SOAPPyAccount{i}</urn:Name>\n                <urn:Gender__c>Male</urn:Gender__c>\n            </urn:sObjects>\n"

for i in range(1, 11):
    objstring += f" <urn:sObjects xsi:type=\"urn1:Contact\">\n   <urn:LastName>SOAPPyContact{i}</urn:LastName>\n   </urn:sObjects>\n"




url = "https://mvclouds-c8-dev-ed.develop.my.salesforce.com/services/Soap/c/60.0/00D5g00000LQNlF/0DFJ1000000Kykx"

payload = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:enterprise.soap.sforce.com\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n    <soap:Header>\n        <urn:SessionHeader>\n            <urn:sessionId>00D5g00000LQNlF!ARcAQOmhgf.yEKloZOpnoWw1H7UecEB0SAbSUmpLwfX6cp18RZxGQUpgloEGfj3poeM6Dr9fDNqO2R3Aq1d8N1cErcsT9Iue</urn:sessionId>\n        </urn:SessionHeader>\n    </soap:Header>\n    <soap:Body>\n        <urn:create>\n "+ objstring +"       </urn:create>\n    </soap:Body>\n</soap:Envelope>\n"
headers = {
  'Content-Type': 'text/xml; charset=utf-8',
  'SOAPAction': 'POST',
  'Cookie': 'BrowserId=zbo5Xe2JEe6K-yOLwgNipQ; CookieConsentPolicy=0:1; LSKey-c$CookieConsentPolicy=0:1'
}

response = requests.request("POST", url, headers=headers, data=payload)

print("Response ==> ",response.text)

    