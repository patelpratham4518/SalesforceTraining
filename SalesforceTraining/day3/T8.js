const vowelCount = (str) =>{
    let count = 0
    const vowels = ["A","E","I","O","U","a","e","i","o","u"]
    for(i of vowels){
        for(x of str){
            if(x == i){
                count +=1
            }
        }
    }
    return count
}
const str = "trainee"
const numOfVowels = vowelCount(str)
console.log(numOfVowels)