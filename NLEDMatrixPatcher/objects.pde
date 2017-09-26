class Button
{
  String Label;
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int bWidth;
  int bHeight;
  color ColBG;
  color ColHL;
  color ColOut;  
  boolean Toggle;
  boolean Selected;

  Button(String iLabel, int ixpos, int iypos, int ibWidth, int ibHeight, color iColBG, color iColHL, color iColOut, boolean iToggle, boolean iSelected)
  {
    Label = iLabel; 
    xpos = ixpos;
    ypos = iypos;  
    bWidth = ibWidth;
    bHeight = ibHeight;
    ColBG = iColBG;
    ColHL = iColHL;
    ColOut = iColOut;
    Toggle = iToggle;
    Selected = iSelected;
  }

  void display()
  {
    s.strokeWeight(2);
    s.stroke(ColOut);

    if (Selected==true)
    {
      s.fill(ColHL); 
      s.rect(xpos, ypos, bWidth, bHeight, bHeight/4);
    }
    else       
    {
      s.fill(ColBG);
      s.rect(xpos, ypos, bWidth, bHeight, bHeight/4);
    }
    //adjust stroke to on higligh and invert text color

    s.fill(255);
    s.textSize((bHeight/1.75));
    s.text(Label, xpos+((bWidth - s.textWidth(Label))/2), ypos+((bHeight-(s.textAscent()+s.textDescent()))/2), bWidth, bHeight);

    s.noStroke();
    if (Toggle==false) Selected = false;
  }

  boolean over(int uX, int uY) 
  {
    if ( uX >= xpos && uX <= xpos+bWidth && uY >= ypos && uY <= ypos+bHeight) 
    {      
      return true;
    } 
    else {
      return false;
    }
  }
} 

//=======================================

class LEDgraphic
{
  int ChanID;
  int IDNumber;
  int xpos; // display rect xposition  
  int ypos ; // displayrect yposition
  int xCoord;
  int yCoord;
  int bSize;
//  color cColor;
  boolean Enabled;

  LEDgraphic(int iChanID, int ixpos, int iypos, int ixCoord, int iyCoord, int ibSize)//, color icColor)
  {
    ChanID=iChanID; 
    xpos = ixpos;
    ypos = iypos;  
    yCoord = iyCoord;
    xCoord = ixCoord;
    bSize = ibSize;
   // cColor = icColor;
   Enabled = true;
  }

  void display()
  {   
   // float myRed = cColor >> 16 & 0xFF; //convert colors to 8-bit
    //float myGreen = cColor >> 8 & 0xFF;
   // float myBlue = cColor & 0xFF;  

    noStroke();
    fill(LEDIconColor);
    ellipse(xpos, ypos, bSize, bSize);

    //fill((255 - myRed), (255 - myGreen), (255 - myBlue)); //inverts color
    fill(255); //white
    textSize((bSize/1.75));

    textAlign(CENTER, CENTER); //centers the text on the ellipse
    text((ChanID+1), xpos, ypos-(bSize/10));
    noStroke();
  }

  void displaySelected()
  {   
    if(Enabled == false) return;
    noStroke();
    fill(255,0,0); //highlight
    ellipse(xpos, ypos, bSize*1.2, bSize*1.2);   
  }

  boolean over(int uX, int uY) 
  { //custom for circles! which are placed on center
    if (uX == xCoord && uY == yCoord) 
    {      
      return true;
    } 
    else {
      return false;
    }
  }

  /*
    if ( uX >= (xpos - (bSize/2)) && uX <= xpos+(bSize/2)&& uY >= (ypos - (bSize/2)) && uY <= ypos+(bSize/2)) 
   {      
   return true;
   } 
   else {
   return false;
   }
   }
   */
}//end class

//=========================================================

class SliderBar
{
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int Slwidth; // single bar Slwidthth
  int Slheight; // rect height
  int Value; 
  int Minimum; 
  int Maximum;
  color BgColor;
  color SlColor;
  color SelColor; 
  color StrokeColor;
  boolean CircleHandle;  
  boolean Dragging;


  //local variables 
  boolean over = false;

  //gotta move the int variables into float variables
  float temp1=Slwidth;
  float temp2=Maximum;
  float temp3=Value;
  float temp4=Minimum;
  float MathVar=0;


