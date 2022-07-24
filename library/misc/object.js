const Student = function(name, grade) {
    this.name = name;
    this.grade = grade;
}

const oliver = new Student("oliver", 7)
const susan = new Student("susan", 8)

Student.prototype.introduce = function() {
    console.log(this.name);
}

function shout(compliment) {
    console.log(`my name is ${this.name} and I am ${compliment}`)
}

//oliver.introduce()

let ollyShout = shout.bind(oliver)

shout('stupid');
ollyShout('smart')
shout.call(susan, 'awesome');

Object.create(Student.prototype)