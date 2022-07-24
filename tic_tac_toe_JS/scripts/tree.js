"use strict";

const graph = function(board) {
    let root = node(board)
    return {root}
}

const node = function(position, symbol = null, move = null) {
    const {buildNextNodes, calculateValue} = nodeMethods()
    let winner = gameboard.checkWinner(symbol, position)
    let nextNodes = buildNextNodes(position, symbol, winner);
    let value = calculateValue(winner, nextNodes, move)
    return {
        move,
        winner,
        nextNodes,
        value
    }
}

const nodeMethods = function() {
    const calculateValue = function(win, nodesArr, move) {
        if (nodesArr == null) return null;                              //deal with if null input.
        if (win) return 10;                                             //look for any moves that will win.
        if (nodesArr.some(node => node.winner === true)) return -10;    //avoid any moves that will lose.
        if (move == 4) return 1;                                        //prioritize the middle position.
        else return 0; 
    }
    
    const buildNextNodes = function(position, symbol, winner, collector = []) {
        symbol = [null, 'X'].includes(symbol) ? 'O' : 'X';
        let draw = gameboard.checkDraw(position);
        if (winner || draw) return [];
        position.forEach((elm, idx) => {
            if (elm == '') { 
                let newArr = [...position];
                newArr[idx] = symbol;
                collector.push(node(newArr, symbol, idx));
            }
        });
        return collector;
    }
    return {buildNextNodes, calculateValue}
}

const findBestMove = function(graph) {
    let queue = [graph.root];
    let bestMove = [];
    let bestValue = -11;
    while (queue.length > 0) {
        let currentNode = queue.shift();
        if (currentNode == graph.root && currentNode.nextNodes.length > 0) {
            currentNode.nextNodes.forEach((node)=>{queue.push(node)});
            continue;
        }
        if (currentNode.value == bestValue) {
            bestMove.push(currentNode.move)
        }
        if (currentNode.value > bestValue) {
            bestMove = [currentNode.move];
            bestValue = currentNode.value;
        }
       
    }
    let num = Math.floor(Math.random() * bestMove.length);
    return bestMove[num]
}

