module Shapes(
  Shape, Transform, Drawing, Renderable, VisTransform,
  circle, square,
  translate, rotate, scale,
  transform, visTransform, renderShape, svgBuilder)  where

import Text.Blaze.Svg11 ((!))
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS
import Colors

data Shape = Circle Double
           | Square Double
           | Rect Double Double
             deriving (Show, Read)

circle, square :: Double -> Shape

circle = Circle
square = Square

rect :: Double -> Double -> Shape
rect   = Rect

-- | Compose Transform Transform

data Transform = Translate Double Double
           | Scale Double Double
           | Rotate Double
          -- | Compose Transform Transform
           deriving (Show, Read)

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
--transform' (Compose t0 t1)    = transform' t0 ++ transform' t1

data VisTransform = Fill Color
                    | StrokeWidth Double
                    | Stroke Color
                    deriving Read
                   -- | ComposeVis VisTransform VisTransform 

fill, stroke :: Color -> VisTransform
fill        = Fill
stroke      = Stroke
strokeWidth :: Double -> VisTransform
strokeWidth = StrokeWidth
--t0 <!> t1   = ComposeVis t0 t1

visTransform :: VisTransform -> S.Attribute
visTransform (Fill c)           = AS.fill $ S.stringValue $ show c
visTransform (StrokeWidth d)    = AS.strokeWidth $ S.stringValue $ show d
visTransform (Stroke c)         = AS.stroke $ S.stringValue $ show c
--visTransform (ComposeVis t0 t1) = visTransform t0 ++ visTransform t1

type Renderable = (Transform,VisTransform,Shape)
type Drawing = [Renderable]

svgBuilder :: Renderable -> S.Svg
svgBuilder toRender = S.docTypeSvg ! AS.version "1.1" ! AS.width "150" ! AS.height "150" ! AS.viewbox "-25 -25 100 100" $ do renderShape toRender

renderShape :: Renderable -> S.Svg
renderShape (t,ct,Circle r) =  circleSVG r       ! transform t ! visTransform ct
renderShape (t,ct,Square w) = squareSVG w       ! transform t ! visTransform ct
renderShape (t,ct,Rect h w)   = rectangleSVG h w ! transform t ! visTransform ct

circleSVG :: Double -> S.Svg
circleSVG      r = S.circle ! AS.r (S.stringValue $ show r)

rectangleSVG :: Double -> Double -> S.Svg
rectangleSVG h w = S.rect ! AS.width (S.stringValue $ show w) ! AS.height (S.stringValue $ show h)

squareSVG :: Double -> S.Svg
squareSVG w = S.rect ! AS.width (S.stringValue widthStr) ! AS.height (S.stringValue widthStr)
  where
   widthStr = show w
