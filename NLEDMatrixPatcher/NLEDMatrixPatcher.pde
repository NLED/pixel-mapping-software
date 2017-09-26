/*
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
 Written in Processing v2.2.1(won't work with Processing 3.x.x)  - www.Processing.org
 
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
   
 Updates:
 
   - Make drag to place change mouse cursor
   
   - Add button to step through LED Icons changing their color to check for mistakes(like I made)
  
   - Loading a file with lower amount of placed icons, won't wipe them but allow them to be moved. need to wipe clean
   
   - Current export doesn't load into matrix without deleteing new header info and leaving just maxpixels
 
 
 NOT YET ADDED:
 
     - Un highlight icons after action and loading file, and Ctrl+Z
 
 
 */

//import libraries
import javax.swing.JFrame;
import javax.swing.ImageIcon;
java.awt.Insets insets;

//Init Constants
final color ColButtonsBG = color(100);
final color ColButtonsHL = color(200, 40, 40);
final color ColButtonsOut = color(0, 100, 255); //selected/highlighted color for buttons
final color LEDIconColor = color(0, 0, 255);
final color cBackgroundColor = color(65);
final int cCellSpacing = 22;

final int cMaxAutoSaves = 10;
final boolean cAutoSaveEnabled = true;

//============= VARIABLES ==================================
int OffsetVarX = 0;
int OffsetVarY = 0;

int CellSpacing = 0;
int IconCounter = 0;
int ChannelNum = 0;
int cellWidth = 32;

int PrevHeight = height;  //used to watch if the grid window's size is changed
int PrevWidth = width;
int UserCellSpacing = cCellSpacing;

int CoordX = 0;
int CoordY = 0;

int SliderSet=0;
int SelectedSlider=0;
int SelectedTextField = 0;
int SelectedPoint = 0;
int FileBrowserAction = 0;

int MenuOpenedIcon = 0;

int MenuXpos = 0;
int MenuYpos = 0;

int SelectBoxX = 0;
int SelectBoxY = 0;

int SelectBoxXpos = 0;
int SelectBoxYpos = 0;

int SelectBoxW = 0;
int SelectBoxH = 0;

int GroupedPoints[] = new int[1];
int SelectedPointsCounter = 0;

int LowestX = 10000;
int LowestY = 10000;

int rollingSaveNum = 1;

int tempTally = 0;

boolean GlobalDragging = false;
boolean DraggingPoint = false;    
boolean DragToDraw=false;
boolean TextFieldActive = false;
boolean DragToPlaceEnabled = false;
boolean MenuOpen = false;
boolean ToolsMenuOpen = false;
boolean EnableGroupSelect = false;
boolean SelectPointInit = false;
boolean DraggingGroup = false;
//boolean CopyGroup = false;
boolean DeleteGroup = false;
//boolean AllowAutoSave = true;

PImage UserImage;

String SelectedFile ="";     

color ColorArray[] = new color[100];
color CoordColor = color(0, 0, 255);

ArrayList strs = new ArrayList();
ArrayList groupSelAL = new ArrayList();

//================ Object Declaration ========================
LEDgraphic[] LEDIcons;
Button[] Buttons;
SliderBar[] SelectSliders;
TextField[] TextFields;

SliderBar GridXScroll;
VertSliderBar GridYScroll;

PFrame f; //second window objects
secondApplet s;  //code taken from processing forum

void setup() 
{
  size(600, 600);
  background(255);
  noLoop();

  PFrame f = new PFrame();
  LEDIcons = new  LEDgraphic[4096];

  LEDIcons[0] = new LEDgraphic(0, 0, 0, 0, 0,0);

  frame.setResizable(true);
  ImageIcon titlebaricon = new ImageIcon(loadBytes("favicon.gif"));
  frame.setIconImage(titlebaricon.getImage());
  frame.setTitle("Grid Window - NLED Matrix Patcher v.1f");
  f.setIconImage(titlebaricon.getImage());
  f.setTitle("Control Window - NLED Matrix Patcher v.1f");

  CellSpacing = cCellSpacing;//width / cellWidth;
  PrevWidth = width;
  PrevHeight = height;

  insets = frame.getInsets();	//get title bar and border sizes to adjust size correctly

  GridXScroll = new SliderBar(0, height-20, width-20, 20, 0, 0, cellWidth, color(65), color(0, 175, 235), color(65), color(0), true, false); //X
  GridYScroll = new VertSliderBar(width-20, 0, 20, height-20, 0, 0, cellWidth, color(65), color(0, 175, 235), color(65), color(0), true, false); //Y
}//end setup


