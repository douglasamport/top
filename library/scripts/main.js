"use strict";

function storageAvailable(type) {
  var storage;
  var x = "__storage_test__";
  try {
    storage = window[type];
    storage.setItem(x, x);
    storage.removeItem(x);
    return true;
  } catch (e) {
    return (
      e instanceof DOMException &&
      // everything except Firefox
      (e.code === 22 ||
        // Firefox
        e.code === 1014 ||
        // test name field too, because code might not be present
        // everything except Firefox
        e.name === "QuotaExceededError" ||
        // Firefox
        e.name === "NS_ERROR_DOM_QUOTA_REACHED") &&
      // acknowledge QuotaExceededError only if there"s something already stored
      storage &&
      storage.length !== 0
    );
  }
}

function checkStorageAvailable(type) {
  //the type variable in this instance is either localStorage or sessionStorage as we are accessing the browser storage.
  if (storageAvailable(type)) {
    console.log(`${type} available`);
  } else {
    console.log(`${type} not available`);
  }
}

checkStorageAvailable("localStorage");

let defaultLibrary = [
  {
    title: "The Hobbit",
    bookAuthor: "J.R.R. Tolkin",
    pages: 295,
    status: "read",
  },
  {
    title: "Hunger Games",
    bookAuthor: "Suzanne Collins",
    pages: 374,
    status: "un-read",
  },
  {
    title: "Catcher in the Rye",
    bookAuthor: "J.D Salinger",
    pages: 277,
    status: "un-read",
  },
];

function importFromLocalStorage(string) {
  // check if local storage has already been accessed.
  //if it is than we create a new Library and populate it with the Json object.
  // otherwise we populate it with the default value and then
  return localStorage.getItem(string)
    ? applyStorageValues(string)
    : createStorageValues();
}

function applyStorageValues(string) {
  //make new library
  var myLibrary = new Library();
  //import catalog from local storage
  var storedCatalog = localStorage.getItem(string);
  //Parse JSON string into javascript object
  var parcedCatalog = JSON.parse(storedCatalog);
  //add catalog element to new Library
  myLibrary.catalog = parcedCatalog;
  //populate html with stored catalog info
  myLibrary.displayLibraryToPage();
  return myLibrary;
}

function createStorageValues(string) {
  //if local storage is empty set catalog to empty array
  localStorage.setItem(string, JSON.stringify(defaultLibrary));
  //create new library and populate it with the newly created object
  return applyStorageValues(string);
}

const myLibrary = importFromLocalStorage("catalog");

function validateForm() {
  let inputArr = document.querySelectorAll("input");
  return [...inputArr].every((element) => {
    return element.checkValidity() === true;
  });
}

function submitClick(e) {
  let msg = document.querySelector("span");
  if (validateForm()) {
    let formNode = document.getElementById("newBookForm");
    myLibrary.pageUpdate(formNode);
    msg.style.display = "none";
  } else {
    e.preventDefault();
    msg.style.display = "inline";
    console.log("false");
  }
}

submit.addEventListener("click", submitClick);

const addBookButton = document.getElementById("addBookButton");
addBookButton.addEventListener("click", function () {
  let subContainer = document.getElementById("submissionFormContainer");
  function toggleHide() {
    return subContainer.style.visibility === "hidden"
      ? ["visible", "fit-content", "Hide Form"]
      : ["hidden", "0px", "Add Book"];
  }
  let arr = toggleHide();
  subContainer.style.visibility = arr[0];
  subContainer.style.height = arr[1];
  addBookButton.innerHTML = arr[2];
});
