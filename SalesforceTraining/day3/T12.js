const factor = (num) =>{
    let factors = []
    for(let i=1; i<=num ;i++){
        if(num%i == 0){
            factors.push(i)
            
        }
        
    }
    return factors
}
const input = 20
console.log(factor(input))