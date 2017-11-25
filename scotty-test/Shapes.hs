module Shapes where

import qualified Transformations as TR

data Shape = Circle
           | Square
             deriving (Show, Read)

circle, square :: Shape
circle  = Circle
square  = Square

type Renderable      = (TR.Transform,TR.VisTransform,Shape)
type Drawing         = [Renderable]