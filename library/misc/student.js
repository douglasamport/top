console.log('this is working')

function Student() {
}

Student.prototype.sayName = function() {
  console.log(this.name)
}

Student.prototype.happyBirthday = function() {
    console.log('Happy Birthday Sunshine!')
}

function EighthGrader(name) {
  this.name = name
  this.grade = 8
}

// don't do this!!!
EighthGrader.prototype = Object.create(Student.prototype)

function NinthGrader(name) {
  this.name = name
  this.grade = 9
}

// noooo! not again!
NinthGrader.prototype = Object.create(Student.prototype)

NinthGrader.prototype.sayName = function() {console.log("HAHAHAHAHAHA")}

const jim = new NinthGrader('Jim')
const carl = new EighthGrader("carl")

carl.sayName()
carl.happyBirthday()
jim.sayName()
carl.happyBirthday()

console.dir(carl);

const a = 'tuesday'

