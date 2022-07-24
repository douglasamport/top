import { Component } from "react";
import "./App.css";
import uniqid from "uniqid";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      task: { text: "", id: "" },
      array: [
        { text: "One", id: uniqid() },
        { text: "Two", id: uniqid() },
        { text: "Three", id: uniqid() },
      ],
      isEditing: { bool: false, value: "" },
    };
    this.addValueToState = this.addValueToState.bind(this);
    this.handleValueChange = this.handleValueChange.bind(this);
    this.removeValueFromArray = this.removeValueFromArray.bind(this);
  }

  addValueToState() {
    this.setState((s) => ({ array: s.array.concat(s.task) }));
  }

  removeValueFromArray(val) {
    let newArray = this.state.array.filter((obj) => obj.id !== val);
    this.setState({ array: newArray });
  }

  handleValueChange(val, idv = uniqid()) {
    this.setState({ task: { text: val, id: idv } });
    // setTimeout(() => {
    //   console.log(this.state.task.text);
    // }, 0);
  }

  render() {
    return (
      <div>
        <Display
          isEditing={this.state.isEditing}
          array={this.state.array}
          removeValueFromArray={this.removeValueFromArray}
        />
        <Form
          // isEditing={this.state.isEditing}
          value={this.state.task.text}
          handleValueChange={this.handleValueChange}
          addValueToState={this.addValueToState}
        />
      </div>
    );
  }
}

class Form extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    this.props.handleValueChange(e.target.value);
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.addValueToState();
    this.props.handleValueChange("", "");
  }

  updateText() {
    console.log(this.props.text);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Input:
          <input
            type="text"
            value={this.props.value}
            onChange={this.handleChange}
          />
        </label>
        <input type="submit" />
      </form>
    );
  }
}

class Display extends Component {
  constructor(props) {
    super(props);
    this.removeElement = this.removeElement.bind(this);
  }

  removeElement(e) {
    let val = e.target.parentElement.getAttribute("data-key");
    this.props.removeValueFromArray(val);
  }

  editElement(e) {
    let val = e.target.parentElement.getAttribute("data-key");
    // this.props.
  }

  displayArray() {
    let arr = this.props.array;
    let listArray = arr.map((item, index) => {
      return (
        <li key={item.id} data-key={`${item.id}`}>
          {index + 1}. {item.text}
          <button onClick={this.editElement}>edit</button>
          <button onClick={this.removeElement}>delete</button>
        </li>
      );
    });
    return listArray;
  }

  render() {
    return <ul>{this.displayArray()}</ul>;
  }
}
export default App;
