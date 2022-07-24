// email validation

const msgObj = {
  requiredMessage: "This field is required",

  emailPatternMessage: "e-mail must match the pattern name@example.com",

  zipPatternMessage: "Zip Code may only include A-Z, 0-9, -, and space",
  zipMinimumMessage: "Zip Code should be atleast 4 characters",
  zipMaximumMessage: "Zip Code can not be longer than 5 numbers",

  passwordPatternMessage: "Password must include:\n- at least one ",
  passwordMinimumMessage: "Password should be at least 8 characters",
};

const email = document.querySelector("#email");
email.addEventListener("input", validate.bind(email, msgObj));

const zip = document.querySelector("#zip");
zip.addEventListener("input", validate.bind(zip, msgObj));

const password = document.querySelector("#password");
password.addEventListener("input", validate.bind(password, msgObj));

const confirmPassword = document.querySelector("#confirm_password");
confirmPassword.addEventListener(
  "input",
  validate.bind(confirmPassword, msgObj)
);

const form = document.querySelector("form");
form.addEventListener("submit", function (e) {
  e.preventDefault();
  let formData = new FormData(this);
  // console.log(formData);
  for (const formElement of formData) {
    console.log(formElement);
  }
  // do something with this data or submit to database.

  displaySuccessMessage();

  setTimeout(() => {
    form.reset();
    document.querySelector("button").blur();
    // form.blur();
    removeSuccessMessage();
  }, 3000);
});

function displaySuccessMessage() {
  let container = document.querySelector(".form-container");
  let msgContainer = document.createElement("div");
  msgContainer.id = "message-container";
  let msg = document.createElement("p");
  msg.textContent = "Thank you for submitting your information";
  msgContainer.appendChild(msg);

  container.prepend(msgContainer);
}

function removeSuccessMessage() {
  // let container = document.querySelector(".form-container");
  let msgContainer = document.querySelector("#message-container");
  msgContainer.remove();
}

function validate(obj) {
  // console.log(this, "kkuu");
  this.setCustomValidity("");
  removeAllMessages(this);
  if (this.id == "password") {
    console.log("bing");
    passwordValidate(this);
  }
  if (this.id == "confirm_password") {
    console.log("bang");
    confirmPasswordValidate(this);
  }
  let msg;
  if (this.validity.patternMismatch) {
    this.setCustomValidity(obj[`${this.id}PatternMessage`]);
    msg = this.validationMessage;
    displayCustomMessage(this, msg);
  }
  if (this.validity.tooShort) {
    console.log(this.validity);
    this.setCustomValidity(obj[`${this.id}MinimumMessage`]);
    msg = this.validationMessage;
    displayCustomMessage(this, msg);
  }
  if (this.validity.valueMissing) {
    this.setCustomValidity(obj["requiredMessage"]);
    msg = this.validationMessage;
    displayCustomMessage(this, msg);
  }
}

function passwordValidate(element) {
  let capital = /[A-Z]/;
  let lowerCase = /[a-z]/;
  let number = /[0-9]/;
  let special = /[*&!#$+=]/;
  let msg;
  if (!capital.test(element.value)) {
    msg = "Password must contain a capital letter";
    element.setCustomValidity(msg);
    displayCustomMessage(element, msg);
  }
  if (!lowerCase.test(element.value)) {
    msg = "Password must contain a lowercase letter";
    element.setCustomValidity(msg);
    displayCustomMessage(element, msg);
  }
  if (!number.test(element.value)) {
    msg = "Password must contain a number";
    element.setCustomValidity(msg);
    displayCustomMessage(element, msg);
  }
  if (!special.test(element.value)) {
    msg = "Password must contain a special character\n *, &, !, $, +, = or # ";
    element.setCustomValidity(msg);
    displayCustomMessage(element, msg);
  }
}

function confirmPasswordValidate(element) {
  let pass = document.querySelector("#password").value;
  let confirm = document.querySelector("#confirm_password").value;
  let msg = "Password's do not match";
  if (pass != confirm) {
    element.setCustomValidity(msg);
    console.log(element);
    displayCustomMessage(element, msg);
  }
}

function displayCustomMessage(element, msg) {
  let arr = [...element.parentElement.querySelectorAll("span")];
  // arr.forEach((itm) => console.log(itm.textContent));
  let bool = arr.some((ele) => {
    return ele.textContent === msg;
  });

  if (!bool) {
    let span = document.createElement("span");
    span.textContent = msg;
    span.classList.add("error-message");
    span.id = `${element.id}Message`;
    element.parentElement.appendChild(span);
  }
}

function removeAllMessages(element) {
  // console.log(element);
  let arr = [...element.parentElement.querySelectorAll("span")];
  while (arr.length > 0) {
    arr.forEach((ele) => ele.remove());
    arr = [...element.parentElement.querySelectorAll("span")];
  }
}
