({
    myAction : function(component, event, helper) {

    },
    ondrop : function(component , event , helper) {

            console.log("Drop called");
            let contactId = component.get("v.contactIdChange")
            // console.log("contactId  from parent controler = ",contactId);
            let accountIdSection1 = component.get("v.accountIdSection1")
            let accountIdSection2 = component.get("v.accountIdSection2")
            // console.log("accountIdSection1 = ",accountIdSection1);
            // console.log("accountIdSection2 = ",accountIdSection2);
            let currentSection = component.get("v.currentSection")
            // console.log("currentSection from parent = ",currentSection);
            
            let accountChangeId;
            if (currentSection == "section1") {
                accountChangeId = accountIdSection2
            } else if(currentSection == "section2") {
                accountChangeId = accountIdSection1
            }
            // console.log(`apex params contactId = ${contactId} , accountChange = ${accountChangeId}`);
            



            let action = component.get("c.changeAccount")
            action.setParams({
                contactId : contactId,
                accountId : accountChangeId
            })
            action.setCallback(this,function(response){
                let state = response.getState();
                if(state == "SUCCESS"){
                    console.log("hurrey!!!");
                    alert("Contact's Account Changed!!!")

                    let child1 = component.find("child1")
                    let child2 = component.find("child2")
                    child1.refresh(component,event,helper)
                    child2.refresh(component,event,helper)
                }
            })
            $A.enqueueAction(action)
    },

    ondragover : function(component , event , helper){
        event.preventDefault();
    }

    
    
})