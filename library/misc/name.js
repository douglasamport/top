let user = {
    name: "John",
    surname: "Smith",
  
    set fullName(value) {
      [this.name, this.surname] = value.split(" ");
    },
  
    get fullName() {
      return `${this.name} ${this.surname}`;
    }
  };
  
  let admin = {
    __proto__: user,
    isAdmin: true
  };
  
  console.log(admin.name, admin.surname)
  
  // setter triggers!
  admin.fullName = "Alice Cooper"; // (**)

  console.log(admin.name, admin.surname)
  
  //alert(admin.fullName); // Alice Cooper, state of admin modified
  //alert(user.fullName); // John Smith, state of user protectedn