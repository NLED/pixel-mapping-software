//functions and setup for Control Window

public class PFrame extends JFrame {
	public PFrame() {
		setBounds(100, 100, 500,400);
		s = new secondApplet();
		add(s);
		s.init();
		show();
		this.setResizable(false);
	}
}

public class secondApplet extends PApplet {
	public void setup() {
		// background(127);
		Buttons = new Button[11];
		Buttons[0] = new Button("Save File", 10, 40, 120, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);
		Buttons[1] = new Button("Load File", 140, 40, 120, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);
		Buttons[2] = new Button("Update Grid", 170, 230, 130, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);       
		Buttons[3] = new Button("Reset Icons", 10, 310, 130, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);    
		Buttons[4] = new Button("Reset Position", 10, 270, 130, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);    
		Buttons[5] = new Button("Fit Grid To Window",310, 230, 170, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);    
		Buttons[6] = new Button("Drag to Place", 340, 40, 140, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, true, false);    
		Buttons[7] = new Button("EULA", 425, 10, 60, 20, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);    
		Buttons[8] = new Button("Website",10, 10, 60, 20, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);  
		//new
		Buttons[9] = new Button("Save Patch",10, 80, 120, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);  
		Buttons[10] = new Button("Load Image",140, 80, 120, 30, ColButtonsBG, ColButtonsHL, ColButtonsOut, false, false);  
		
		SelectSliders = new SliderBar[5];
		SelectSliders[0] = new SliderBar(140, 120, 230, 20, 8, 0, 340, color(200), color(0), ColButtonsOut, color(0), true, false); //channels
		SelectSliders[1] = new SliderBar(140, 160, 230, 20, cCellSpacing, 0, 80, color(200), color(0), ColButtonsOut, color(0), true, false); //cell size
		SelectSliders[2] = new SliderBar(140, 200, 230, 20, 32, 0, 256, color(200), color(0), ColButtonsOut, color(0), true, false); //cells

		SelectSliders[3] = new SliderBar(260, 280, 200, 20, 0, 0, 32, color(255), color(0), color(200, 200, 200), color(0), true, false); //X
		SelectSliders[4] = new SliderBar(260, 310, 200, 20, 0, 0, 32, color(255), color(0), color(200, 200, 200), color(0), true, false); //Y
		
		TextFields = new TextField[3];
		TextFields[0] = new TextField("Enter #", 380, 120, 80, 25, color(255), color(200, 40, 40), true, false);
		TextFields[1] = new TextField("Enter #", 380, 160, 80, 25, color(255), color(200, 40, 40), true, false);
		TextFields[2] = new TextField("Enter #", 380, 200, 80, 25, color(255), color(200, 40, 40), true, false);

		frameRate(10);
	}

	public void draw() 
	{
		background(cBackgroundColor);
		fill(255);
		textSize(18);
		textAlign(LEFT); 
		text("NLED Matrix Patcher Software v.1f", 100, 20);   
		textSize(14);  

		text("X Position: "+ SelectSliders[3] .Value, SelectSliders[3].xpos -100, SelectSliders[3].ypos+(SelectSliders[3].Slheight)); 
		text("Y Position: "+ SelectSliders[4] .Value, SelectSliders[4].xpos -100, SelectSliders[4].ypos+(SelectSliders[4].Slheight)); 
		
		textAlign(RIGHT);  
		text("Total Pixels: "+SelectSliders[0].Value, SelectSliders[0].xpos -20, SelectSliders[0].ypos+(SelectSliders[0].Slheight));
		text("Cell SIze: "+SelectSliders[1].Value, SelectSliders[1].xpos -20, SelectSliders[1].ypos+(SelectSliders[1].Slheight)); 
		text("Cells: "+SelectSliders[2].Value, SelectSliders[2].xpos -20, SelectSliders[2].ypos+(SelectSliders[2].Slheight)); 

		textAlign(CENTER);
		text("Type in Value\n& Press Enter:", 420, 90);
		text("www.NLEDShop.com/nledpatcher      www.NLEDShop.com/nledmatrix", 250, 360);
		textAlign(LEFT);   
		text("Icons Placed: "+IconCounter,10,250);

		for (int i=0;i != Buttons.length;i++) Buttons[i].display();
		for (int i=0;i !=  TextFields.length;i++)  TextFields[i].display();
		for (int i=0;i !=  SelectSliders.length;i++)  SelectSliders[i].display();

		if (GlobalDragging==true) //only check sliders if one is being dragged
		{
			switch(SliderSet)
			{
			case 0:
				if (SelectSliders[SelectedSlider].Dragging==true) //only display while Dragging is set
				{ 
					SelectSliders[SelectedSlider].move(mouseX, mouseY); 
					SelectSliders[SelectedSlider].display();

					if (SelectedSlider == 3) 
					{
						OffsetVarX = -SelectSliders[SelectedSlider].Value;
						ForceRefreshGrid();
					}
					if (SelectedSlider == 4) 
					{
						OffsetVarY = -SelectSliders[SelectedSlider].Value;
						ForceRefreshGrid();
					}          
				}   
				break;
			}//end switch
		}//end if
	}//end draw

