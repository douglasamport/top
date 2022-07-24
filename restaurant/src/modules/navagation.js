import{ createAndClass } from './helper'

function navagation() {
   
    let links = [['Accueil', 'homeLink'], ['Cuisine', 'cusineLink'], ['Qui nous sommes', 'aboutLink']] // info for links - ['copy', 'id']
    
    let header = createAndClass('div', 'nav-container')
    let linksContainer = createAndClass('div', 'link-container' )
    let ul = createAndClass('ul', ['nav-links', 'flex-row'])

    createAndAppendLi(ul, links)
    linksContainer.appendChild(ul)
    header.appendChild(linksContainer)

    return header
}

function createAndAppendLi(parent, items){
    items.forEach( (itm) => {
        let li = document.createElement('li')
        li.textContent = itm[0]
        li.id = itm[1]
        li.classList.add('link', 'navLink', 'outfit200')
        parent.appendChild(li)
    })
}

export { navagation }