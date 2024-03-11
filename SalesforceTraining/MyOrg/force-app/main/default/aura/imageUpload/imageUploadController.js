({
    handleFilesChange : function(component, event, helper) {
        console.log("change");
        const file = event.target.files[0];

        // Encode the file using the FileReader API
        const reader = new FileReader();
        reader.onloadend = () => {
            // Use a regex to remove data url part
            const base64String = reader.result
                .replace('data:', '')
                .replace(/^.+,/, '');

            console.log("base64 = ",base64String);
            component.set("v.img64",base64String)
            // Logs wL2dvYWwgbW9yZ...
        };
        reader.readAsDataURL(file);

        component.set("v.imageReference",URL.createObjectURL(file))
        

    }
})
