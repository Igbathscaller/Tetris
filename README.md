# PuyoPuyoTetris
## How to Run
Compile/run via Processing
## How to Play
Once you are on the main screen, you should see two buttons: Tetris and Puyo Puyo. Clickng on them will bring you to their respective games.  
Hitting Backspace on the Tetris or Puyo Puyo games will bring you back to the main screen.  
**Tetris**  
Left, right, down arrow keys: Move the tetromino in their respective directions  
Up arrow key: Rotates the tetromino  
'C' key: Allows you to hold onto a tetromino. It cannot be used again until the piece moving after you hold is placed.  
Space: This will instantly drop a piece  

## Logs
**5/21/2021**
- Initialized files
- Added a game selector (clickable interface)
- Put a WIP page on Puyo Puyo
- Created board
- Added colors for pieces and background
- Saved Placements in an Array

**5/24/2021**
- Removed old colors and used pictures instead
- Created a new class for the tentative piece
- Created a new class for the Queue of next pieces.
- Added preview bar for next 5 and preview pictures

**5/25/2021**
- Moving Pieces and Wall Checks are completed
- Holding is complete. With Cooldown and Preview and good Box

**5/26/2021**
- Seperated movement function into a boolean wall check and a move
- Added Hard Drop and first time we save pieces on board.
- Moved Pictures into assets Folder
- Added Simple Gravity. (might make it increase speed in future)
- Blink Effect when something locks (accidental cool functionality due to order of code)
- When Holding Down, Soft Drop occurs. It breaks when you click another button, so I guess it feels jank.

**5/28/2021**
- ShadowPiece is now saved as an integer (height from current piece).
- ShadowPiece renders properly and is transparent. Original Piece takes precedence.
- Spinning and Rotation without kicks implemented. (O piece shouldn't move when spinning)

**5/30/2021**
- Made the board into a col by row matrix. 
- SRS is possibly complete. Might need more testing to verify.
- Clearing lines is done (Basic Tetris Functionality is done)
- Smoother Button Pressing/Holding. Smooth DAS and ARR
- Can hold multiple buttons at the same time.
- Created ClearEffects for the future of clearing.

**6/2/2021**
- Made the board a 40 by 10.
- Game stops when you reach the top
- Terminal say gg when you finish.

**6/4/2021**
- Basic Scoring System

**6/5/2021**
- Created a main menu design
- Got Puyo Puyo Piece Assets. Still requires Purifing.
- Might not require all of them if I don't want to do interlocking pieces. 
- I Piece has a different kick table. (fixed bug where I piece wouldn't knock off wall).

**6/7/2021**
- Main Menu has clickable buttons. (detects box mouse is in)
- Puyo Puyo has a new clean state.

**6/8/2021**
- Puyo Puyo now saves pieces and you can move left and right.
- There is a preview for Puyo Puyo
- The Pieces will fall after a set period of time
- Gravity Exists

**6/9/2021**
- Rotation is Complete with both clockwise and counterclockwise
- Got all interconnecting pieces pngs in PuyoPuyo. 1 is down. 2 is up. 4 is right. 8 is left.
- The pieces connect now when they are placed near each other.

**6/10/2021**
- 2 Player Tetris have two concurrent tetris games.
- They have seperate KeyBinds
- Sending Lines in 2P tetris has been complete. Tspins have not been designed yet.

## Design Document
https://docs.google.com/document/d/1Mx8YY4uc_4GV24MiqMmHlqhwnB3wSif1kmcrsErQlR8/edit?usp=sharing
