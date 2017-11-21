module Shapes where

import Transformations(Transform, VisTransform)

data Shape = Circle
           | Square
           | Rect
             deriving (Show, Read)

circle, square, rect :: Shape
circle = Circle
square = Square
rect   = Rect

-- | Compose Transform Transform

type Renderable = (Transform,VisTransform,Shape)
type Drawing    = [Renderable]