module Colors(Color, white, red, green, blue, black, gold, aqua, firebrick) where

data Color = White
           | Red
           | Green
           | Blue
           | Black
           | Goldenrod
           | Aquamarine
           | Firebrick
           deriving (Show, Read)

--colour list
white, red, green, blue, black, gold, aqua, firebrick :: Color
white = White
red   = Red
green = Green
blue  = Blue
black = Black
gold  = Goldenrod
aqua  = Aquamarine
firebrick = Firebrick