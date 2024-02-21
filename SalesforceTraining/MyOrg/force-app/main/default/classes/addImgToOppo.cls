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
// {!REQUIRESCRIPT("/soap/ajax/31.0/connection.js")}
// {!REQUIRESCRIPT("/soap/ajax/31.0/apex.js")}




// str = sforce.apex.execute("addImgToOppo","imageCallout",{oppId : "{!Opportunity.Id}"});

// window.alert(str);
// window.location.reload();