  SliderBar(int ixp, int iyp, int iw, int ih, int iValue, int iMin, int iMax, color iBgColor, color iSlColor, color iSelColor, color iStrokeColor, boolean iCircleHandle, boolean iDragging) 
  {   
    xpos = ixp;
    ypos = iyp;  
    Slwidth = iw;
    Slheight = ih;
    Value=iValue;
    Maximum=iMax;
    Minimum=iMin;
    BgColor=iBgColor;
    SlColor=iSlColor;
    SelColor=iSelColor;
    StrokeColor=iStrokeColor;
    CircleHandle=iCircleHandle;     
    Dragging=iDragging;
  }

  void move(int uX, int uY) 
  {
    //this function handles position of the slider's handle

    temp1 = Slwidth;   
    temp3 = Value;
    temp4 = Minimum;

    MathVar = (((uX-xpos) / temp1)-1) *-1; //creates a scale factor based on mouse position 
    //relative to slider position
    MathVar = Maximum - (MathVar*(Maximum-Minimum));   

    if (MathVar > Maximum) { //check so it doesn't drag off the end
      MathVar=Maximum;
    }

    if (MathVar < Minimum) { //check so it doesn't drag off the end
      MathVar=Minimum;
    }  

    Value=int(MathVar); //set the value based on mouse movement
  }


