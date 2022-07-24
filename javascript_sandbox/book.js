"use strict";

var subContainer = document.getElementById('submissionFormContainer')

var myLibrary = new Library();

function Library(catalog = []) {
    function buildCardContainer(index) {
        
    }

    this.catalog = catalog

    this.displayLibraryToPage = function () {  //break this into smaller functions
        this.catalog.forEach((obj, idx) => {
            let div = document.createElement('div')
            div.classList.add('card')
            div.id = `card${idx}`
            let head = document.createElement('h6')
            head.innerHTML = '---------------'
            div.appendChild(head)
            
            for (let [key, value] of Object.entries(obj)) {
                if (key == 'position') { continue; }
                let para = document.createElement('p')
                para.innerHTML = `${key}: ${value}`
                div.appendChild(para)
            }

            let deleteButton = document.createElement('button')
            deleteButton.innerHTML = 'delete'
            deleteButton.onclick = function () {
                let card = document.getElementById(`card${idx}`)
                let parent = card.parentNode
                console.log(card.id);
                test();
                catalog.splice(idx, 1)
                console.log(catalog)
                parent.removeChild(card);
            }
            div.appendChild(deleteButton)
            let displayLib = document.getElementById('library');
            displayLib.appendChild(div);
        });
    }

    this.clearDocument = function () {
        let displayLib = document.getElementById('library');
        while (displayLib.hasChildNodes()) {
            displayLib.removeChild(displayLib.firstChild);
        }
    }

    this.addBookToLibrary = function (title, author, pages, read) {
        let book = new Book(title, author, pages, read)
        book.position = this.catalog.length
        this.catalog.push(book)
    }

    this.removeBookFromLibrary = function () {
        console.log(this.catalog)
    }

}

function deleteCurrentCard(idx) {

}

function Book(title, author, pages, status) {
    this.title = title;
    this.author = author;
    this.pages = pages;
    this.status = status;
}

Book.prototype.info = function () {
    return `${this.title} by ${this.author}, ${this.pages} pages, ${this.read}`
}



myLibrary.addBookToLibrary('The Hobbit', 'J.R.R. Tolkin', 295, 'read')
myLibrary.addBookToLibrary('Hunger Games', 'Suzanne Collins', 374, 'un-read')
myLibrary.addBookToLibrary('Catcher in the Rye', 'J.D Salinger', 277, 'un-read')

myLibrary.displayLibraryToPage()

function formDataUpdate() {
    let inputTitle = document.getElementsByName('title')[0].value;

}
let sendButton = document.getElementById('sendFormButton');
sendButton.addEventListener('click', pageUpdate);

function pageUpdate(params) {
    let formTitle = document.getElementsByName('title')[0].value;
    let formAuthor = document.getElementsByName('authors')[0].value;
    let formPages = document.getElementsByName('pages')[0].value;
    let formStatus = document.getElementById('readStatus').value;
    console.log(`${formTitle}, ${formAuthor}, ${formPages} ${formStatus}`)
    myLibrary.addBookToLibrary(formTitle, formAuthor, formPages, formStatus)
    myLibrary.clearDocument()
    myLibrary.displayLibraryToPage()
}


let addBookButton = document.getElementById('addBookButton');
addBookButton.addEventListener('click', toggleFormContainer);

function toggleFormContainer() {
    if (subContainer.style.display === 'none') {
        console.log('tuesday')
        subContainer.style.display = 'block'
        addBookButton.innerHTML = 'Hide'
    } else {
        subContainer.style.display = 'none'
        addBookButton.innerHTML = 'Add Book'
    }
}

//get values from form
//check values from form
//add values to new Book
//redisplay Library page


