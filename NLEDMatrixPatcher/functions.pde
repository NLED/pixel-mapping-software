
void RotateGroup(int passedAngle)
{
	println("RotateGroup() with "+passedAngle);
/*
//sample code from internet
float x_old = p.x; float y_old = p.y;
p.x = x_old * cos(a) - y_old * sin(a);
p.y = x_old * sin(a) + y_old * cos(a);

float tempFloatX = LEDIcons[q].xCoord; 
float tempFloatY = LEDIcons[q].yCoord;
float a = 1.5708;

LEDIcons[q].xCoord = tempFloatX * cos(a) - tempFloatY * sin(a);
LEDIcons[q].yCoord = tempFloatX * sin(a) + tempFloatY * cos(a);
*/

	LowestX = 10000;
	LowestY = 10000; 

	float tempFloatX = 0;
	float tempFloatY = 0;

	float a = radians(passedAngle);//1.5708;

	float cosVal = cos(a); //save values since they stay the same
	float sinVal = sin(a);

	for (int q=0; q != SelectedPointsCounter; q++) 
	{   
		tempFloatX = LEDIcons[GroupedPoints[q]].xCoord;
		tempFloatY = LEDIcons[GroupedPoints[q]].yCoord;

		//println("START : "+GroupedPoints[q]+" : "+LEDIcons[GroupedPoints[q]].xCoord+", "+LEDIcons[GroupedPoints[q]].yCoord);

		//LEDIcons[GroupedPoints[q]].xCoord = int((float)(tempFloatX * cos(a) - tempFloatY * sin(a)));
		//LEDIcons[GroupedPoints[q]].yCoord = int((float)(tempFloatX * sin(a) + tempFloatY * cos(a)));
		if (passedAngle == 90)
		{
			LEDIcons[GroupedPoints[q]].xCoord = int(ceil(tempFloatX * cosVal - tempFloatY * sinVal));
			LEDIcons[GroupedPoints[q]].yCoord = int(ceil(tempFloatX * sinVal + tempFloatY * cosVal));
		} 
		else if (passedAngle == 270)
		{
			LEDIcons[GroupedPoints[q]].xCoord = int(floor(tempFloatX * cosVal - tempFloatY * sinVal));
			LEDIcons[GroupedPoints[q]].yCoord = int(floor(tempFloatX * sinVal + tempFloatY * cosVal));
		} 
		else println("ERROR WRONG ANGLE ENTERED");

		//println("END: "+LEDIcons[GroupedPoints[q]].xCoord+", "+LEDIcons[GroupedPoints[q]].yCoord);

		if (LEDIcons[GroupedPoints[q]].xCoord < LowestX)  LowestX = LEDIcons[GroupedPoints[q]].xCoord;
		if (LEDIcons[GroupedPoints[q]].yCoord < LowestY)  LowestY = LEDIcons[GroupedPoints[q]].yCoord;
		//its dragging which will update the xpos and ypos
	}

	//println(LowestX+" : "+LowestY);

	LowestX = LowestX*CellSpacing; //set new lowest values
	LowestY = LowestY*CellSpacing;

	DraggingGroup = true;
	loop();
} //end func 

//==================================================================================

void InitMoveGroup()
{
	LowestX = 10000;
	LowestY = 10000; 
	for (int q=0; q != SelectedPointsCounter; q++) 
	{  
		if (LEDIcons[GroupedPoints[q]].xpos < LowestX)  LowestX = LEDIcons[GroupedPoints[q]].xpos;
		if (LEDIcons[GroupedPoints[q]].ypos < LowestY)  LowestY = LEDIcons[GroupedPoints[q]].ypos;
	}    
	DraggingGroup = true;
	loop(); //start looping draw() til icons are placed
}

//==================================================================================

void RunCopyGroup()
{
	println("RunCopyGroup()");
	//lowest ID is the first to get a duplicated
	int testX = 0;
	int testY = 0;
	int i =0;

	int CountPlaced = 0;
	
	// for (int q=0; q != IconCounter; q++) println(LEDIcons[q].Enabled);

	for (int q=0; q != SelectedPointsCounter; q++)
	{    
		testX = (LEDIcons[GroupedPoints[q]].xCoord * CellSpacing)+(CellSpacing/2);
		testY = (LEDIcons[GroupedPoints[q]].yCoord * CellSpacing)+(CellSpacing/2);   

		//close needs an else, how to make a new one if none is found using icon counter?
		for (i = 0; i != IconCounter; i++)  
		{

			if (LEDIcons[i].Enabled == false)
			{
				println("R: "+i+" and "+q);
				LEDIcons[i] = new LEDgraphic(i, testX, testY, LEDIcons[GroupedPoints[q]].xCoord, LEDIcons[GroupedPoints[q]].yCoord, (int)(CellSpacing*0.85));
				LEDIcons[i].display();
				
				GroupedPoints[q] = i;
				
				i = 123456;
				break;
			} //end if()
		} //end for() 

		if(i != 123456) //if its that number, it found an open slot and don't run this
		{
			println("Using: "+IconCounter+"   "+q);
			LEDIcons[IconCounter] = new LEDgraphic(IconCounter, testX, testY, LEDIcons[GroupedPoints[q]].xCoord, LEDIcons[GroupedPoints[q]].yCoord, (int)(CellSpacing*0.85));
			LEDIcons[IconCounter].display(); 
			
			GroupedPoints[q] = IconCounter; //update GroupSelection array with new value
			IconCounter++; 
			if(IconCounter > SelectSliders[0].Value) { IconCounter--; break;} 
			CountPlaced++;
			//println("Copy Over Maximum, Double check Pixel amount slider");
		}

		println("Ran with "+IconCounter+" at "+testX+" : "+testY);
	} //end for()

	SelectedPointsCounter = CountPlaced; //this makes sure it can't copy greater than user set maximim amount of pixels
	
	if(SelectedPointsCounter > 0) InitMoveGroup();  //now initialize group move function
} //end func()

