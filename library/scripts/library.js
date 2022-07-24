"use strict";

class Library {
    constructor(catalog = []) {
        this.catalog = catalog
    }

    getFormData(arr, obj = {}) {
        arr.forEach((name) => {
            obj[name] = document.getElementsByName(name)[0].value;
            document.getElementsByName(name)[0].value = "";
        });
        return obj;
    };

    getFormNames(formNode) {
        let arrNodes = [...formNode.childNodes].filter(node => node.nodeName == "INPUT");
        return arrNodes.map((node) => { return node.name; });
    };

    pageUpdate = (formNode) =>  {
        let formNames = this.getFormNames(formNode);        
        let obj = this.getFormData(formNames);
        this.addBookToLibrary(obj);
        this.clearDocument();
        this.displayLibraryToPage();
    };


    createDiv(idx, string)  {
        let div = document.createElement("div");
        div.classList.add(`${string}`);
        div.id = `${string}${idx}`;
        return div;
    };

    buildDeleteButton = (idx) =>  {
        let deleteButton = document.createElement("button");
        deleteButton.classList.add("deleteButton");
        deleteButton.innerHTML = "X";
        deleteButton.onclick = () => {
            let card = document.getElementById(`card${idx}`);
            let parent = card.parentNode;
            parent.removeChild(card);
            this.catalog.splice(idx, 1);
            this.updateMemory("catalog");
            this.clearDocument();
            this.displayLibraryToPage();
        };
        return deleteButton;
    };

    buildReadToggleButton = (idx, div) => {
        let toggleReadButton = document.createElement("button");
        toggleReadButton.classList.add("toggleReadButton");
        
        toggleReadButton.innerHTML = this.statusNodeToggle(div);
        toggleReadButton.onclick = ()  => {
            let card = document.getElementById(`card${idx}`);
            let string = this.statusNodeToggle(card);
            let statusNode = [...card.childNodes].find(node => node.classList.contains("p_status"));
            statusNode.innerHTML = `status: ${string}`;
            this.catalog[idx].status = string;
            this.updateMemory("catalog");
            toggleReadButton.innerHTML = this.nameToggle(string);
        };
        return toggleReadButton;
    };

    nameToggle = function(string) {
        return string ==="read" ? "un-read" : "read";
    };

    statusNodeToggle = function(node) { 
        let string = [...node.childNodes].find(node => node.classList.contains("p_status")).innerHTML.slice(8);
        return string ==="read" ? "un-read" : "read";
    };

    displayLibraryToPage = () => {  //builds div and child elements for each object in the catalog array.
        var displayLib = document.getElementById("library");
        this.catalog.forEach((obj, idx) => {
            let div = this.createDiv(idx, "card");

            for (let [key, value] of Object.entries(obj)) {
                if (key == "position") { continue; }
                if (key == "bookAuthor") { key = "author"; }
                let para = document.createElement("p");
                para.classList.add(`p_${key}`);
                para.innerHTML = `${key}: ${value}`;
                div.appendChild(para);
            }
            let twoButtonContainer = this.createDiv(idx, "twoButtonContainer");
            
            let toggleReadButton = this.buildReadToggleButton(idx, div);
            twoButtonContainer.appendChild(toggleReadButton);
            
            let deleteButton = this.buildDeleteButton(idx);
            twoButtonContainer.appendChild(deleteButton);

            div.appendChild(twoButtonContainer);
            displayLib.appendChild(div);
        });
    };

    clearDocument = function () {
        let displayLib = document.getElementById("library");
        while (displayLib.hasChildNodes()) {
            displayLib.removeChild(displayLib.firstChild);
        }
    };

    addBookToLibrary = (title, author, pages, read) => {
        let book = new Book(title, author, pages, read);
        book.position = this.catalog.length;
        this.catalog.push(book);
        this.updateMemory("catalog");
    };

    updateMemory = (string) => {
        let stringCatalog = JSON.stringify(this.catalog);
        localStorage.setItem(string, stringCatalog);
        console.log("Local Storage Updated");
    };
}

