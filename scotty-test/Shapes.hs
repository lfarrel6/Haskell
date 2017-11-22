module Shapes where

import qualified Transformations as TR

data Shape = Circle
           | Square
           | Rect
           | Ellipse
             deriving (Show, Read)

circle, square, rect, ellipse :: Shape
circle  = Circle
square  = Square
rect    = Rect
ellipse = Ellipse

type Renderable = (TR.Transform,TR.VisTransform,Shape)
type Drawing    = [Renderable]