void draw() 
{
  background(255);
  //adjust window position based on X/Y sliders
  translate(OffsetVarX*CellSpacing, OffsetVarY * CellSpacing);

  if (UserImage != null) image(UserImage, CellSpacing*2, CellSpacing*2);

  if (PrevWidth != width || PrevHeight !=height)
  {
    //check if grid window has been resized, replace coords if it has
    PrevWidth = width;
    PrevHeight = height;   
    println("Width Changed"); 
    CellSpacing= UserCellSpacing;//width / (cellWidth+1);

    //adjust grid window sliders
    GridXScroll.ypos = height-20;
    GridXScroll.Slwidth = width-20;

    GridYScroll.xpos = width-20;
    GridYScroll.Slheight = height-20;

    //move all the LEDIcons into new grid size
    for (int i=0; i != IconCounter; i++)
    {   
      LEDIcons[i].xpos = (LEDIcons[i].xCoord * CellSpacing)+(CellSpacing/2);
      LEDIcons[i].ypos = (LEDIcons[i].yCoord * CellSpacing)+(CellSpacing/2);    
      LEDIcons[i].bSize = (int)(CellSpacing*0.85);
    }
  }//end resize If

  //====================== REDRAW GRID AND LABELS ======================
  stroke(0); //line stroke color black
  strokeWeight(1);

  int holdi=0;

  for (int i=0; i != cellWidth+1; i++)
  {
    line(CellSpacing, (CellSpacing*2)+(i*CellSpacing), (CellSpacing)*(cellWidth+3), (CellSpacing*2)+(i*CellSpacing)); //horiz grid lines
    line((CellSpacing*2)+(i*CellSpacing), CellSpacing, (CellSpacing*2)+(i*CellSpacing), CellSpacing*(cellWidth+2)); //vert grid lines

    holdi=i;

    if (i != cellWidth)
    {
      textAlign(CENTER);  
      textSize(CellSpacing/2);
      fill(0);
      text(i+1, (CellSpacing*2)-(CellSpacing/2), (CellSpacing*2)+(i*CellSpacing)+(CellSpacing/2)); //left side numbers
      text(i+1, (CellSpacing*2)+(i*CellSpacing)+(CellSpacing/2), (CellSpacing*2)-(CellSpacing/2)); //top numbers 
      text(i+1, (CellSpacing*2.5)+(cellWidth*CellSpacing), (CellSpacing*2)+(i*CellSpacing)+(CellSpacing/2)); //right side numbers
      text(i+1, (CellSpacing*2)+(i*CellSpacing)+(CellSpacing/2), (CellSpacing*(cellWidth+3))-(CellSpacing/2)); //bottom numbers

      //START TALLY	
      for (int q=0; q != IconCounter; q++)
      {   
        if (LEDIcons[q].yCoord == i+2) tempTally++;
      }  
      fill(0, 0, 255);  //fill blue
      text(tempTally, CellSpacing/2, (CellSpacing*3)+((i-1)*CellSpacing)+(CellSpacing/2)); //left side tally numbers 
      tempTally = 0;

      //tally column

      for (int q=0; q != IconCounter; q++)
      {   
        if (LEDIcons[q].xCoord == i+2) tempTally++;
      }  

      fill(0, 0, 255);  //fill blue
      text(tempTally, (CellSpacing*3)+((i-1)*CellSpacing)+(CellSpacing/2), CellSpacing/2); //top numbers 		
      tempTally = 0;
    }	//end if	
    //end tally
  }
  noStroke();
  //=====================  END DRAW GRID ======================

  for (int q=0; q != SelectedPointsCounter; q++)  LEDIcons[GroupedPoints[q]].displaySelected(); //displays red border, indicating selected
  for (int i=0; i != IconCounter; i++) if (LEDIcons[i].Enabled == true) LEDIcons[i].display();  //displays icons

  //==================================================================

  if (DragToDraw == true)
  {
    PlacePoint();
    return;
  }

  //check if dragging and display
  if (DraggingGroup == true && MenuOpen == false && ToolsMenuOpen == false)
  {
    for (int q=0; q != SelectedPointsCounter; q++)
    {  
      LEDIcons[GroupedPoints[q]].xpos =  mouseX + ((LEDIcons[GroupedPoints[q]].xCoord*CellSpacing) - LowestX) + (LEDIcons[GroupedPoints[q]].bSize/2);
      LEDIcons[GroupedPoints[q]].ypos =  mouseY + ((LEDIcons[GroupedPoints[q]].yCoord*CellSpacing) - LowestY) + (LEDIcons[GroupedPoints[q]].bSize/2);
    }
  } else if (DraggingPoint == true) //if dragging, display drag and set draw() to loop til done dragging
  {  
    //factors in translate()
    LEDIcons[SelectedPoint].xpos = mouseX-(OffsetVarX*CellSpacing);
    LEDIcons[SelectedPoint].ypos = mouseY -(OffsetVarY * CellSpacing);
  }
  //end dragging

    if (MenuOpen == true)
  {
    textAlign(LEFT); 
    fill(100);
    rect(MenuXpos, MenuYpos, 160, 75);
    fill(70);    
    rect(MenuXpos, MenuYpos+25, 160, 25); 
    // rect(MenuXpos, MenuYpos+75, 160, 25);  

    fill(255);
    textSize(12);
    text("Delete Before Point "+(MenuOpenedIcon+1), MenuXpos+10, MenuYpos+15);     
    text("Delete After Point "+(MenuOpenedIcon+1), MenuXpos+10, MenuYpos+40);
    text("Close Menu", MenuXpos+10, MenuYpos+65);
  } else if (ToolsMenuOpen == true)
  {
    textAlign(LEFT); 
    fill(100);
    rect(MenuXpos, MenuYpos, 160, 175); //was 125
    fill(70);    
    rect(MenuXpos, MenuYpos+25, 160, 25); 
    rect(MenuXpos, MenuYpos+75, 160, 25);  
    rect(MenuXpos, MenuYpos+125, 160, 25);      
    fill(255);
    textSize(12);
    text("Group Select", MenuXpos+10, MenuYpos+15);     
    text("Move Group", MenuXpos+10, MenuYpos+40);
    text("Copy Group", MenuXpos+10, MenuYpos+65);
    text("Delete Group", MenuXpos+10, MenuYpos+90);   
    text("Rotate Group CW", MenuXpos+10, MenuYpos+115); 
    text("Rotate Group CCW", MenuXpos+10, MenuYpos+140);    
    text("Close Menu", MenuXpos+10, MenuYpos+165);
  }

  //Draws Selection Box
  if (EnableGroupSelect == true && SelectPointInit == true) 
  {
    fill(0, 0, 0, 0);
    strokeWeight(2);
    stroke(255, 0, 0);

    int TempX = 0;
    int TempY = 0;     
    int TempXb = 0;
    int TempYb = 0;   

    if (SelectBoxX > mouseX) {
      TempX = mouseX;//SelectBoxX;
      TempXb = SelectBoxX - mouseX;
      SelectBoxW = TempXb;
      SelectBoxXpos = TempX;
    } else {
      TempX = SelectBoxX;
      TempXb =  mouseX - SelectBoxX;
      SelectBoxW = TempXb;
      SelectBoxXpos = SelectBoxX;
    }  
    if (SelectBoxY > mouseY) {
      TempY = mouseY;
      TempYb =   SelectBoxY - mouseY;
      SelectBoxH = TempYb;   
      SelectBoxYpos = TempY;
    } else {
      TempY =  SelectBoxY;
      TempYb = mouseY - SelectBoxY;
      SelectBoxH = TempYb;
      SelectBoxYpos = SelectBoxY;
    }  
    stroke(0, 255, 0); //draw selection rectangle
    rect(TempX, TempY, TempXb, TempYb);
  }

  //translations and scrollbar displays last
  translate(-(OffsetVarX*CellSpacing), -(OffsetVarY * CellSpacing));

  GridXScroll.displayOnGridWindow();
  GridYScroll.display();
}//end draw() func

