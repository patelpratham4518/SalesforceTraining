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
  let position = "left"
    let Data = snapshot.val()
    for (let key in Data) {

      let product = Data[key]

        let wrapper = document.createElement("div")
        wrapper.className = "wrapper"
        wrapper.style.float = position
        if(position == "left"){
          wrapper.style.marginLeft = 50 + "px"
          position = "right"
          
        }
        else if(position == "right"){
          wrapper.style.marginRight = 50 + "px"
          position = "left"
        }

        let productImg = document.createElement("div")
        productImg.className = "product-img"
        let img = document.createElement("img")
        img.src =  product["image"]
        img.id = "image"
        img.height = 420
        img.width = 327
        productImg.appendChild(img)

        let productInfo = document.createElement("div")
        productInfo.className = "product-info"
        
        let productText= document.createElement("div")
        productText.className = "product-text"
        
        let h1 = document.createElement("h1")
        h1.id = "product-name"
        h1.innerText = product["productname"]
        productText.appendChild(h1)
        productInfo.appendChild(productText)
        
        let productpricebtn1= document.createElement("div")
        productpricebtn1.className = "product-price-btn"
        let view = document.createElement("button")
        view.type = "button"
        view.innerText = "View Product"
        // view.onclick = viewProduct
        view.onclick = function(){
          viewProduct(product["image"])
        }
        productpricebtn1.appendChild(view)
        productInfo.appendChild(productpricebtn1)
        
        let p = document.createElement("p")
        p.id="price"
        let span = document.createElement("span")
        span.id = "product-price"
        span.innerText = "₹" + product["price"]
        p.appendChild(span)
        productInfo.appendChild(p)

        let productpricebtn2= document.createElement("div")
        productpricebtn2.className = "product-price-btn"
        let addCart = document.createElement("button")
        addCart.type = "button"
        addCart.innerText = "Add to cart"
        // addCart.onclick = addToCart
        addCart.onclick = function(){addToCart(product)}
        
        productpricebtn2.appendChild(addCart)
        productInfo.appendChild(productpricebtn2)
        


        
        wrapper.appendChild(productImg)
        wrapper.appendChild(productInfo)
        document.body.appendChild(wrapper)
        
          
  
        // let image = document.getElementById("image")
        // let price = document.getElementById("product-price")
        // let name = document.getElementById("product-name")
        // image.src = product["image"].toString()
        // price.innerText = "₹" + product["price"]
        // name.innerText = product["productname"]


    }
 }, function (error) {
    console.log("Error: " + error.code);
 });

 function viewProduct(img){
    img.width = 100 + "%"
    console.log(img)
    return img
 }

 document.getElementById("count").innerText = sessionStorage.getItem("counter")
 let counter = Number(document.getElementById("count").innerText)

//  let cart = sessionStorage.getItem("cart")
 let cart = []

 function addToCart(product){
    counter += 1
    document.getElementById("count").innerText = counter
    // alert("Item Added to Cart")
    let item = [ product["productname"], product["price"]]
    cart.push(item)
    sessionStorage.setItem("counter",counter)
    sessionStorage.setItem("cart",cart)
    console.log(cart)
  }
  
  function openCart(){
    window.location.href = "Cart.html"
 }

 
 