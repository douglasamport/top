import { createAndClass } from "./helper";
import copy from '../content/copy.json';

function homepage() {
    let container = createAndClass('div', ['module-container'], 'homepageWrapper')
    let center = createAndClass('div', 'center-container' )
    let textContainer = createAndClass('div', ['text-container'], 'hometextWrapper')

    let header = createAndClass('h1', ['hp-heading'])
    header.textContent = copy.homepageHeader

    let description = createAndClass('p', ['copy', 'outfit200'])
    description.textContent = copy.homepageCopy

    let resButton = createAndClass('button', ['button', 'homepageButton', 'outfit200'], 'reservationButton')
    resButton.textContent = "Réservation"

    textContainer.appendChild(header)
    textContainer.appendChild(description)

    center.appendChild(textContainer) 
    center.appendChild(resButton)

    container.appendChild(center)

    return container
}

export { homepage }