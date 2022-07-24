import './style.css'
import { navagation } from './modules/navagation'
import { homepage } from './modules/homepage'
import { cusinepage } from './modules/cusine'
import { aboutpage } from './modules/about'

//Page Build From Modules

let content = document.createElement('div')
content.id = 'content'
document.querySelector('body').appendChild(content)

let nav = navagation()
content.appendChild(navagation(nav))

let home = homepage()
content.appendChild(homepage())

let cusine = cusinepage()
content.appendChild(cusinepage())

let about = aboutpage()
content.appendChild(aboutpage())

// Links and Event listeners

let homeLink = document.getElementById('homeLink')
let cusineLink = document.getElementById('cusineLink')
let aboutLink = document.getElementById('aboutLink')

home = document.getElementById('homepageWrapper')
cusine = document.getElementById('cusinepageWrapper')
about = document.getElementById('aboutpageWrapper')

function updateClasses(first, second, third) {
    first.classList.remove('hidden')
    first.classList.add('module-container')
    second.classList.add('hidden')
    second.classList.remove('module-container')
    third.classList.add('hidden')
    third.classList.remove('module-container')
}

homeLink.addEventListener('click', () => {
    updateClasses(home, cusine, about)
});

cusineLink.addEventListener('click', () => {
    updateClasses(cusine, about, home)
   
});

aboutLink.addEventListener('click', () => {
    updateClasses(about, home, cusine)
   
});