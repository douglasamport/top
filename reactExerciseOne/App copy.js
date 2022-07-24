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
      isEditing: { bool: false, element: "" },
    };
    this.addTaskToArray = this.addTaskToArray.bind(this);
    this.handleValueChange = this.handleValueChange.bind(this);
    this.removeValueFromArray = this.removeValueFromArray.bind(this);
    this.makeMutable = this.makeMutable.bind(this);
    this.makeUnmutable = this.makeUnmutable.bind(this);
  }

  makeMutable(elementId) {
    this.setState({ isEditing: { bool: true, element: elementId } });
  }

  makeUnmutable(elementId, newValue) {
    let newArray = this.state.array.map((item) => {
      return item.id === elementId ? { text: newValue, id: item.id } : item;
    });
    this.setState({ array: newArray, isEditing: { bool: false, element: "" } });
  }

  addTaskToArray() {
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
          makeMutable={this.makeMutable}
          makeUnmutable={this.makeUnmutable}
        />
        <Form
          value={this.state.task.text}
          handleValueChange={this.handleValueChange}
          addTaskToArray={this.addTaskToArray}
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
    this.props.addTaskToArray();
    this.props.handleValueChange("", "");
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
    this.editElement = this.editElement.bind(this);
    this.updateElement = this.updateElement.bind(this);
  }

  removeElement(e) {
    let elementId = e.target.parentElement.getAttribute("data-key");
    this.props.removeValueFromArray(elementId);
  }

  editElement(e) {
    let elementId = e.target.parentElement.getAttribute("data-key");
    this.props.makeMutable(elementId);
  }

  updateElement(e) {
    let elementId = e.target.parentElement.getAttribute("data-key");
    let newValue = e.target.previousElementSibling.value;
    this.props.makeUnmutable(elementId, newValue);
  }

  displayArray() {
    let { bool, value } = this.props.isEditing;
    let arr = this.props.array;
    let listArray;

    if (bool) {
      listArray = arr.map((item, index) => {
        if (item.id !== value) {
          return (
            <li key={item.id} data-key={`${item.id}`}>
              {index + 1}. {item.text}
              <button onClick={this.editElement}>edit</button>
              <button onClick={this.removeElement}>delete</button>
            </li>
          );
        } else {
          return (
            <li key={item.id} data-key={`${item.id}`}>
              {index + 1}. <input type="text"></input>
              <button onClick={this.updateElement}>done</button>
              <button onClick={this.removeElement}>delete</button>
            </li>
          );
        }
      });
    } else {
      listArray = arr.map((item, index) => {
        return (
          <li key={item.id} data-key={`${item.id}`}>
            {index + 1}. {item.text}
            <button onClick={this.editElement}>edit</button>
            <button onClick={this.removeElement}>delete</button>
          </li>
        );
      });
    }

    return listArray;
  }

  render() {
    return <ul>{this.displayArray()}</ul>;
  }
}
export default App;
