"use strict";

const player = (name, symbol, isCpu) => {
    let first = name == 'player1';
    const getName = () => name;
    const getSymbol = () => symbol;
    const getFirst = () => first;
    const setFirst = (input) => first = input;
    const getIsCpu = () => isCpu
    const cpuPick = function() {
        return findBestMove(graph(gameboard.getBoard()))
    }
    
   
    return {getName, getSymbol, getFirst, setFirst, getIsCpu, cpuPick}
}