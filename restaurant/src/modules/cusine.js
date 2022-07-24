import { createAndClass } from "./helper";
import copy from '../content/copy.json'

function cusinepage() {
    let container = createAndClass('div', ['hidden'], 'cusinepageWrapper')
    let center = createAndClass('div', 'center-container', 'centerWrapper' )
    let textContainer = createAndClass('div', ['text-container'], 'cusinetextWrapper')

    //create content

    let header = createAndClass('h1', ['cusine-heading'])
    header.textContent = copy.cusinepageHeader

    let menuOne = createAndClass('h2', ['cusine-subheading'])
    menuOne.textContent = copy.menuOne_header
    let menuOneDesc = createAndClass('p', ['copy', 'outfit200'])
    menuOneDesc.textContent = copy.menuOne_description

    let menuTwo = createAndClass('h2', ['cusine-subheading'])
    menuTwo.textContent = copy.menuTwo_header
    let menuTwoDesc = createAndClass('p', ['copy', 'outfit200'])
    menuTwoDesc.textContent = copy.menuTwo_description
    
    let menuThree = createAndClass('h2', ['cusine-subheading'])
    menuThree.textContent = copy.menuThree_header
    let menuThreeDesc = createAndClass('p', ['copy', 'outfit200'])
    menuThreeDesc.textContent = copy.menuThree_description

    //append content to page
    
    center.appendChild(header)

    textContainer.appendChild(menuOne)
    textContainer.appendChild(menuOneDesc)

    textContainer.appendChild(menuTwo)
    textContainer.appendChild(menuTwoDesc)

    textContainer.appendChild(menuThree)
    textContainer.appendChild(menuThreeDesc)

    center.appendChild(textContainer)
    container.appendChild(center)

    return container
}

export { cusinepage }