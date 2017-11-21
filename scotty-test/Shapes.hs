module Shapes(
  Shape, Transform, Drawing, VisTransform,
  circle, square,
  translate, rotate, scale, myTestRender, testDrawings, (<+>),
  white, red, green, blue, black,
  transform, visTransform)  where

import Text.Blaze.Svg11 ((!))
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS

data Shape = Circle 
           | Square
           | Rect
             deriving Show

circle, square, rect :: Shape

circle = Circle
square = Square
rect   = Rect

type Color = String
white, red, green, blue, black :: Color
white = "#FFFFFF"
red   = "#FF0000"
green = "#00FF00"
blue  = "#0000FF"
black = "#000000"

-- | Compose Transform Transform

data Transform = Translate Double Double
           | Scale Double Double
           | Rotate Double
           | Compose Transform Transform
             deriving Show

--identity = Identity
translate :: Double -> Double -> Transform
translate = Translate
scale :: Double -> Double -> Transform
scale     = Scale
rotate :: Double -> Transform
rotate    = Rotate 
t0 <+> t1 = Compose t0 t1

transform :: Transform -> S.Attribute
transform t = AS.transform (transform' t)

transform' :: Transform -> S.AttributeValue
--transform' Identity         = 
transform' (Translate tx ty)  = S.translate tx ty
transform' (Scale tx ty)      = S.scale tx ty
transform' (Rotate theta)     = S.rotate theta
transform' (Compose t0 t1)    = transform' t0 ++ transform' t1

data VisTransform = Fill Color
                    | StrokeWidth Double
                    | Stroke Color
                    | ComposeVis VisTransform VisTransform 

fill, stroke :: Color -> VisTransform
fill        = Fill
stroke      = Stroke
strokeWidth :: Double -> VisTransform
strokeWidth = StrokeWidth
t0 <!> t1   = ComposeVis t0 t1

visTransform :: VisTransform -> S.Attribute
visTransform (Fill c)           = AS.fill $ S.stringValue c
visTransform (StrokeWidth d)    = AS.strokeWidth $ S.stringValue $ show d
visTransform (Stroke c)         = AS.stroke $ S.stringValue c
visTransform (ComposeVis t0 t1) = visTransform t0 ++ visTransform t1

type Renderable = (Transform,VisTransform,Shape)
type Drawing = [Renderable]

myTestRender :: Drawing -> S.Svg
myTestRender (x:[])    = renderShape x
myTestRender (x:xs)    = S.docTypeSvg ! AS.version "1.1" ! AS.width "150" ! AS.height "150" ! AS.viewbox "-10 -10 150 100" $ do 
  (renderShape x)
  (myTestRender xs)

testDrawings :: S.Svg
testDrawings = myTestRender samples
  where
   samples = [(((rotate 45)<+>(scale 10 10)),(fill red),square),((translate 40 10),((fill blue)<!>(stroke red)),circle),((translate (-10) (-10)),(strokeWidth 5),rect)]

renderShape :: Renderable -> S.Svg
renderShape (t,ct,Circle) = circleSVG 50       ! transform t ! visTransform ct
renderShape (t,ct,Square) = squareSVG 50       ! transform t ! visTransform ct
renderShape (t,ct,Rect)   = rectangleSVG 50 90 ! transform t ! visTransform ct

circleSVG :: Double -> S.Svg
circleSVG      r = S.circle ! AS.r (S.stringValue $ show r)

rectangleSVG :: Double -> Double -> S.Svg
rectangleSVG h w = S.rect ! AS.width (S.stringValue $ show w) ! AS.height (S.stringValue $ show h)

squareSVG :: Double -> S.Svg
squareSVG w = S.rect ! AS.width (S.stringValue widthStr) ! AS.height (S.stringValue widthStr)
  where
   widthStr = show w
