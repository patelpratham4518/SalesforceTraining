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
                // console.log("Response = "+response.getReturnValue());

                let section = component.get("v.section")
                if (section == "section1") {
                    component.set("v.accountIdSection1",selectedRecordId)
                }
                else {
                    component.set("v.accountIdSection2",selectedRecordId)
                }

                let setTotal = component.get("c.getTotal")
                $A.enqueueAction(setTotal)
                
            }
            else{
                
            }
        });
        $A.enqueueAction(action);
    },

    getTotal: function(component ,event , helper){
        console.log("getTotal Called");
        let accountId = component.get("v.accountId")
        let action = component.get("c.getTotalCount")
        action.setParams({
            accountId : accountId
        })
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.totalAggrigate",response.getReturnValue())
            }
        })
        $A.enqueueAction(action)
    },

    ondragstart : function(component , event, helper) {
        // console.log(event.target.id)
        let contactId = event.target.id
        component.set("v.contactIdChange",contactId)
        let section = component.get("v.section")
        // console.log("section = ",section);
        component.set("v.currentSection",section)
            
        console.log(`selected Contact = ${component.get("v.contactIdChange")}`);
    },
    
    refresh : function(component,event,helper){
        console.log("Refresh called");
        let accountId = component.get("v.accountId")
        let action = component.get("c.getRelatedContacts");
        action.setParams({accountId : accountId});
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.relatedContactList",response.getReturnValue());
                component.set("v.total",response.getReturnValue().length);
                // console.log("Response = "+response.getReturnValue());

                let section = component.get("v.section")
                if (section == "section1") {
                    component.set("v.accountIdSection1",accountId)
                }
                else {
                    component.set("v.accountIdSection2",accountId)
                }

                let setTotal = component.get("c.getTotal")
                $A.enqueueAction(setTotal)
                
            }
            else{
                
            }
        });
        $A.enqueueAction(action);

    }

})