//==================================================================================

void PlacePoint()
{
  int testX = 0;
  int testY = 0;

  CoordX = round((mouseX / CellSpacing))-OffsetVarX;
  CoordY = round((mouseY / CellSpacing))-OffsetVarY;
  if (CoordX < 2 || CoordY < 2) return; //don't place on outer edge with labels

  println("PlacePoint() with "+CoordX+", "+CoordY);

  //run autosave function now before changes
  if (cAutoSaveEnabled == true && DragToPlaceEnabled == false)    RunRollingAutoSave(); //if not the other methods do autosave.

  if (DraggingGroup == true)
  {
    DraggingGroup = false;
    //check if any overlap
    for (int x=0; x != SelectedPointsCounter; x++)     
    {
      SelectedPoint = GroupedPoints[x];  
      CoordX = round((LEDIcons[SelectedPoint].xpos / CellSpacing))+OffsetVarX;
      CoordY = round((LEDIcons[SelectedPoint].ypos / CellSpacing))+OffsetVarY;   

      for (int q=0; q != IconCounter; q++) 
      {    
        boolean TempFlag = false;
        //is q == to any of the IDs on the list?
        //set the flag if it is
        for (int n=0; n != SelectedPointsCounter; n++) 
        {
          if (GroupedPoints[n] == q) TempFlag = true;
        }//end n for()

        if (LEDIcons[q].over(CoordX, CoordY) && TempFlag == false) //check if over() and exclude the points being dragged from being checked
        {
          //if a dragging point is over another point, even itself
          //there was a point being dragged that attempted to be dropped onto of a non-dragging point
          println("Can Not Drop, Point Already There "+q+" :"+SelectedPoint);

          DraggingGroup = true;
          redraw();
          return;
        }//end over() if()
      } //end q for()
    }//end x for()

    //no points overlap 
    for (int q=0; q != SelectedPointsCounter; q++)
    {  
      SelectedPoint = GroupedPoints[q];    
      CoordX = round((LEDIcons[SelectedPoint].xpos / CellSpacing))+OffsetVarX;
      CoordY = round((LEDIcons[SelectedPoint].ypos / CellSpacing))+OffsetVarY; 

      testX = (CoordX * CellSpacing)+(CellSpacing/2);
      testY = (CoordY * CellSpacing)+(CellSpacing/2);
      
      LEDIcons[SelectedPoint].xpos = testX;
      LEDIcons[SelectedPoint].ypos = testY;
      LEDIcons[SelectedPoint].xCoord = CoordX;
      LEDIcons[SelectedPoint].yCoord = CoordY;
  } 
    println("Group Placed");
    noLoop();
    return;
  } //end if DraggingGroup

  //else place a point

  fill(CoordColor); //fill the coordinate with color, defined at top

  //println("X: " +mouseX+" - Y: "+mouseY); //make shows prints X - Y coordinates  

  CoordX = round((mouseX / CellSpacing))-OffsetVarX;
  CoordY = round((mouseY / CellSpacing))-OffsetVarY;

  testX = (CoordX * CellSpacing)+(CellSpacing/2);
  testY = (CoordY * CellSpacing)+(CellSpacing/2); 

  //duplicated for use with delete before functions  
  for (int q = 0; q != IconCounter; q++)  
  {
    if (LEDIcons[q].over(CoordX, CoordY) && LEDIcons[q].Enabled == true)
    {
      if (DragToDraw == true) return; // don't allow a move point if Drag Drawing
      println("Point Already There");
      DraggingPoint = true;
      SelectedPoint = q;
      loop();
      return;
    }
  } //end for()
  //end duplication

    //println("Coord X: "+round((mouseX / CellSpacing))+" Y: "+round((mouseY / CellSpacing)));

  redraw(); //displays new point, do it here in case of return

  for (int q = 0; q != IconCounter; q++)  
  {
    if (LEDIcons[q].Enabled == false)
    {
      LEDIcons[q] = new LEDgraphic(q, testX, testY, CoordX, CoordY, (int)(CellSpacing*0.85));
      LEDIcons[q].display();
      return;
    } //end if()
  } //end for() 

  if (IconCounter >= SelectSliders[0].Value)
  {
    println("Maximum LED Amount Reached"); 
    redraw();
    return;
  }

  //else never found an open ID#, create new one
  LEDIcons[IconCounter] = new LEDgraphic(IconCounter, testX, testY, CoordX, CoordY, (int)(CellSpacing*0.85));
  LEDIcons[IconCounter].display();
  IconCounter++;
} //end func

//==================================================================================

void UpdateGridCells()
{
  cellWidth = SelectSliders[2].Value;
  CellSpacing = SelectSliders[1].Value;
  UserCellSpacing= SelectSliders[1].Value;

  SelectSliders[3].Maximum = cellWidth;
  SelectSliders[4].Maximum = cellWidth;         

  GridXScroll.Maximum = cellWidth/2;
  GridYScroll.Maximum = cellWidth/2;

  println("SCROLL SET TO MAX: "+cellWidth);

  for (int q=0; q != IconCounter; q++)
  {   
    LEDIcons[q].xpos = (LEDIcons[q].xCoord * CellSpacing)+(CellSpacing/2);
    LEDIcons[q].ypos = (LEDIcons[q].yCoord * CellSpacing)+(CellSpacing/2);    
    LEDIcons[q].bSize = (int)(CellSpacing*0.85);
  }

  OffsetVarX = 0;
  OffsetVarY = 0;         
  ForceRefreshGrid(); //would just want to do a redraw() on the grid window but it doesn't work
}

//==================================================================================

void ForceRefreshGrid()
{
  println("Grid Window Refreshed");
  //seems have to do it this way in order to call redraw from the Control Window
  redraw();
}