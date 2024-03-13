global class addImgToOppo {
    public addImgToOppo(String oppId) {
        
        System.debug('OppId='+oppId);
        System.debug('Inside the controller');
    }
    public static void imageCallout(String oppId) {
        System.debug('OppId='+oppId);
        System.debug('Inside the future method');
    }
}

//js script
// {!REQUIRESCRIPT("/soap/ajax/13.0/connection.js")}
// {!REQUIRESCRIPT("/soap/ajax/10.0/apex.js")}

// var parameter = "{!Opportunity.Id}";

// var retVal = sforce.apex.execute( "addImgToOppo", "imageCallout", {oppId: parameter});
// window.alert(retVal);
// window.location.reload();