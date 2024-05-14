Setup :-
->First Install ApacheAnt
->Then Download Salesforce Ant Migration Tool from this link : https://gs0.salesforce.com/dwnld/SfdcAnt/salesforce_ant_59.0.zip
->Extract above file and put ant-salesforce.jar to apache ant's library in windows or in linux add path to ant-salesforce.jar as global variable

->Set your credentials in build.properties
->In package.xml write what you want to retrieve
->Open terminal in this directory and bash "ant retrieve"
->All data would be retrieved in retrieveOutput folder

->change credential of org you want to deploy
->Open terminal in this directory and bash "ant deploy"
->all data from retrieveOutput would be deployed to your org


#you can modify build.xml as per your requirements
#you can add more <target name="XYZ"> and when you bash "ant XYZ" that code snippet will execute


#For more information see sample file
