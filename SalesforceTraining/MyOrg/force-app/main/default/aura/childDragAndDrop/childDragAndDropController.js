({
    doInit : function(component, event, helper) {
            
    },
    search : function(component, event, helper) {
        let searchString = component.get("v.searchString");
        if (searchString.length>0) {
            let action = component.get("c.getAccList");
            action.setParams({
                searchString : searchString
            });
            action.setCallback(this,function(response){
                let state = response.getState();
                if(state == "SUCCESS"){
                    component.set("v.accList",response.getReturnValue());
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set("v.accList",[]);
            component.set("v.relatedContactList",[]);
        }
    },

    selectRecord : function(component , event , helper){
        let selectedRecordId = event.currentTarget.dataset.record;
        let records = component.get("v.accList");

        let selectedRecord = records.find(function(record) {
            console.log('selectRecord@@:  '+record.Name);
            return record.Id === selectedRecordId;
        });
        component.set("v.searchString",selectedRecord.Name);
        component.set("v.accountId",selectedRecordId);
        component.set("v.accList",[]);

        console.log("Selected = "+selectedRecord.Name);
        let action = component.get("c.getRelatedContacts");
        action.setParams({accountId : selectedRecordId});
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.relatedContactList",response.getReturnValue());
                component.set("v.total",response.getReturnValue().length);
                console.log("Response = "+response.getReturnValue());
            }
            else{
                
            }
        });
        $A.enqueueAction(action);

    }
})
