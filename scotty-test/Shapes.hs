module Shapes where

import qualified Transformations as TR

data Shape = Circle
           | Square
           | Rect
             deriving (Show, Read)

circle, square, rect :: Shape
circle = Circle
square = Square
rect   = Rect

-- | Compose Transform Transform

type Renderable = (TR.Transform,TR.VisTransform,Shape)
type Drawing    = [Renderable]
