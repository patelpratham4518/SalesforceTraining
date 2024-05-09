#don't work INVALID_TYPE: Must send a concrete entity type.
from zeep import Client
from zeep.plugins import HistoryPlugin
from zeep.exceptions import Fault
wsdl_path = "/home/patelpratham/Downloads/WSDL/enterprise.wsdl"
history = HistoryPlugin()
client = Client(wsdl_path, plugins=[history])
session_id = "00D5g00000LQNlF!ARcAQOmhgf.yEKloZOpnoWw1H7UecEB0SAbSUmpLwfX6cp18RZxGQUpgloEGfj3poeM6Dr9fDNqO2R3Aq1d8N1cErcsT9Iue"
server_url = "https://mvclouds-c8-dev-ed.develop.my.salesforce.com/services/Soap/c/60.0/00D5g00000LQNlF/0DFJ1000000Kykx"
service_name = "SforceService"
for service_name, service in client.wsdl.services.items():
    for port_name, port in service.ports.items():
        port.binding_options["address"] = server_url
session_header = {
    "SessionHeader": {
        "sessionId": session_id
    }
}
client.set_default_soapheaders(headers=session_header)

records = []
for i in range(1, 11):
        account = {
        "sObjects": {
            "_xsi:type": "sObject:Account",  # Use the correct type for the object
            "Name": f"SOAPPyAccount{i}",
            "Gender__c": "Male"
            }
        }   
        records.append(account)

 
    # account = {
    #     "type":"Account",
    #     "fields":{            
    #         "Name":f"SOAPPyAccount{i}",
    #         "Gender__c":"Male"
    #     }
    # }
    # account = {
    #     "type":"Account",
    #     "Name":f"SOAPPyAccount{i}",
    #     "Gender__c":"Male"
    # }
    
    # account = {
    #     "__prefix":"urn",
    #     "sObjects":{
    #         "_xsi:type" : "urn1:Account",
    #         "Name":{
    #             "__prefix":"urn",
    #             "__text":f"SOAPPyAccount{i}"    
    #         },
    #         "Gender__c":{
    #              "__prefix":"urn",
    #             "__text":"Male"    
    #         }
    #     }
    # }
  

try:
    response = client.service.create(records)
    print("Success ==> ",response)  
    
except Fault as fault: 
    print("Error ==> ",fault)       
    
    
# client.service.logout()

