({
    doInit : function(component, event, helper) {
        console.log("Init called");
        let action = component.get("c.getAccountWrappers")
        action.setCallback(this,function(response){
            let state = response.getState()
            if (state === "SUCCESS") {
                component.set("v.wrapperList",response.getReturnValue())
                console.log("WrapperList",response.getReturnValue());
            }
            else{
                console.log("failed");
            }
        })
        $A.enqueueAction(action)
    }
})
