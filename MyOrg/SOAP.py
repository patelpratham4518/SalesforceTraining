#for login
from zeep import Client
from zeep.exceptions import Fault

# Define Salesforce credentials
# username = "patelpratham@mvclouds.sandbox"
# password = "Pp123456"
# security_token = "wD9FkLcHMs34vTGTCruo0YR18"

# WSDL file path
wsdl_path = "/home/patelpratham/Downloads/WSDL/enterprise.wsdl"


# Create SOAP client
try:
    client = Client(wsdl=wsdl_path)
    print("client created")
except Exception as e:
    print(e)

#for session Id
# login_response = None
# try:
#     # Call the login method to authenticate and obtain session ID
#     login_response = client.service.login(username=username, password=password+security_token)
    
#     # Obtain the session ID and server URL from the response
#     session_id = login_response.sessionId
#     server_url = login_response.serverUrl
    
#     # Print the session ID and server URL
#     print("Session ID:", session_id)
#     print("Server URL:", server_url)

# except Fault as fault:
#     print(f"Login failed: {fault}")


# Define session ID and server URL (you may need to use a login method depending on your WSDL)
session_id = "00D5g00000LQNlF!ARcAQN4QDea.fpB3N23P.xXdS.ilEgRE0P4Kb.oW9pAzWObB_5ibRMHPRUrw8JdV2RibJ7j79k1HqKA5BWWdXyfhCXk4RdDI"
server_url = "https://mvclouds-c8-dev-ed.develop.my.salesforce.com/services/Soap/c/60.0/00D5g00000LQNlF/0DFJ1000000Kykx"

# Set the session header with the session ID
session_header = {
   "SessionHeader": {
        "sessionId": session_id
    }
}
client.set_default_soapheaders(headers=session_header)

# Define the Account object and loop through 10 iterations
accounts = []
for i in range(1, 11):
    account_name = f"SOAPPyAccount{i}"
    
    # Create the account record
    account = {
        "type": "Account",
        "Name": account_name,
        "Gender":"Male"
    }
    
    accounts.append(account)
    
    
try:
    # Send the create request using the client
    response = client.service.create(accounts)
    print("response==> ",response)
except Fault as fault:
    # Handle SOAP Faults
    print(f"Failed to create account because ==>",fault)
