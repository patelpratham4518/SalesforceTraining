({
    myAction : function(component, event, helper) {

    },

    previous : function(component, event, helper) {
        console.log("Previous Called");
        let showContact = component.get("v.showContact")
        let showEvent = component.get("v.showEvent")
        if (showContact == true) {
            component.set("v.showContact",false)
            component.set("v.showAccount",true)
            component.set("v.currentStep","step1")
        }else if (showEvent == true) {
            component.set("v.showEvent",false)
            component.set("v.showContact",true)
            component.set("v.currentStep","step2")
        }
        
    },

    next : function(component, event, helper) {
        console.log("Next Called");
        let showAccount = component.get("v.showAccount")
        let showContact = component.get("v.showContact")
        if (showAccount == true) {
          
            let accountGender = document.querySelector("#accountGender").value 
            let accountName = document.querySelector("#accountName").value
            let accountEmail = document.querySelector("#accountEmail").value
            let accountPhone = document.querySelector("#accountPhone").value
            let annualRevenue = document.querySelector("#annualRevenue").value
            // console.log(accountGender,accountName,accountPhone,accountEmail,annualRevenue);
            let action = component.get("c.createAccount")
            action.setParams({
                gender : accountGender,
                name : accountName,
                email : accountEmail,
                phone : accountPhone,
                revenue : annualRevenue
            })
            action.setCallback(this,function(response){
                let state = response.getState()
                if (state == "SUCCESS") {
                    component.set("v.accountId",response.getReturnValue())
                    component.set("v.showAccount",false)
                    component.set("v.showContact",true)
                    component.set("v.currentStep","step2")
                }
            })
            $A.enqueueAction(action)
            
           

        }else if (showContact == true) {
            let contactFirstName = document.querySelector("#contactFirstName").value 
            let contactLastName = document.querySelector("#contactLastName").value 
            let contactEmail = document.querySelector("#contactEmail").value 
            let contactPhone = document.querySelector("#contactPhone").value
            let accountId  = component.get("v.accountId")
            let action = component.get("c.createContact")
            action.setParams({
                firstName : contactFirstName,
                lastName : contactLastName,
                email : contactEmail,
                phone : contactPhone,
                accountId : accountId,
            })
            action.setCallback(this,function(response){
                let state = response.getState()
                if (state == "SUCCESS") {
                    component.set("v.contactId",response.getReturnValue())
                    component.set("v.showContact",false)
                    component.set("v.showEvent",true)
                    component.set("v.currentStep","step3")
                }
            })
            $A.enqueueAction(action)
            

        }
    },

    save : function(component, event, helper) {
        console.log("Save Called");

            let accountId  = component.get("v.accountId")
            let eventType = document.querySelector("#eventType").value 
            let action = component.get("c.createEvent")
            action.setParams({
                accountId : accountId,
                eventType : eventType
            })
            action.setCallback(this , function(response){
                let state = response.getState()
                if (state == "SUCCESS") {
                    alert("Event Created")
                    component.set("v.currentStep","step4")
                }
            })
            $A.enqueueAction(action)
        

    }
})
