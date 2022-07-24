import { createAndClass } from "./helper";
import copy from '../content/copy.json'

function aboutpage() {
    let container = createAndClass('div', ['hidden'], 'aboutpageWrapper')
    let center = createAndClass('div', 'center-container' )
    let textContainer = createAndClass('div', ['text-container'], 'abouttextWrapper')

    let header = createAndClass('h1', ['about-heading', 'outfit200'])
    header.textContent = copy.aboutpageHeader

    let description = createAndClass('p', ['copy', 'outfit200'])
    description.textContent = copy.aboutpageCopy

    
    textContainer.appendChild(header)
    textContainer.appendChild(description)
    center.appendChild(textContainer)
    container.appendChild(center)

    return container
}

export { aboutpage }