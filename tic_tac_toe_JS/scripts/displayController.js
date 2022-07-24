"use strict";

const displayController = (function() {
    
    const display = (arr) => {
        let rows = document.getElementById('rows');
        [...rows.children].forEach((child, idx)=> 
        child.innerHTML = arr[idx]
        )
    };
    
    const resizeText = function() {
        let cells = document.getElementsByClassName('cell');
        let height = cells[0].offsetHeight;
        [...cells].forEach(cell=> cell.style.fontSize = `${height * .8}px`)
    }
    
    const hideOverlay = function () {
        let overlay = document.getElementsByClassName("overlay")[0]
        overlay.classList.add('invisible')
    }
    
    const showOverlay = function () {
        let overlay = document.getElementsByClassName("overlay")[0]
        overlay.classList.remove('invisible')
    }

    const displayGameMessage = function(message) {
        let gameMsgCont = document.getElementsByClassName("gameMessageContainer")[0]
        let gameMsg = document.getElementsByClassName("gameMessage")[0]
        gameMsg.innerHTML = message;
        gameMsgCont.style.opacity = '0'
        gameMsgCont.classList.remove('invisible')
        opacityUp(gameMsgCont, 5, 0, 100)
    }

    const hideGameMessage = function() {
        let gameMsgCont = document.getElementsByClassName("gameMessageContainer")[0]
        gameMsgCont.classList.add('invisible')
    }
    
    const addStar = function (currentPlyr) {
        let id = currentPlyr.getName().concat('WinCounter')
        let winCounter = document.getElementById(id)
        let img = document.createElement('img')
        img.classList.add('star', 'filter-silver')
        img.src = '/img/star-svgrepo-com.svg'
        winCounter.appendChild(img)
        sizeBounce(img, 5, 36, 24)
    }


    const opacityUp = function(element, speed, start, end) {
        element.style.opcaity = 0
        let timer = setInterval(animate, speed);
        let opac = start;
        function animate() {
            if (opac >= end) {
                clearInterval(timer)
            } else {
                element.style.opacity = opac
                opac++
            }
        }
        
    }
    
    const sizeBounce = function(element, speed, maxSize, minSize) {
        element.style.paddingTop = 0 + 'px'
        element.style.paddingBottom = 0 + 'px'
        let timer = setInterval(animate, speed);
        let size = maxSize;
        function animate() {
            let star = element
            if (size <= minSize) {
                clearInterval(timer)
            } else {
                star.style.height = size + 'px'
                star.style.width = size + 'px'
                size--
                
            }
        }
    }
    
    const addCapsOrSpaces = function(updated) {
        let capital = updated.charAt(0).toUpperCase() + updated.slice(1)
        let num = capital.match(/[0-9]/)
        if (num) {
            let idx = capital.indexOf(num[0])
            let removed = capital.slice(idx)
            let first = capital.substring(0,idx)
            capital = first + ' ' + removed
        }
        return capital
    }
    
    const updatePlayerImg = function(original, updated, image) {
        let img = document.getElementById(original)
        img.src = `/img/${image}-svgrepo-com.svg`
        img.id = updated
        let winCounter = document.getElementById(`${original}WinCounter`)
        winCounter.id = `${updated}WinCounter`
        let label = addCapsOrSpaces(updated)
        let labelElement = document.getElementById(`${original}Label`)
        labelElement.innerHTML = `${label}`
        labelElement.id = `${updated}Label`
        
    }
    
    const resetPage = function() {
        // if player 2 is set to computer.  Set it back to Player 2
         if (document.getElementById('computer')!= undefined) {
             updatePlayerImg('computer', 'player2', 'person')
            }
            
            //if player 2 is gold remove it
            let p2Img = document.getElementById('player2')
        if (p2Img.classList.contains('filter-gold')) {
            p2Img.classList.remove('filter-gold')
        }
        
        //if player 1 is not gold Add it
        let p1Img = document.getElementById('player1')
        if (!p1Img.classList.contains('filter-gold')) {
            p1Img.classList.add('filter-gold')
        }
        
        //delete all win counters
        let winCounters = document.getElementsByClassName('winCounter');
        [...winCounters].forEach( (counter) => {
            while (counter.firstChild) {
                counter.removeChild(counter.firstChild)
            }
        });

        //bring up overlay to choose new player
        showOverlay()
    }
    
    resizeText()  // resizes player symbols if the viewer size changes  required for the correct viewer size
    window.onresize = resizeText;
    
    return {
        display, 
        resizeText, 
        hideOverlay, 
        addStar, 
        resetPage,
        updatePlayerImg,
        sizeBounce,
        displayGameMessage,
        hideGameMessage
    };
})();