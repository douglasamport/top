
let mainDivWidth = 40;
const slider = document.querySelector('#slider-range');
let dimension = slider.value;
let divQty = Math.pow(dimension, 2);
let bkgrndColor = '';

const containerDiv = document.querySelector('#container');
makeGrid(divQty, containerDiv);

//color change greyscale
const buttonGrey = document.querySelector('#greyscale');
buttonGrey.onclick = function () {
  bkgrndColor = 'black';
  let innerDivs = document.querySelectorAll('.inner-div');
  changeGreyOnHover(innerDivs);
};

function changeGreyOnHover(arr) {
  for (let i = 0; i < arr.length; i++) {
    arr[i].removeEventListener("mouseover", removeOpacity);
    arr[i].addEventListener("mouseover", greyOpacity);
  }
}

function greyOpacity() {
  this.style.backgroundColor = `${bkgrndColor}`;
  if (this.style.opacity) {
    if (this.style.opacity >= 1) {
      this.style.opacity = 1;
    }
    else {
      let origLvl = this.style.opacity;
      let newLvl = Number(origLvl) + 0.1;
      this.style.opacity = `${newLvl}`;
    }
  }
  else { this.style.opacity = '0.1'; }
}

//color Change Rainbow
const buttonRandom = document.querySelector('#random');

buttonRandom.onclick = function () {
  let innerDivs = document.querySelectorAll('.inner-div');
  changeRainbowOnHover(innerDivs);
};

function changeRainbowOnHover(arr) {
  for (let i = 0; i < arr.length; i++) {
    arr[i].removeEventListener("mouseover", greyOpacity);
    arr[i].addEventListener("mouseover", removeOpacity);
    arr[i].addEventListener("mouseover", function () {
      let color = '#' + Math.floor(Math.random() * 16777215).toString(16);
      this.style.backgroundColor = `${color}`;
    });
  }
}

//color change Blue
const buttonBlue = document.querySelector('#blue');

buttonBlue.onclick = function () {
  bkgrndColor = 'blue';
  let innerDivs = document.querySelectorAll('.inner-div');
  changeBkgrndOnHover(innerDivs, bkgrndColor);
};

//color change Red
const buttonRed = document.querySelector('#red');

buttonRed.onclick = function () {
  bkgrndColor = 'red';
  let innerDivs = document.querySelectorAll('.inner-div');
  changeBkgrndOnHover(innerDivs, bkgrndColor);
};

//adjust grid size with slider
slider.addEventListener("click", sliderSetGrid);

function sliderSetGrid() {
  bkgrndColor = '';
  dimension = slider.value;
  console.log(dimension);
  divQty = Math.pow(dimension, 2);
  removeGrid(containerDiv);
  makeGrid(divQty, containerDiv);
  let innerDivs = document.querySelectorAll('.inner-div');
  changeBkgrndOnHover(innerDivs, bkgrndColor);
}

//clear/reset button for clearing grid
const buttonClear = document.querySelector('#reset');

buttonClear.onclick = function () {
  divQty = Math.pow(dimension, 2);
  removeGrid(containerDiv);
  makeGrid(divQty, containerDiv);
  let innerDivs = document.querySelectorAll('.inner-div');
  bkgrndColor = '';
  changeBkgrndOnHover(innerDivs, bkgrndColor);
};

function changeBkgrndOnHover(arr, color) {
  for (let i = 0; i < arr.length; i++) {
    arr[i].removeEventListener("mouseover", greyOpacity);
    arr[i].addEventListener("mouseover", removeOpacity);
    arr[i].addEventListener("mouseover", function () {
      this.style.backgroundColor = `${color}`;
    });
  }
}

function removeOpacity() {
  this.style.removeProperty("opacity");
}

function makeGrid(qty, parent) {
  for (let i = 0; i < qty; i++) {
    let newDiv = document.createElement('div');
    newDiv.style.height = `calc(${mainDivWidth}vw/${dimension})`;
    newDiv.style.width = `calc(${mainDivWidth}vw/${dimension})`;
    newDiv.classList.add('grid-default');
    newDiv.classList.add('inner-div');
    parent.appendChild(newDiv);
  }
}

function removeGrid(parent) {
  while (parent.firstChild) {
    parent.removeChild(parent.firstChild);
  }
}