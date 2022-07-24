// function that splits a number into an array of it's values 36 returns [6, 30]

function splitIntoValues (n) {
    var values = [];
    let multiplyer = 1;

    while (n > 0) {
        let remainder = n % 10

        if (remainder > 0) {
            values.push(remainder * multiplyer)
        }
        n = Math.floor(n / 10)
        multiplyer = multiplyer * 10
    }
    return values;
}


// FreeCodeCamp - JavaScript Algorithms and Data Structures Projects: Roman Numeral Converter
//Converts Arabic => Roman Numerals accurate up to 3999

const arabic = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
const roman = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I'  ]

function convertToRoman(num) {
 let romanCollector = [];
 let arabicReducer;
 let arabicIndex;
    while (num > 0) {
        arabicReducer = arabic.find(y => y <= num);
        romanCollector.push(roman[arabic.indexOf(arabicReducer)]);
        num -= arabicReducer;
    }
 return romanCollector.reduce((a,b) => a + b)
}

convertToRoman(36);

//Free Code Camp - JavaScript Algorithms and Data Structures Projects: Telephone Number Validator
// I'm still concerned about it passing the format 1-(555)-555-5555  but it passed all the other tests.

function telephoneCheck(str) {
let phoneRegExp = /^(1*)(\s*-*)(\d{3}|\(\d{3}\))(\s*-*)(\d{3})(\s*-*)(\d{4})$/
  if (str.match(phoneRegExp)) {
    return true
  }
return false
}

telephoneCheck("1 (555)555-5555"); 
