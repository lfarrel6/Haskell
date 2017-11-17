module Shapes(
  Shape, Transform, Drawing, VisTransform,
  circle, square,
  translate, rotate, scale, myTestRender,-- (<+>),
  white, red, green, blue, black,
  transform, visTransform)  where

import Text.Blaze.Svg11 ((!))
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS

data Shape = Circle 
           | Square
             deriving Show

circle, square :: Shape

circle = Circle
square = Square

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
             deriving Show

--identity = Identity
translate :: Double -> Double -> Transform
translate = Translate
scale :: Double -> Double -> Transform
scale     = Scale
rotate :: Double -> Transform
rotate    = Rotate 
--t0 <+> t1 = Compose t0 t1

transform :: Transform -> S.Attribute
transform t = AS.transform (transform' t)

transform' :: Transform -> S.AttributeValue
--transform' Identity         = 
transform' (Translate tx ty)  = S.translate tx ty
transform' (Scale tx ty)      = S.scale tx ty
transform' (Rotate theta)     = S.rotate theta
--transform' (Compose t1 t2)    = transform' t2 $ transform' t1

data VisTransform = Fill Color
                    | StrokeWidth Double

fill :: Color -> VisTransform
fill        = Fill
strokeWidth :: Double -> VisTransform
strokeWidth = StrokeWidth

visTransform :: VisTransform -> S.Attribute
visTransform (Fill c)        = AS.fill $ S.stringValue c
visTransform (StrokeWidth d) = AS.strokeWidth $ S.stringValue $ show d

type Drawing = [(Transform,VisTransform,Shape)]

myTestRender :: S.Svg
myTestRender = S.docTypeSvg ! AS.version "1.1" ! AS.width "150" ! AS.height "150" ! AS.viewbox "0 0 150 100" $ do renderShape test
            where
              col  = fill black
              tr   = scale 2.0 2.0
              test = [(tr,col,circle)]

renderShape :: Drawing -> S.Svg
renderShape [(t,ct,Circle)] = circleSVG    10    ! transform t ! visTransform ct
renderShape [(t,ct,Square)] = rectangleSVG 20 40 ! transform t ! visTransform ct

circleSVG :: Double -> S.Svg
circleSVG      r = S.circle ! AS.r (S.stringValue $ show r)

rectangleSVG :: Double -> Double -> S.Svg
rectangleSVG h w = S.rect   ! AS.width (S.stringValue $ show w) ! AS.height (S.stringValue $ show h)