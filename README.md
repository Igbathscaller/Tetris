# PuyoPuyoTetris
Design Document
https://docs.google.com/document/d/1Mx8YY4uc_4GV24MiqMmHlqhwnB3wSif1kmcrsErQlR8/edit

5/21/2021
- Initialized files
- Added a game selector (clickable interface)
- Put a WIP page on Puyo Puyo
- Created board
- Added colors for pieces and background
- Saved Placements in an Array

5/24/2021
- Removed old colors and used pictures instead
- Created a new class for the tentative piece
- Created a new class for the Queue of next pieces.
- Added preview bar for next 5 and preview pictures

5/25/2021
- Moving Pieces and Wall Checks are completed
- Holding is complete. With Cooldown and Preview and good Box

5/26/2021
- Seperated movement function into a boolean wall check and a move
- Added Hard Drop and first time we save pieces on board.
- Moved Pictures into assets Folder
- Added Simple Gravity. (might make it increase speed in future)
- Blink Effect when something locks (accidental cool functionality due to order of code)
- When Holding Down, Soft Drop occurs. It breaks when you click another button, so I guess it feels jank.

5/28/2021
- ShadowPiece is now saved as an integer (height from current piece).
- ShadowPiece renders properly and is transparent. Original Piece takes precedence.
- Spinning and Rotation without kicks implemented. (O piece shouldn't move when spinning)
