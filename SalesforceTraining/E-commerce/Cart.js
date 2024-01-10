let counter = sessionStorage.getItem("counter")
let cartData = sessionStorage.getItem("cart").split(",")
document.getElementById("count").innerText = counter

console.log(cartData.length)
console.log(cartData)

let total = Number(document.getElementById("total").innerText)
for(let i=1; i <= (cartData.length)/2 ; i+=2){
    let table = document.getElementById("cart")
    let row = table.insertRow(-1)
    let productname = row.insertCell(0)
    let price = row.insertCell(1)
    productname.innerText = cartData[i+1]
    price.innerText = cartData[i]
    total += Number(price.innerText)
    document.getElementById("total").innerText = total   
}
