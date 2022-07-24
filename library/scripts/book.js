// "use strict";

class Book {
  constructor(obj) {
    for (let [key, value] of Object.entries(obj)) this[key] = value;
  }

  info() {
    return `${this.title} by ${this.author}, ${this.pages} pages, ${this.read}`;
  }
}