  void display() 
  {
    s.stroke(StrokeColor);
    s.strokeWeight(1);

    //circle handles are displayed differently so there are if/else statements to set it correctly

    s.fill(BgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
    s.rect(xpos, ypos, Slwidth, Slheight);   

    if (CircleHandle==true) temp1 = Slwidth -Slheight;
    else temp1=Slwidth-(Slwidth/20);

    temp2=Maximum;  //move variables into float
    temp3=Value;    //or do they don't compute correctly
    temp4 = Minimum;

    float MathVar;

    if (CircleHandle==true)
      MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + Slheight/2;
    else  
      MathVar = temp1 / (temp2 - temp4) * (temp3-temp4); 
    //MathVar = (SlWidth / (Max / Min) * (Value - Minimum)

    s.fill(color(SelColor)); //draws the Selcolor over the selected area
    s.rect(xpos, ypos, MathVar, Slheight);

    s.fill(SlColor); //places the slider handle
    if (CircleHandle==true)   s.ellipse(xpos+MathVar, ypos+(Slheight/2), Slheight, Slheight); //Circle instead of rectangle
    else   rect((xpos+MathVar), ypos, Slwidth/20, Slheight); //and comment this line for circle
  }

  
   void displayOnGridWindow() 
  {
    stroke(StrokeColor);
    strokeWeight(1);

    //circle handles are displayed differently so there are if/else statements to set it correctly

    fill(BgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
    rect(xpos, ypos, Slwidth, Slheight);   

    if (CircleHandle==true) temp1 = Slwidth -Slheight;
    else temp1=Slwidth-(Slwidth/20);

    temp2=Maximum;  //move variables into float
    temp3=Value;    //or do they don't compute correctly
    temp4 = Minimum;

    float MathVar;

    if (CircleHandle==true)
      MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + Slheight/2;
    else  
      MathVar = temp1 / (temp2 - temp4) * (temp3-temp4); 
    //MathVar = (SlWidth / (Max / Min) * (Value - Minimum)

    fill(color(SelColor)); //draws the Selcolor over the selected area
    rect(xpos, ypos, MathVar, Slheight);

    fill(SlColor); //places the slider handle
    if (CircleHandle==true)   ellipse(xpos+MathVar, ypos+(Slheight/2), Slheight, Slheight); //Circle instead of rectangle
    else   rect((xpos+MathVar), ypos, Slwidth/20, Slheight); //and comment this line for circle
  } 
  
  
  boolean over(int uX, int uY) 
  {
    if ( uX >= xpos && uX <= xpos+Slwidth && uY >= ypos && uY <= ypos+Slheight) 
    {          
      Dragging=true;
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }
}

//===============================================================================

class VertSliderBar
{
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int Slwidth; // single bar Slwidthth
  int Slheight; // rect height
  int Value; 
  int Minimum; 
  int Maximum;
  color BgColor;
  color SlColor;
  color SelColor; 
  color StrokeColor;
  boolean CircleHandle;  
  boolean Dragging;


  //local variables 
  boolean over = false;

  //gotta move the int variables into float variables
  float temp1=Slwidth;
  float temp2=Maximum;
  float temp3=Value;
  float temp4=Minimum;
  float MathVar=0;


  VertSliderBar(int ixp, int iyp, int iw, int ih, int iValue, int iMin, int iMax, color iBgColor, color iSlColor, color iSelColor, color iStrokeColor, boolean iCircleHandle, boolean iDragging) 
  {   
    xpos = ixp;
    ypos = iyp;  
    Slwidth = iw;
    Slheight = ih;
    Value=iValue;
    Maximum=iMax;
    Minimum=iMin;
    BgColor=iBgColor;
    SlColor=iSlColor;
    SelColor=iSelColor;
    StrokeColor=iStrokeColor;
    CircleHandle=iCircleHandle;     
    Dragging=iDragging;
  }

//  void move () //VERTICLE
    void move(int uX, int uY) 
  {
    //this function handles position of the slider's handle

    temp1 = Slheight;   
    temp3 = Value;
    temp4 = Minimum;

    MathVar = (((uY-ypos) / temp1)-1) *-1; //creates a scale factor based on mouse position 
    //relative to slider position
    MathVar = Maximum - (MathVar*(Maximum-Minimum));   

    if (MathVar > Maximum) { //check so it doesn't drag off the end
      MathVar=Maximum;
    }

    if (MathVar < Minimum) { //check so it doesn't drag off the end
      MathVar=Minimum;
    }  

    Value=int(MathVar); //set the value based on mouse movement
  }


  void display() //VERTICLE
  {
    stroke(StrokeColor);
    strokeWeight(1);

    //circle handles are displayed differently so there are if/else statements to set it correctly

    fill(BgColor); //covers up the old slider with a blank rectangle, BgColor set in declaration
    rect(xpos, ypos, Slwidth, Slheight);   

    temp1 = Slheight - Slwidth;

    temp2= Maximum;  //move variables into float
    temp3= Value;    //or do they don't compute correctly
    temp4 = Minimum;
    float MathVar;
    MathVar = temp1 / (temp2 - temp4) * (temp3-temp4) + Slwidth/2;
    //MathVar = (SlWidth / (Max / Min) * (Value - Minimum)
    fill(color(SelColor)); //draws the Selcolor over the selected area
    rect(xpos, ypos, Slwidth, MathVar);
    fill(SlColor); //places the slider handle
    ellipse(xpos+(Slwidth/2), ypos+MathVar, Slwidth, Slwidth); //Circle instead of rectangle
  }

  boolean over(int uX, int uY) 
  {
    if ( uX >= xpos && uX <= xpos+Slwidth && uY >= ypos && uY <= ypos+Slheight) 
    {          
      Dragging=true;
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }
}

//===============================================================================

class TextField
{
  String Label;
  int xpos; // rect xposition  
  int ypos ; // rect yposition
  int bWidth;
  int bHeight;
  color ColBG;
  color ColHL;
  boolean Toggle;
  boolean Selected;

  TextField(String iLabel, int ixpos, int iypos, int ibWidth, int ibHeight, color iColBG, color iColHL, boolean iToggle, boolean iSelected)
  {
    Label = iLabel; 
    xpos = ixpos;
    ypos = iypos;  
    bWidth = ibWidth;
    bHeight = ibHeight;
    ColBG = iColBG;
    ColHL = iColHL;
    Toggle = iToggle;
    Selected = iSelected;
  }

  void display()
  {
    s.translate(0, 0);
    s.strokeWeight(2);
    s.fill(ColBG);

    if (Selected==true)
    {
      s.stroke(ColHL); 
      s.rect(xpos, ypos, bWidth, bHeight);
    }
    else       
    {
      s.stroke(0, 0, 255);
      s.rect(xpos, ypos, bWidth, bHeight);
    }
    //adjust stroke to on higligh and invert text color
    s.noStroke();
    s.fill(0);
    s.textSize((bHeight/1.75));
    s.text(Label, xpos+((bWidth - s.textWidth(Label))/2), ypos+((bHeight-(s.textAscent()+s.textDescent()))/2), bWidth, bHeight);

    if (Toggle==false) Selected = false;
  }

  boolean over(int uX, int uY) 
  {
    if ( uX >= xpos && uX <= xpos+bWidth && uY >= ypos && uY <= ypos+bHeight) 
    {      
      return true;
    } 
    else {
      return false;
    }
  }
} 




