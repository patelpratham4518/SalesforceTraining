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
    // console.log(snapshot.val());
    let Data = snapshot.val()
    for (let key in Data) {
        console.log(Data[key]);
        let product = Data[key]
        // document.getElementById("image").src = 
        let table = document.getElementById("myTable")
        let row = table.insertRow(-1)

        let c1 = row.insertCell(0);
        let c2 = row.insertCell(1);
        let c3 = row.insertCell(2);

        c1.innerHTML = "New Cell"
        let img = document.createElement('img')
        img.src = product["image"]
        c1.appendChild(img)
        c2.innerText = product["productname"]
        c3.innerText = product["price"]
        
    }
 }, function (error) {
    console.log("Error: " + error.code);
 });

 