void RunGroupSelection()
{
	GroupedPoints = new int[0];   //create empty array of a small size, need to start it at 0 and not 1 because of GroupedPoints.length
	SelectedPointsCounter = 0;

	//  println(SelectBoxXpos+" : "+SelectBoxYpos+" : "+SelectBoxW+" : "+ SelectBoxH);
	for (int q=0; q != IconCounter; q++)
	{
		if (LEDIcons[q].xpos >= SelectBoxXpos && LEDIcons[q].xpos <= SelectBoxXpos+SelectBoxW && LEDIcons[q].ypos >= SelectBoxYpos && LEDIcons[q].ypos <= SelectBoxYpos+SelectBoxH)      
		{
			if(LEDIcons[q].Enabled == true)
			{
				GroupedPoints = expand(GroupedPoints, GroupedPoints.length+1); //expand the array as needed
				println("Icon "+q+" is within bounds");
				GroupedPoints[SelectedPointsCounter] = q;
				SelectedPointsCounter++;
			}
		}
	}
	redraw();
} //end func

//==================================================================================

void WriteCustomPatchFile()
{
	println("WriteCustomPatchFile()");

	//writes Coordinates in order, Channel Amount tab LED Amount tab Increment/All newline X1 tab Y1 newline X2 tab Y2 etc, no spaces
	strs = new ArrayList(); // reset array list.... 
	int sLines=0;       
	String BuildLine = SelectSliders[0].Value+"\t"+SelectSliders[1].Value+"\t"+SelectSliders[2].Value+"\t"+width+"\t"+height; //create header line

	strs.add(BuildLine);    //write header line to Array list

	for (int i=0;i != IconCounter;i++) 
	//for (int i=0; i != SelectSliders[0].Value; i++)   //only save the amount of pixels that is expected!
	{   
		//again, these are saved as -1, -1 to make up for grid borders
		if (LEDIcons[i].Enabled == true)    BuildLine = (LEDIcons[i].xCoord-1) + "\t"+(LEDIcons[i].yCoord-1);
		else BuildLine = "1\t1"; //if not enabled save point at 1, 1. May overlap but no where else would be easy to store them

		strs.add( BuildLine);
	}   

	String[] lines = new String[strs.size()]; 

	for (int q=0; q != strs.size (); q++)  
	{
		lines[q]=(String) strs.get(q);
	} 
	String[]  ExtensionStripped = split(SelectedFile, '.');
	saveStrings(ExtensionStripped[0]+".txt", lines);  
	println("File Generated: "+ExtensionStripped[0]+".txt");
} //end WriteCustomPatchFile()

//==================================================================================

void RunRollingAutoSave()
{
	println("Running AutoSave");
	SelectedFile = "autosave/autosavefile-"+rollingSaveNum;
	SaveLayoutFile();
	if (rollingSaveNum == cMaxAutoSaves) rollingSaveNum = 1;
	else rollingSaveNum++;
}

//==================================================================================

void SaveLayoutFile()
{
	WriteCustomPatchFile();
}
//==================================================================================

void LoadLayoutFile()
{
	String[] lines = loadStrings(SelectedFile); //divides the lines
	int sLines=0;  
	String[] WorkString = new String[3]; //used to divide the lines into tab

	WorkString = split(lines[0], '\t');

	SelectSliders[0].Value = int(WorkString[0]); //channels
	if (SelectSliders[0].Value >  SelectSliders[0].Maximum)  SelectSliders[0].Maximum =  SelectSliders[0].Value;

	SelectSliders[1].Value = int(WorkString[1]); //cell size
	if (SelectSliders[1].Value >  SelectSliders[1].Maximum)  SelectSliders[1].Maximum =  SelectSliders[1].Value;  

	SelectSliders[2].Value = int(WorkString[2]); //cells
	if (SelectSliders[2].Value >  SelectSliders[2].Maximum)  SelectSliders[2].Maximum =  SelectSliders[2].Value;  

	try 
	{
		int tempW = int(WorkString[3]); //grid window width
		int tempH = int(WorkString[4]); //grid window height

		//insets get ran in Setup()
		frame.setSize(tempW+(insets.left+insets.right), tempH+(insets.top+insets.bottom));	
		println("Should have resized to "+tempW+" : "+tempH);
	}
	catch(Exception e) { 
		println("Window Size not loaded, may be older file version");
	}

	IconCounter = 0;

	int testX;
	int testY;

	for (int i = 1; i != lines.length; i++)
	{
		WorkString = split(lines[i], '\t');
		testX = (int(WorkString[0]) * CellSpacing)+(CellSpacing/2);
		testY = (int(WorkString[1]) * CellSpacing)+(CellSpacing/2); 

		//Loads the Coord as +1, +1, to make up for border area with column/row details
		//	saves it as -1, -1, so lowest coord is 1,1 but in software it thinks its 2,2
		LEDIcons[IconCounter] = new LEDgraphic(IconCounter, testX, testY, int(WorkString[0])+1, int(WorkString[1])+1, (int)(CellSpacing*0.85));
		IconCounter++;
	}

	UpdateGridCells();
	println("Done Loading");
	redraw();
}//end func

