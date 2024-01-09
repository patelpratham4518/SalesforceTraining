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

function insert(){
    const image = document.getElementById("image").value
    const productname = document.getElementById("productname").value
    const price =document.getElementById("price").value
    
    

    let newProduct = DB.push()
    newProduct.set({
        image : image,
        productname : productname,
        price : price
    })
    alert("Product Uploaded")
    location.reload()
}



