const fn = (str) =>{
    let ans = ""
    for (i of str){
        ans += i
        if(i == " "){
            ans += "something"
            ans += " "
        }
    }
    return ans
}
const response = fn("Patel Pratham")
console.log(response)