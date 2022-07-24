function createAndClass(type='div', cls=null, id=null) { 
    let element = document.createElement(type)
    if (typeof cls == 'string') {
        element.classList.add(cls)
    }
    if (Array.isArray(cls)) {
        cls.forEach(itm => element.classList.add(itm))
    }
    if (typeof id == 'string') {
        element.id = id
    }
    return element
}

export { createAndClass }