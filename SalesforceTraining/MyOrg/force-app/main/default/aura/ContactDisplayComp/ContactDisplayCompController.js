({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAllContacts");
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state == "SUCCESS") {
                component.set("v.relatedContactList",response.getReturnValue());
                
            }
        });
        $A.enqueueAction(action);
    },
    search : function(component , event , helper) {
        var searchString = component.get("v.searchString");
        if (searchString.length>0) {
            var action = component.get("c.getConList");
            action.setParams({
                searchString : searchString
            });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state == "SUCCESS"){
                    component.set("v.conList",response.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set("v.conList",[]);
        }
    },
    selectRecord : function(component , event , helper){
        var selectedRecordId = event.currentTarget.dataset.record;
        var records = component.get("v.conList");

        var selectedRecord = records.find(function(record) {
            console.log('selectRecord@@:  '+record.Name);
            return record.Id === selectedRecordId;
        });
        component.set("v.searchString",selectedRecord.Name);
        component.set("v.accountId",selectedRecordId);
        component.set("v.conList",[]);

        console.log("Selected = "+selectedRecord.Name);
        var action = component.get("c.getRelatedContacts");
        action.setParams({accountId : selectedRecord.AccountId});
        console.log("AccountId = "+selectedRecord.AccountId);
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.relatedContactList",response.getReturnValue());
                console.log("Response = "+response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

    }
})
