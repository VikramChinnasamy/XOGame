<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.RequestDispatcher" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tic Tac Toe</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      height: 100vh;
      margin: 0;
      background-color: #f4f4f4;
    }

    #header {
    
      display: flex;
      align-items: center;
      margin-bottom: 20px;
    }

    #left-image,
    #right-image {
    margin-left:20px;
      width: 150px;
      height: 150px;
      margin-right: 20px;
      border-radius: 50%;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    #board {
      display: grid;
      grid-template-columns: repeat(3, 100px);
      grid-gap: 5px;
      background-color: #61dafb;
      border: 5px solid #1c1c1c;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
      margin-bottom: 20px;
    }

    .cell {
      width: 100px;
      height: 100px;
      font-size: 24px;
      text-align: center;
      line-height: 100px;
      background-color: #ff6f61;
      color: #fff;
      cursor: pointer;
      transition: background-color 0.3s ease-in-out;
    }

    .cell:hover {
      background-color: #ff473a;
    }

    #restart-button {
      display: none;
      margin-top: 20px;
      padding: 10px;
      font-size: 16px;
      cursor: pointer;
      background-color: #4caf50;
      color: #fff;
      border: none;
      border-radius: 5px;
      transition: background-color 0.3s ease-in-out;
    }

    #restart-button:hover {
      background-color: #45a049;
    }

    #num-matches-container {
      margin-bottom: 20px;
    }

    label {
      font-size: 18px;
      margin-right: 10px;
    }

    input {
      font-size: 16px;
      padding: 5px;
    }

    button {
      font-size: 16px;
      padding: 8px 12px;
      background-color: #2196f3;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease-in-out;
    }

    button:hover {
      background-color: #0b7dda;
    }

    #results {
      font-size: 18px;
      font-weight: bold;
    }
        #user-details {
      position: fixed;
      top: 10px;
      right: 10px;
      cursor: pointer;
    }

    #user-details-popup {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      padding: 20px;
      background-color: #fff;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
      border-radius: 8px;
      z-index: 1000;
    }

    #user-details-popup h3 {
      margin-bottom: 10px;
    }

    #user-details-popup p {
      margin-bottom: 5px;
    }

    #close-popup {
      cursor: pointer;
      color: #007bff;
      font-weight: bold;
    }
    #scores {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 20px;
    }
  </style>
</head>





