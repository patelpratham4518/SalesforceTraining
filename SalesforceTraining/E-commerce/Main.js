const firebaseConfig = {
    apiKey: "AIzaSyAKg3uKpgU0lKGGKxFDUIobphfNoLIs-F0",
    authDomain: "training-19952.firebaseapp.com",
    databaseURL: "https://training-19952-default-rtdb.firebaseio.com",
    projectId: "training-19952",
    storageBucket: "training-19952.appspot.com",
    messagingSenderId: "837736914538",
    appId: "1:837736914538:web:20f15f72326439521ff413",
    measurementId: "G-JN8E2LBWJF"
  };


firebase.initializeApp(firebaseConfig)

let DB = firebase.database().ref("Ecommerce")

DB.on("value", function(snapshot) {
    let Data = snapshot.val()
    for (let key in Data) {
        let card = document.createElement("div")
        card.className = "wrapper"
        let img = document.createElement("img")
        img.src = Data[key]["image"]
        card.appendChild(img)
        return card
        
        
        let product = Data[key]
        let image = document.getElementById("image")
        let price = document.getElementById("product-price")
        let name = document.getElementById("product-name")
        image.src = product["image"].toString()
        price.innerText = "₹" + product["price"]
        name.innerText = product["productname"]


    }
 }, function (error) {
    console.log("Error: " + error.code);
 });

 