module VisualHandler(VisualHandler, getDefaultVH, setFill, setStroke,
                     setStrokeWidth, setOpacity, getFill,
                     getStroke, getStrokeWidth, getOpacity) where

import Colors

type Fill = Color
type Stroke = Color
type StrokeWidth = Double
type Opacity = Double

type VisualHandler = (Fill,Stroke,StrokeWidth,Opacity)

getDefaultVH :: VisualHandler
getDefaultVH = (black,black,1,1)

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
