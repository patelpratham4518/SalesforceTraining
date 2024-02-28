({
    doInit : function(component, event, helper) {
        
    },
    createContact : function (component , event , helper) {
        var FirstName = component.get("v.FirstName");
        var LastName = component.get("v.LastName");
        var Mobile = component.get("v.Mobile");
        var Email = component.get("v.Email");
        var accountId = component.get("v.AccountId");
    
        
        var action = component.get("c.createContactApex");
        action.setParams({FirstName:FirstName , LastName:LastName , Mobile:Mobile, Email:Email, accountId:accountId});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                // alert(response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                console.log("action =  "+toastEvent);
                toastEvent.setParams({
                    title : 'Success',
                    message: 'This is a success message',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                    
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    showSuccess : function(component, event, helper) {
        console.log("success called");
       
        var toastEvent = $A.get("e.force:showToast");
        console.log("action =  "+toastEvent);
        toastEvent.setParams({
            title : 'Success',
            message: 'This is a success message',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
            
        });
        toastEvent.fire();
    },

    search : function (component , event , helper) {  

        var searchString = component.get("v.searchString");
        
        
        if (searchString.length > 0) {
            
            var action = component.get("c.getAccounts");
            action.setParams({
                searchString: searchString
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.accList", response.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set("v.accList", []);
            console.log("Cleared records");
        } 
    },

    clearSearch : function (component , event , helper) {
        component.set("v.searchString", "");
        component.set("v.accList",[]);
    },
    selectRecord : function (component , event , helper) {
        var selectedRecordId = event.currentTarget.dataset.record;
        var records = component.get("v.accList");

        var selectedRecord = records.find(function(record) {
            console.log('selectRecord@@:  '+record.Id);
            return record.Id === selectedRecordId;
        });

        console.log("RecordId = " + selectedRecordId);
        component.set("v.AccountId",selectedRecordId);
        component.set("v.searchString",selectedRecord.Name);
        component.set("v.accList",[]);
    }
    
    
})


