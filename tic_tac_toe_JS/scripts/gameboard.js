"use strict";

const gameboard = (function() {
    
    const board = ['','','','','','','','',''];

    const getBoard = () => board
    const setBoard = (pos, symbol) =>  board[pos] = symbol
    
    const updateWinConditions = function(arr) {
       let winConditions = [[arr[0], arr[1], arr[2]],
                            [arr[3], arr[4], arr[5]],
                            [arr[6], arr[7], arr[8]],
                            [arr[0], arr[3], arr[6]],
                            [arr[1], arr[4], arr[7]],
                            [arr[2], arr[5], arr[8]],
                            [arr[0], arr[4], arr[8]],
                            [arr[2], arr[4], arr[6]]]
        return winConditions
    }
    const checkWinner = function(symbol, arr) {
        let winConditions = updateWinConditions(arr)
        let collector = []
        winConditions.forEach((arr)=> collector.push(arr.every(itm => itm == symbol)))
        //console.log(board)
        //console.log(winConditions)
        //console.log(collector)
        return collector.some(itm => itm == true)
    }

    const checkDraw = function(arr) {
       let check = arr.some(itm => itm == '')
       return !check
    }
    
    return {getBoard, 
            setBoard, 
            checkWinner, 
            checkDraw}
})();