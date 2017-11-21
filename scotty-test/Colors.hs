module Colors(Color, white, red, green, blue, black, gold) where

data Color = White
           | Red
           | Green
           | Blue
           | Black
           | Goldenrod
           | Aquamarine
           | Firebrick
           deriving (Show, Read)

white, red, green, blue, black, gold, aqua, firebrick :: Color
white = White
red   = Red
green = Green
blue  = Blue
black = Black
gold  = Goldenrod
aqua  = Aquamarine
firebrick = Firebrick
