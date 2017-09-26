
void FunctionRightClick()
{
    //if over an Icon, open menu, will that work???
    CoordX = round((mouseX / CellSpacing))-OffsetVarX;
    CoordY = round((mouseY / CellSpacing))-OffsetVarY;   

    println("Right Click");

    for (int q=0; q != IconCounter; q++)
    {
      if (LEDIcons[q].over(CoordX, CoordY))
      {
        MenuOpen = true;
        ToolsMenuOpen = false;  

        EnableGroupSelect = false; //make sure group drag or select is not running
        MenuOpenedIcon = q; //used for deleting n such
        MenuXpos = LEDIcons[q].xpos; //set menu position
        MenuYpos = LEDIcons[q].ypos;
        redraw();
        return;
      }
    } //end for()
    //else an icon was not selected, open tool menu
    MenuOpen = false;
    ToolsMenuOpen = true;

    MenuXpos = mouseX; //set menu position
    MenuYpos = mouseY;
    EnableGroupSelect = false;
    redraw();
    return;
}

void mousePressed()
{
  if (mouseButton == RIGHT)
  {
	FunctionRightClick();
  } 
  else
  {
    //LEFT Mouse Pressed

    //check sliders before rest
    if (GridXScroll.over(mouseX, mouseY))
    {
      println("Selected Scrollbar X");
      SliderSet=0;
      GridXScroll.Dragging=true;
      GlobalDragging=true;
      return;
    }

    if (GridYScroll.over(mouseX, mouseY))
    {
      println("Selected Scrollbar Y");
      SliderSet=1;
      GridXScroll.Dragging=true;
      GlobalDragging=true;
      return;
    }  

    //========= Scrollbar sliders checked, continue ==========

    //factors the translate() values
    int tempMouseX = mouseX - (OffsetVarX*CellSpacing);
    int tempMouseY = mouseY - (OffsetVarY*CellSpacing);

    //check menus first
    if (MenuOpen == true)
    {
      //menu is open 

      //scans menu looking for list number that was pressed
      int i = 0;
      for (i = 0; i != 3; i++)
      {
        if (tempMouseX >= MenuXpos && tempMouseX <= MenuXpos+160 && tempMouseY >= MenuYpos+(i*25) && tempMouseY <= MenuYpos+25+(i*25))    break;
      }

      switch(i) //uses list number to call function
      {
      case 0:
        println("Menu Item 1 - Delete Before - "+MenuOpenedIcon);
        RunRollingAutoSave();
        for (int q = 0; q != MenuOpenedIcon; q++)  LEDIcons[q].Enabled = false;  
        MenuOpen = false;
        break;
      case 1:
        println("Menu Item 2 - Delete After - "+MenuOpenedIcon);
        RunRollingAutoSave();
        for (int q = (MenuOpenedIcon+1); q != IconCounter; q++)  LEDIcons[q].Enabled = false;
        MenuOpen = false;
        break; 
      case 2:
        println("Close Menu");      
        MenuOpen = false;    
        break;   
      case 3:
        println("No item pressed"); 
        MenuOpen = false;          
        break;
      } //end switch
      redraw();
    } //end else
    else if (ToolsMenuOpen == true)
    {    
      //scans menu looking for list number that was presses
      int i = 0;
      for (i = 0; i != 7; i++)
      {
        if (tempMouseX >= MenuXpos && tempMouseX <= MenuXpos+160 && tempMouseY >= MenuYpos+(i*25) && tempMouseY <= MenuYpos+25+(i*25))    break;
      }

      switch(i) //uses list number to call function
      {
      case 0:
        println("Menu Item 1 - Group Select");
        EnableGroupSelect = true;
        SelectPointInit = false;
        MenuOpen = false;
        SelectBoxX = mouseX;
        SelectBoxY = mouseY;
        //      SelectPointInit = true;
        break;
      case 1:
        println("Menu Item 2 - Move Group"); 
        RunRollingAutoSave();
        //updates position for drag handle
        InitMoveGroup();
        break; 
      case 2:
        println("Menu Item 3 - Copy Group");
        RunCopyGroup();
        break;  
      case 3:
        println("Menu Item 4 - Delete Group");
        RunRollingAutoSave();
        for (int q=0; q != SelectedPointsCounter; q++)  LEDIcons[GroupedPoints[q]].Enabled = false;
        break;              
      case 4:
        println("Menu Item 5 - Rotate Group CW");
        RunRollingAutoSave();
        if (DraggingGroup == true) PlacePoint(); //if dragging, place it and pick up again, prevents errors rotating
        RotateGroup(90);
        break;   
      case 5:
        println("Menu Item 6 - Rotate Group CCW");
        RunRollingAutoSave();
        if (DraggingGroup == true) PlacePoint(); //if dragging, place it and pick up again, prevents errors rotating        
        RotateGroup(270);
        break;          
      case 6:
        println("Menu Item 7 - Close Menu");

        break;        
      default:
        println("No item pressed");    
        break;
      } //end switch      
      ToolsMenuOpen = false;   
      return;
    } else if (EnableGroupSelect == true && SelectPointInit == false) 
    {
      SelectBoxX = mouseX;
      SelectBoxY = mouseY;
      SelectPointInit = true;
      println("Selection Box points set");
    } else if (DragToPlaceEnabled == true)
    { 
      println("Starting Drag to Draw");
      RunRollingAutoSave();     
      DragToDraw = true;
      return;
    } else if (EnableGroupSelect == false)  PlacePoint();
  } //end left button else
} //end moused pressed

