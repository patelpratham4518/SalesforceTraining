// For Firebase JS SDK v7.20.0 and later, measurementId is optional
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

let DB = firebase.database().ref("contactForm")

document.getElementById("form").addEventListener("submit",submitForm)

function submitForm(e){
    e.preventDefault()
    const firstName = document.getElementById("firstname").value
    const lastName = document.getElementById("lastname").value
    const email = document.getElementById("email").value
    const password = document.getElementById("password").value
    console.log(firstName,lastName,email,password)
    let newForm = DB.push()
    newForm.set({
        firstname : firstName,
        lastname : lastName,
        email : email,
        password : password
    })
}


DB.on("value", function(snapshot) {
   console.log(snapshot.val());
}, function (error) {
   console.log("Error: " + error.code);
});