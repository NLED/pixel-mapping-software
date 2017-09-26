MIT License

Copyright (c) 2015 Northern Lights Electronic Design, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 Original Author: Jeffrey Nygaard
 Company: Northern Lights Electronic Design, LLC
 Contact: JNygaard@NLEDShop.com
 Date Updated: August 26, 2016 
 Software Version:  1f
 Webpage: www.NLEDShop.com/nledpatcher
 Written in Processing v2.2.1(won't work with 3.2.1)  - www.Processing.org
  
  //============================================================================================================
 
 This application is only for Processing 2, it does not work with Processing 3 due to the libraries required for multiple windows
 
 This software is written to work with NLED-Matrix, the free Open-Source, Processing/Java based, LED Matrix Control software
 
 And works with NLED Aurora - Color Sequence Creation Software for the creation of pixel map/patch files
 
//============================================================================================================

 Used to create a coordinate Patch file usable with NLED-Matrix,NLED Aurora, NLED Live Patcher. Required for custom layouts and control schemes for LED Panels/Matrices.
 
 Feel free to use this software or parts of it for whatever you like. Personal or commercial, just give attribution if the customized project is released.
 And Please Contact Me at the email address above with any questions, comments, or suggestions.
 
 See included README.TXT for more details
 
 //============================================================================================================
 
 This software opens 2 windows, one window is for the controls the other is the grid window that displays the layout.
 
 Control Window Usage:
 
 	 - Figure out how many pixels wide and how many pixels tall the matrix will be. Figure out which order the LEDs are arranged in.
 	 
 	 - Select the amount of Cells for how many grids wide the Grid Window will display as a square.
 	 
 	 - Adjust the size of the window by dragging an outside edge to fit your screen
 	 
 	 - Adjust the Cell Size to suit or click the Fit Grid To Window button.  Click Update Grid to apply changes.
 	 
 	 - Enter the total amount of pixels in the LED matrix using the slider or textfield
 	 
 === Switch to the Grid window ===
 	 
 	 - Start placing the points one by one, points can be moved by clicking, holding and then dragging the icon to new location. 
 	 
 	 - Once placed they can be moved by clicking and dragging the icon.
 	 
 	 - For faster placement, in the Control Window press the Drag To Place button(or press Shift to toggle). Then back in the Grid Window, click, hold and move the mouse to place
 	    the pixel icons. Note you must disable Drag To Place to restore normal functions.
 
 	- It is recommended to save inclemently often, some functions can not be undone. The software automatically saves before functions run, press "CTRL z" to attempt undo
 
 Controls:
 
 	- At any time Right-Click a LED Icon to open a options menu.
 		  - Delete Before Pixel Number, deletes all pixels before selected number and placing points will begin at the lowest pixel that was deleted, then
 			  once it reaches the already placed pixels, it will begin at the highest pixel that hasn't been placed yet
 		  - Delete After Pixel Number
 		  - Close Menu
 		
         - At anytime Right-Click an empty grid square to open the Tools Menu
           - Group Select, after selection press again to start bounding box drag, select the icons/points to be grouped
           - Move Group Selection, once clicked, clicking again will begin a rectangle drag that will select all pixels within it, when released the pixels will move with the mouse, until mouse press which places them.
           - Copy Group, copies the group into the next lowest ID#s, starts Move Group once the points are created
           - Delete Group, deletes the currently selected points. After deletion when points are placed they will be placed into the lowest ID#s
           - Rotate Group CW - Rotate Group Clockwise 90 degrees
           - Rotate Group CCW - Rotate Group Counter Clockwise 90 degrees
           
 	- Use the Up/Down/Left/Right Arrow keys to move the display around on the grid window. Or use the X/Y sliders on the Control Window or Grid Window
 
 	- CTRL+Z loads previous autosave, limited functionality
 
 	- Shift key Toggles Drag to Place usage
 
	- Spacebar simulates a Right-Mouse click to open the menu, for Mac users
 
 =============================================================================================================================================
 
 Revision 1a to 1b:
   	- Added rolling autosaves
   	- Added save/restore window saves
   	- Added tallys for rows and columns to count how many points are in them	
   	- Added some hotkeys
   	- Added scroll bars on Grid Window, dragging them causes some graphical glitches though otherwise use control window sliders or arrow keys	
   	- Fixed dragging points	
   	- Added option to load an image to overlay the points onto. Can't resize or move it, so do that all in a image editor before loading. Doesn't save image path.
   
 Revision 1b to 1c:
   -Updated Group Moving
   -Updated draw method, by removing loop() and replacing with redraw()
   	
 Revision 1c to 1d:
   - Fixed some minor bugs
   - Fixed grid layout and grid numbering layout issues
   
 Revision 1d to 1e:
   - Revised Menus
   - Added Copy Group
   - Added Rotate Group, Clockwise(CW) or Counter Clockwise(CCW)
   - Revised how points/icons can be placed, more dynamic.
   - Linked CTRL+Z usage with autosaves, easier and more capable than before. Note it saves all points even if they are not Enabled(not seen) but have yet to be replaced.
       As a work around, finish the patch file in one session, or move points to empty space when saving if planning on finishing later.
   
  Revision 1e to 1f:
   - Revised Menus
   - Added Copy Group
   - Added Rotate Group, Clockwise(CW) or Counter Clockwise(CCW)
   - Revised how points/icons can be placed, more dynamic.
   - Linked CTRL+Z usage with autosaves, easier and more capable than before. Note it saves all points even if they are not Enabled(not seen) but have yet to be replaced.
       As a work around, finish the patch file in one session, or move points to empty space when saving if planning on finishing later.
     
 Notes:

   - Rotating while over other lapping other points causes the points to not get rotated correctly, 
   for now rotate so points would not be rotated onto others.
   
   - LEDGraphics Object only has up to 4096 objects, so that is maximum amount of pixels, but the number could be increased in the declaration.

