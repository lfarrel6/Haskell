module VisualHandler(VisualHandler, getDefaultVH, setFill,
                     setStroke, setStrokeWidth, setOpacity, getFill,
                     getStroke, getStrokeWidth, getOpacity) where

import Colors

--declared for readability purposes
type Fill = Color
type Stroke = Color
type Strokewidth = Double
type Opacity = Double

--visualHandler creates a tuple of the attribute values following visual transforms
type VisualHandler = (Fill,Stroke, Strokewidth, Opacity)--, Stroke

--get the default tuple
getDefaultVH :: VisualHandler
getDefaultVH = (black,black,1,1)

-- << Getters and Setters

setFill, setStroke :: VisualHandler -> Color -> VisualHandler
setFill   (_,s,sw,o) newFill   = (newFill,s,sw,o)
setStroke (f,_,sw,o) newStroke = (f,newStroke,sw,o)

setStrokeWidth, setOpacity :: VisualHandler -> Double -> VisualHandler
setStrokeWidth (f,s,_,o)  newSW = (f,s,newSW,o)
setOpacity     (f,s,sw,_) newO  = (f,s,sw,newO)

getFill, getStroke :: VisualHandler -> Color
getFill   (f,_,_,_) = f
getStroke (_,s,_,_) = s

getStrokeWidth, getOpacity :: VisualHandler -> Double
getStrokeWidth (_,_,sw,_) = sw
getOpacity     (_,_,_,o)  = o

-- >>