	void fileSelected(File selection) 
	{
		if (selection == null) {
			println("Window was closed or the user hit cancel.");
		} 
		else {
			println("User selected " + selection.getAbsolutePath());
			SelectedFile = selection.getAbsolutePath();

			switch(FileBrowserAction)  
			{
			case 0: //generate
				WriteCustomPatchFile();
				break;
			case 1: //save Layout
				SaveLayoutFile();
				break;
			case 2: //Load Layout
				LoadLayoutFile();
				break;
			case 3: //Load Image
				UserImage = loadImage(SelectedFile);
				ForceRefreshGrid(); //would just want to do a redraw() on the grid window but it doesn't work   
				break;		
			}//end switch
		}//end else
	}//end func

	public void mouseReleased()
	{
		if (GlobalDragging==true)
		{
			GlobalDragging=false;

			println("Slider Released");
			switch(SliderSet)
			{
			case 0:
				SelectSliders[SelectedSlider].Dragging=false;
				break;
			}
		}
	}

	public void mousePressed() 
	{
		println("Second Window - X: " +mouseX+" - Y: "+mouseY); //make shows pritns X - Y coordinates  

		for (int q=0; q != SelectSliders.length;q++)  
		{
			if (SelectSliders[q].over(mouseX, mouseY))
			{
				println("Selected Slider: "+q);
				SliderSet=0;
				SelectedSlider=q;
				SelectSliders[q].Dragging=true;
				GlobalDragging=true;
			}
		}

		for (int i=0;i != TextFields.length;i++)
		{
			if (TextFields[i].over(mouseX, mouseY))
			{
				TextFields[SelectedTextField].Selected = false;
				SelectedTextField = i;
				TextFieldActive = true;
				TextFields[SelectedTextField].Label = "";
				TextFields[SelectedTextField].Selected = true;
				println("Text Field "+i);
			}
		}

		for (int i=0;i != Buttons.length;i++)
		{
			if (Buttons[i].over(mouseX, mouseY))
			{
				//certain buttons if already selected, stay selected(increment, all)
				Buttons[i].Selected=! Buttons[i].Selected;

				println("Button"+i);
				switch(i)
				{
				case 0: //save
					FileBrowserAction = 1;
					selectOutput("Select a file to Save To:", "fileSelected");
					break;
				case 1: //load
					FileBrowserAction = 2;
					selectInput("Select a file to Load:", "fileSelected");
					break;      
				case 2: //Update Cells
					UpdateGridCells();
					break;   
				case 3://Reset Icons
					IconCounter = 0;
					ForceRefreshGrid(); //would just want to do a redraw() on the grid window but it doesn't work     
					break;
				case 4://Reset Position
					OffsetVarX = 0;
					OffsetVarY = 0;         
					ForceRefreshGrid(); //would just want to do a redraw() on the grid window but it doesn't work     
					break;          
				case 5://Fit to Window
					//so get the size of the grid window, divide it by cellwidth or something
					SelectSliders[1].Value = (PrevWidth-40)/(cellWidth+2);
					//println(PrevWidth/cellWidth);
					UpdateGridCells();
					break;            
				case 6://Drag to Place Toggle
					if(Buttons[i].Selected == true)  DragToPlaceEnabled = true;
					else   DragToPlaceEnabled  = false;
					break;
				case 7: //open EULA
					link("http://creativecommons.org/licenses/by/4.0/legalcode");
					break;
				case 8: //open Website
					link("http://www.NLEDshop.com/nledmatrix");
					break; 
				case 9: //save Patch
					FileBrowserAction = 1;
					selectOutput("Select a file to Save To:", "fileSelected");
					break; 
				case 10: //load Image
					FileBrowserAction = 3;
					selectInput("Select a file to Load:", "fileSelected");
					break;   
				}//end switch
			}//end if
		}//end for
	}//end mousepressed

	//================================================================================== 

	public void keyPressed()
	{
		println(int(key)); 

		if(TextFieldActive == true)
		{
			if(key == ENTER || key == RETURN)
			{
				TextFieldActive = false;
				TextFields[SelectedTextField].Selected = false;   
				if(int(TextFields[SelectedTextField].Label) > SelectSliders[SelectedTextField].Maximum)SelectSliders[SelectedTextField].Maximum = int(TextFields[SelectedTextField].Label);
				SelectSliders[SelectedTextField].Value =  int(TextFields[SelectedTextField].Label);
				return;
			}
			else if (key=='1' || key== '2' || key=='3' || key=='4' || key=='5' || key=='6' || key=='7' || key=='8' || key=='9' || key=='0')
			TextFields[SelectedTextField].Label =  TextFields[SelectedTextField].Label + char(key);
			TextFields[SelectedTextField].display();
			return;
		}
	} 

} //end