<body>

  <div id="header">
    <img id="left-image" src="./img/img1.jpeg" alt="Left Image">
    <div id="board"></div>
    <img id="right-image" src="./img/img2.jpeg" alt="Right Image">
    <img id="logo" src="./path/to/your/logo.png" alt="Logo" style="cursor: pointer;">
    <div id="logo-buttons" style="display: none;">
         <button onclick="handleButton1Click()">Results</button>
         <button onclick="handleButton2Click()">User Details</button>
    </div>
    
  </div>
  <div id="scores">Player 💀: <span id="score1">0</span> | Player 👼: <span id="score2">0</span></div>
  <div id="num-matches-container">
    <label for="num-matches">Number of Matches:</label>
    <input type="number" id="num-matches" min="1" value="1">
    <button onclick="startMatches()">Start Matches</button>
  </div>
  <div id="restart-button" onclick="restartGame()">Restart</div>
  <div id="results"></div>

  <button onclick="sendScoresToServer()">Send Scores to Server</button>

  <script>
    const board = document.getElementById('board');
    const restartButton = document.getElementById('restart-button');
    const numMatchesInput = document.getElementById('num-matches');
    let currentPlayer = '💀';
    let gameBoard = ['', '', '', '', '', '', '', '', ''];
    let gameActive = true;
    let matchCount = 0;
    let player1Wins = 0;
    let player2Wins = 0;
    let player1Losses = 0;
    let player2Losses = 0;
    let player1Draws = 0;
    let player2Draws = 0;

    function checkWinner() {
      const winPatterns = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
      ];

      for (const pattern of winPatterns) {
        const [a, b, c] = pattern;
        if (gameBoard[a] && gameBoard[a] === gameBoard[b] && gameBoard[a] === gameBoard[c]) {
          return gameBoard[a];
        }
      }

      return null;
    }

    function checkDraw() {
      return !gameBoard.includes('') && !checkWinner();
    }

    function checkLoss() {
      if (currentPlayer === '💀') {
        player2Losses++;
      } else {
        player1Losses++;
      }
    }

    function handleClick(index) {
      if (!gameActive || gameBoard[index] !== '') {
        return;
      }

      gameBoard[index] = currentPlayer;
      const winner = checkWinner();
      const draw = checkDraw();

      if (winner) {
        alert(Player ${winner} wins!);
        matchCount++;
        updateMatchCount();
        if (winner === '💀') {
          player1Wins++;
        } else {
          player2Wins++;
        }
        if (matchCount < parseInt(numMatchesInput.value)) {
          restartGame();
        } else {
          showResults();
        }
      } else if (draw) {
        alert('Match gets draw');
        matchCount++;
        updateMatchCount();
        player1Draws++;
        player2Draws++;
        restartGame();
      } else {
        currentPlayer = currentPlayer === '💀' ? '👼' : '💀';
      }
      if (winner) {
    	    checkLoss();
    	  }

      renderBoard();
    }

    function startMatches() {
      matchCount = 0;
      player1Wins = 0;
      player2Wins = 0;
      player1Losses = 0;
      player2Losses = 0;
      updateMatchCount();
      restartGame();
    }

    function showResults() {
        alert(Player 💀 wins: ${player1Wins} matches\nPlayer 👼 wins: ${player2Wins} matches);
        updateScoresOnPage(); // Added to update scores on the page
      }

    function restartGame() {
      gameBoard = ['', '', '', '', '', '', '', '', ''];
      gameActive = true;
      hideRestartButton();
      currentPlayer = '💀';
      renderBoard();
    }

    function hideRestartButton() {
      restartButton.style.display = 'none';
    }

    function showRestartButton() {
      restartButton.style.display = 'block';
    }

    function renderBoard() {
      board.innerHTML = '';
      gameBoard.forEach((value, index) => {
        const cell = document.createElement('div');
        cell.classList.add('cell');
        cell.textContent = value;
        cell.addEventListener('click', () => handleClick(index));
        board.appendChild(cell);
      });
    }

    function updateMatchCount() {
      if (matchCount > 0) {
        document.getElementById('restart-button').style.display = 'block';
      } else {
        document.getElementById('restart-button').style.display = 'none';
      }
    }

    renderBoard();

    function showResults() {
      alert(Player 💀 wins: ${player1Wins} matches\nPlayer 👼 wins: ${player2Wins} matches);
      updateScoresOnPage(); // Added to update scores on the page
    }

    function updateScoresOnPage() {
      document.getElementById('score1').textContent = player1Wins;
      document.getElementById('score2').textContent = player2Wins;
    }

    function sendScoresToServer() {
      const score1 = player1Wins;
      const score2 = player2Wins;
      const losses1 = player1Losses;
      const losses2 = player2Losses;
      const draws1=player1Draws;
      const draws2=player2Draws;
      const totalMatches = matchCount;

      const form = document.createElement('form');
      form.method = 'post';
      form.action = 'MatchServlet';

      const input1 = document.createElement('input');
      input1.type = 'hidden';
      input1.name = 'score1';
      input1.value = score1;

      const input2 = document.createElement('input');
      input2.type = 'hidden';
      input2.name = 'score2';
      input2.value = score2;

      const inputLosses1 = document.createElement('input');
      inputLosses1.type = 'hidden';
      inputLosses1.name = 'losses1';
      inputLosses1.value = losses1;

      const inputLosses2 = document.createElement('input');
      inputLosses2.type = 'hidden';
      inputLosses2.name = 'losses2';
      inputLosses2.value = losses2;
      
      const inputDraws1 = document.createElement('input');
      inputDraws1.type = 'hidden';
      inputDraws1.name = 'draws1';
      inputDraws1.value = draws1;
      
      const inputDraws2 = document.createElement('input');
      inputDraws2.type = 'hidden';
      inputDraws2.name = 'draws2';
      inputDraws2.value = draws2;
      
      const inputTotalMatches = document.createElement('input'); // Add a new input field for total matches
      inputTotalMatches.type = 'hidden';
      inputTotalMatches.name = 'totalMatches';
      inputTotalMatches.value = totalMatches;

      form.appendChild(input1);
      form.appendChild(input2);
      form.appendChild(inputLosses1);
      form.appendChild(inputLosses2);
      form.appendChild(inputDraws1);
      form.appendChild(inputDraws2);
      form.appendChild(inputTotalMatches); 
      document.body.appendChild(form);
      form.submit();
    }
    const logo = document.getElementById('logo');
    const logoButtons = document.getElementById('logo-buttons');

    logo.addEventListener('click', () => {
      logoButtons.style.display = 'block';
    });

    function handleButton1Click() {
      // Handle the action for Button 1
      // For example, you can redirect to another page
      window.location.href = 'Display.jsp';
    }

    function handleButton2Click() {
      // Handle the action for Button 2
      // For example, you can redirect to another page
      window.location.href = 'UserDetails.jsp';
    }

  </script>
  <%
  String userId = (String)request.getAttribute("id");
  System.out.println(userId); 


%>



</body>

</html>