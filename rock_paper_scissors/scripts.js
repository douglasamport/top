const rock = document.querySelector('#rock');
const paper = document.querySelector('#paper');
const scissors = document.querySelector('#scissors');
const btnReset = document.querySelector('#btnReset');
const paraFinal = document.querySelector('#final-msg');
const paraPlayerScore = document.querySelector('#player-score');
const paraCompScore = document.querySelector('#computer-score');
const message = document.querySelector('#message');
const countdown = document.querySelector('#countdown');
const time = 400;

let tie = 0;
let playerWins = 0;
let computerWins = 0;

function addLisnteners() {
    rock.addEventListener('click', game);
    paper.addEventListener('click', game);
    scissors.addEventListener('click', game);
}
addLisnteners();

async function counterShoot() {
    const timer = ms => new Promise(res => setTimeout(res, ms));
      let i = 3;
      while (i >= 0) {
          countdown.textContent = i;
          await timer(time);
          i--;
        if (i === 0) {
            countdown.textContent = "shoot!";
          i--;
        }
       
      }
   }

function clearGlobals() {
    message.textContent = '';
    paraFinal.textContent = '';
    paraPlayerScore.textContent = '';
    paraCompScore.textContent = '';
    countdown.textContent = '';
    playerWins = 0;
    computerWins = 0;
    tie = 0;
}

function removeChildById(parentId, childId) {
    let parent = document.getElementById(parentId);
    let child = document.getElementById(childId);
    parent.removeChild(child);
}

function resetTotal() {
    addLisnteners();
    clearGlobals();
    removeChildById("header-div", "btnReset");
}

function game(play) {
    let computerPlay = determineComputerPlay();
    let msgRound = decideWinner(this.name, computerPlay);
    
    counterShoot();
    
    if (msgRound.match(/win/i)) {
        playerWins++;
    }
    else if (msgRound.match(/lose/i)) {
        computerWins++;
    }
    else if (msgRound.match(/tie/i)) {
        tie++;
    }
    
    let finalMsg = finalCount(computerWins, playerWins);
    
    setTimeout(() => {
        message.textContent = `Player: ${this.name}     Computer: ${computerPlay} 
    ${msgRound}`; 
        paraFinal.textContent = `${finalMsg}`;
        paraPlayerScore.innerHTML = `Player: ${playerWins}`;
        paraCompScore.textContent = `Computer: ${computerWins}`;
        resetSetup(computerWins, playerWins);
    }, time*3);
}

function removeListeners() {
    rock.removeEventListener('click', game);
    paper.removeEventListener('click', game);
    scissors.removeEventListener('click', game);
}

function resetSetup(computerWins, playerWins) {
    if (computerWins === 5 || playerWins === 5) {
        removeListeners();
        let btnReset = document.createElement("button");
        btnReset.innerText = "Reset";
        btnReset.classList.add('full-width');
        btnReset.id = "btnReset";
        let headerDiv = document.getElementById("header-div");
        headerDiv.appendChild(btnReset);
        btnReset.addEventListener('click', resetTotal);
    }
}

function finalCount(computer, player) {
    if (computer === 5) {
        return `You Lose the Game!`;
    }
    else if (player === 5) {
        return `You Win the Game!`;
    }
    else {
        return '';
    }
}

function determineComputerPlay() {
    let computerOption = ['rock', 'paper', 'scissors'];
    let x = computerOption[Math.floor(Math.random() * computerOption.length)];
    return x;
}

function decideWinner(player, computer) {
    if (player === 'paper' &
        computer === 'rock') {
        return `You Win this round! ${player} covers ${computer}. `;
    }
    if (player === 'rock' &
        computer === 'scissors') {
        return `You Win this round! ${player} crushes ${computer}. `;
    }
    if (player === 'scissors' &
        computer === 'paper') {
        return `You Win this round! ${player} cuts ${computer}. `;
    }
    if (computer === 'paper' &
        player === 'rock') {
        return `You Lose this round! ${computer} covers ${player}. `;
    }
    if (computer === 'rock' &
        player === 'scissors') {
        return `You Lose this round! ${computer} crushes ${player}. `;
    }
    if (computer === 'scissors' &
        player === 'paper') {
        return `You Lose this round! ${computer} cuts ${player}. `;
    }
    else {
        return 'It\'s a tie!';
    }
}