//==================================================================================

void mouseDragged()
{
  if (GlobalDragging==true) //only check sliders if one is being dragged
  {
    //println("Dragging "+SliderSet);
    switch(SliderSet)
    {
    case 0:
      GridXScroll.move(mouseX, mouseY); 
      GridXScroll.displayOnGridWindow();

      SelectSliders[3].Value = GridXScroll.Value;

      OffsetVarX = -SelectSliders[3].Value;  
      break;

    case 1:
      GridYScroll.move(mouseX, mouseY); 
      GridYScroll.display();

      SelectSliders[4].Value = GridYScroll.Value;	

      OffsetVarY = -SelectSliders[4].Value;	  
      break;
    }//end switch
  }//end if   
  redraw();
} //end mouseDragging

//==================================================================================

void mouseReleased()
{
  GlobalDragging = false;

  if (DragToDraw == true)
  {
    DragToDraw = false;	
    println("UnClicked");
    return;
  }

  if (EnableGroupSelect == true && SelectPointInit == true) 
  {
    println("Box Dragging Ended");
    SelectPointInit = false;
    EnableGroupSelect = false;
    RunGroupSelection();
    loop();
  }

  if (DraggingPoint == true)
  {
    CoordX = round((mouseX / CellSpacing)) - OffsetVarX;
    CoordY = round((mouseY / CellSpacing)) - OffsetVarY;   
    DraggingPoint = false; 

    for (int q=0; q != IconCounter; q++)  //LEDIcons.length
    {
      if (LEDIcons[q].over(CoordX, CoordY))
      {
        println("Can Not Drop, Point Already There");
        LEDIcons[SelectedPoint].xpos = (LEDIcons[SelectedPoint].xCoord * CellSpacing)+(CellSpacing/2);
        LEDIcons[SelectedPoint].ypos = (LEDIcons[SelectedPoint].yCoord * CellSpacing)+(CellSpacing/2);
        //  redraw();
        return;
      }
    }

    if (mouseX <= 0 || mouseX >= width  || mouseY <= 0 || mouseY >= height)
    {
      println("Can't Place Off The Window");      
      LEDIcons[SelectedPoint].xpos = (LEDIcons[SelectedPoint].xCoord * CellSpacing)+(CellSpacing/2);
      LEDIcons[SelectedPoint].ypos = (LEDIcons[SelectedPoint].yCoord * CellSpacing)+(CellSpacing/2);   
      //  redraw();    
      return;
    }
    //if dragging and released, refigure point and update object
    int testX = (CoordX * CellSpacing)+(CellSpacing/2);
    int testY = (CoordY * CellSpacing)+(CellSpacing/2); 
    LEDIcons[SelectedPoint] = new LEDgraphic(LEDIcons[SelectedPoint].ChanID, testX, testY, CoordX, CoordY, (int)(CellSpacing*0.85));
    // redraw(); //was outside this, but only this section reaches the end anyway
  }
  redraw();
} //end mouseReleased()

//==================================================================================

void keyPressed()
{
  println(int(key)); 

  if (key == CODED) 
  {
    if (keyCode == UP)  
    {
      if (OffsetVarY != 0) OffsetVarY++;    

      SelectSliders[3].Value = -OffsetVarY;
      GridYScroll.Value = -OffsetVarY;
    }
    if (keyCode == DOWN) 
    {
      if (OffsetVarY != -(cellWidth-1)) OffsetVarY--;

      SelectSliders[3].Value = -OffsetVarY;
      GridYScroll.Value = -OffsetVarY;
    }
    if (keyCode == RIGHT)  
    {
      if (OffsetVarX != -(cellWidth-1)) OffsetVarX--;
      SelectSliders[4].Value = -OffsetVarX;
      GridXScroll.Value = -OffsetVarX;
    }
    if (keyCode == LEFT) 
    {
      if (OffsetVarX != 0) OffsetVarX++;
      SelectSliders[4].Value = -OffsetVarX;
      GridXScroll.Value = -OffsetVarX;
    }
    if (keyCode == SHIFT) 
    {
      DragToPlaceEnabled =! DragToPlaceEnabled;
      Buttons[6].Selected = DragToPlaceEnabled;
      Buttons[6].display();
    }	
    redraw(); //redraw new Translate
  }//end if coded

  //==================================================================================

  if(key == 32) FunctionRightClick(); //Spacebar simulates right-mouse click
  
  if (key == 26) //ctrl z, UNDO
  {
    println("Running Undo Function - Loading Autosave"); 

    // println("OLD AUTOSAVE ID: "+rollingSaveNum);
    if (rollingSaveNum == 1) rollingSaveNum = cMaxAutoSaves;
    else rollingSaveNum--;
    // println("NEW AUTOSAVE ID: "+rollingSaveNum);

    SelectedFile = "autosave/autosavefile-"+rollingSaveNum+".txt";
    LoadLayoutFile();
  }//end key if
}

