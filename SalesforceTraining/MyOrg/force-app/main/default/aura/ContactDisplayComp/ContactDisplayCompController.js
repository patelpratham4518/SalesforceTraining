({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAllContacts");
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state == "SUCCESS") {
                component.set("v.relatedContactList",response.getReturnValue());
                component.set("v.totalSize",component.get("v.relatedContactList").length);
                component.set("v.start",0);
                component.set("v.end",component.get("v.pageSize")-1);
                var setPagination = component.get("c.setPaginationlist");
                $A.enqueueAction(setPagination);
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

                if (response.getReturnValue() != null) {
                    component.set("v.totalSize",component.get("v.relatedContactList").length);
                    component.set("v.start",0);
                    component.set("v.end",component.get("v.pageSize")-1);
                }
                var setPagination = component.get("c.setPaginationlist");
                $A.enqueueAction(setPagination);
            }
            else{
                
            }
        });
        $A.enqueueAction(action);

    },
    first : function (component, event , helper) {
        var pageSize = component.get("v.pageSize");

        component.set("v.start",0);
        component.set("v.end",pageSize-1);
        var action = component.get("c.setPaginationlist");
        $A.enqueueAction(action);
    },
    previous : function (component, event , helper) {
        
        var pageSize = component.get("v.pageSize");
        var totalSize = component.get("v.totalSize");
        var start = component.get("v.start");
        var end = component.get("v.end");
       

        start-=pageSize;
        end -= pageSize;

        if (start>=0) {
            component.set("v.start",start);
            component.set("v.end",end);
            var action = component.get("c.setPaginationlist");
            $A.enqueueAction(action);
        }

    },
    next : function (component, event , helper) {
        
        var pageSize = component.get("v.pageSize");
        var totalSize = component.get("v.totalSize");
        var start = component.get("v.start");
        var end = component.get("v.end");

        start+=pageSize;
        end += pageSize;
        if (start<=(totalSize-1)) {     
            component.set("v.start",start);
            component.set("v.end",end);
            var action = component.get("c.setPaginationlist");
            $A.enqueueAction(action);
        }
      
    },
    last : function (component, event , helper) {
        var totalSize = component.get("v.totalSize");
        var pageSize = component.get("v.pageSize");
        var start = totalSize - (totalSize%pageSize);
        var end = start + pageSize-1;
        component.set("v.start",start);
        component.set("v.end",end);
        console.log("JSK");
        var action = component.get("c.setPaginationlist");
        $A.enqueueAction(action);
    },
    setPaginationlist : function (component , event , helper){
        console.log("Pagination called");
        var relatedContactList = component.get("v.relatedContactList");
        if (relatedContactList == null) {
            component.set("v.paginationList",[]);
            component.set("v.totalSize",0);
            component.set("v.start",0);
            component.set("v.end",0);
            
        }
        else
        {

            var start = component.get("v.start");
            var end = component.get("v.end");
            var totalSize = component.get("v.totalSize");
            var pageSize = component.get("v.pageSize");
            var pageCount = Math.floor(start/pageSize)+1;

            var paginationList = [];
            for (let index = start; index <= end; index++) {
                paginationList.push(relatedContactList[index]);
            }
            component.set("v.paginationList",paginationList);
            component.set("v.pageCount",pageCount);
            
        }

    }
})
