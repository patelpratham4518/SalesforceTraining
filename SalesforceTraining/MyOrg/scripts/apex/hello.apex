// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// string tempvar = 'Pratham';
// System.debug('Hello Developers!');
// Integer n = 4518;
// System.debug(n);
// Decimal f = 45.63;
// System.debug(f);
// Boolean flag = True;
// System.debug(flag);
// Blob X = Blob.valueOf('Patel Pratham');
// System.debug(X.toString()); 

// Date myDate = Date.newInstance(2018,02,28);
// System.debug(myDate);

// Date newDate = Date.today();
// System.debug(newDate);
// DateTime now  = DateTime.now();
// System.debug(now);

// Id recordId = '0065g00000bxMqVAAU';
// System.debug(recordId);


// enum os{ Mac , Linux , Windows }
// os myOs = os.Mac;
// System.debug(myOs);

// Contact con = new Contact(firstname  = 'Lewis' , lastname = 'Hamilton');
// System.debug(con);

// sObject acc = new Account();
// acc.put('Name', 'Lewis Hamilton');
// acc.put('Email__c', 'lewisf1@gmail.com');

// System.debug(acc);
// Object accName = acc.get('Email__c');

// System.debug(accName);

// String[] nameList = new String[3];
// String[] nameList = new List<String>(); 
// List<String> nameList = new List<String>();

// nameList.add('Pratham');
// nameList.add('Vaidik');
// nameList.add('Vyom');
// nameList.add('Good Morning');
// List<String> nameList = new List<String>{'Pratham','Vaidik','Vyom','Yagnik'};
// System.debug(nameList.size());
// System.debug(nameList);
// nameList.remove(3);
// System.debug(nameList);
// System.debug(nameList.isEmpty());
// nameList.clear();
// System.debug(nameList);

// Set<String> collection = new Set<String>{'x','y','z'};
// Set<String> collection = new Set<String>();
// // collection = {'x','y','z'};
// collection.add('x');
// collection.add('Y');
// collection.addAll(nameList);
// System.debug(collection);
// // System.debug(collection.contains('Y'));
// // System.debug(collection.containsAll(nameList));
// collection.retainAll(nameList);
// System.debug(collection);

// Map<Integer, String> m = new Map<Integer, String>();
// m.put(1, 'Bhavna');
// m.put(2, 'Sapna');
// m.put(3, 'Divya');
// System.debug(m);
// System.debug(m.get(2));
// System.debug(m.values());
// System.debug(m.keySet());

// String p  = 'Pratham';
// System.debug(tempvar ==  p);

// List<Account> accounts = [select Id , Name from Account];
// System.debug(accounts);
// for(Integer i=0 ; i<accounts.size() ; i++){
//     System.debug(accounts[i]);
// }


//Execute for making all Amounts zero of account and contact
// List<Account> accounts = [select Total_Amount__c from Account];
//     for(Account account:accounts){
//         account.Total_Amount__c = 0 ;
//     }
// update accounts;
    
// List<Contact> contacts = [select Amount__c from Contact];
//     for(Contact contact:contacts){
//         contact.Amount__c = 0 ;
//     }
// update contacts;

// List<Account> accounts = [select Max_Amount_For_Contact__c from Account where Max_Amount_For_Contact__c = null ];
//     for(Account account:accounts){
//         account.Max_Amount_For_Contact__c = 0 ;
//     }
// update accounts;

