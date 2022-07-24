"use strict";

const controlFlow = (function() {
    let players = [player('player1', 'X', false)]
    let cells = [...document.getElementsByClassName('cell')]; 
    let listeners = []

    const newPlayer= (name, symbol, isCpu) => {
        let plr = player(name, symbol, isCpu);
        players.push(plr);
        return plr;
    }

    const choosePlayer = (label) => {
        displayController.hideOverlay();
        let isCpu = label == 'computer' ? true : false;
        let plr = newPlayer(label, 'O', isCpu);
        if (plr.getIsCpu()) {
            displayController.updatePlayerImg('player2', 'computer', 'cpu')
        }
       round()
    }

    const round = function() {
        let currentPlyr = players.find(plr => plr.getFirst() == true);
        let symbol = currentPlyr.getSymbol()
        if (currentPlyr.getName()=='computer' && !gameboard.checkWinner(symbol, gameboard.getBoard())) {
            setTimeout(()=>{
                let symbol = currentPlyr.getSymbol()
                let boardIndex = currentPlyr.cpuPick()
                gameboard.setBoard(boardIndex, symbol)
                displayController.display(gameboard.getBoard())
                checkForWinner(currentPlyr, symbol)
            }, 800);
        }
        else {
            addCellListeners()
        }
    }

    const playerTurn = function() {
        let currentPlyr = players.find(plr => plr.getFirst() == true);
        if (this.innerHTML == '') {
            let str = this.id
            let idx = str.search(/[0-9]/)
            let boardIndex = str[idx] - 1
            let symbol = currentPlyr.getSymbol()
            gameboard.setBoard(boardIndex, symbol)
            displayController.display(gameboard.getBoard())
            removeCellListeners()
            checkForWinner(currentPlyr, symbol)
        }
    }

    const checkForWinner = function(currentPlyr, symbol) {
        if (gameboard.checkWinner(symbol, gameboard.getBoard())) {
            setTimeout(function() {
                displayController.addStar.call(this, currentPlyr);
                displayController.displayGameMessage(`${currentPlyr.getName()} Wins!`)
                swapFirst(currentPlyr);
                reset();
            }, 800);
        } else {
            setTimeout(function() {
                swapFirst(currentPlyr)
                gameboard.checkDraw(gameboard.getBoard()) ? setTimeout(reset, 800) : round();

            }, 250)
        }
    }

    const addCellListeners = function() {
        cells.forEach((cell) => {
            let x = playerTurn.bind(cell)
            listeners.push(x)
            cell.addEventListener('click', x, true);
        });
    }

    const removeCellListeners = function() {
        cells.forEach((cell) => {
            cell.removeEventListener('click', listeners[0], true);
            listeners.shift()
        });
    }
    
    const swapFirst = function(currentPlyr) {
        toggleGold();
        players.forEach((plr) => { (plr === currentPlyr) ? plr.setFirst(false) : plr.setFirst(true) });
        let currentPlayer = players.find(plr => plr.getFirst() == true)
        let img = document.getElementById(currentPlayer.getName())
        displayController.sizeBounce(img, 5, 58, 48);
        toggleGold();
    }

    const range = (start, stop, step) => Array.from({ length: (stop - start) / step + 1}, (_, i) => start + (i * step));
    
    const reset = function() {
        [...range(0, 8, 1)].forEach(num => gameboard.setBoard(num, ''));
        displayController.display(gameboard.getBoard())
        setTimeout(function() {displayController.hideGameMessage()}, 1500) 
        round()
    }

    const toggleGold = function() {
        let currentPlyr = players.find(plr => plr.getFirst() == true);
        let goldPlayer = document.getElementById(currentPlyr.getName())
        goldPlayer.classList.toggle('filter-gold')
    }

    const clearPlayers = function() {
        while(players.length>0) {
            players.pop()
        }
    }

    const resetPage = function() {
        removeCellListeners()
        clearPlayers()                                                      //remove players
        newPlayer('player1', 'X', false);                                   //add back first player
        [...range(0, 8, 1)].forEach(num => gameboard.setBoard(num, ''));    //reset game board without startint a new round
        displayController.display(gameboard.getBoard())
        displayController.resetPage()                                       //reset DOM Elements
    }

    let arr = document.getElementsByClassName('transparentBut');
    [...arr].forEach( button => button.addEventListener('click', choosePlayer.bind(button, button.name) ))
   
    let resetBtn = document.getElementById('resetBtn')
    resetBtn.addEventListener('click', resetPage)

    return {}
})();