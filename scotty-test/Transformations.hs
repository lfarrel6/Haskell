module Transformations(Transform, VisTransform, transform, visTransform) where

import qualified Text.Blaze.Svg11 as S
import Colors
import qualified Text.Blaze.Svg11.Attributes as AS

-- <<
-- 'PHYSICAL' TRANSFORMATIONS
-- translate, scale, rotate
-- >>

data Transform = Translate Double Double
                 | Scale Double Double
                 | Rotate Double
                 | Identity
                 | Compose Transform Transform
                 deriving (Show, Read)

identity :: Transform
identity = Identity

translate, scale :: Double -> Double -> Transform
translate = Translate
scale     = Scale

rotate :: Double -> Transform
rotate    = Rotate 
t0 <+> t1 = Compose t0 t1

transform :: Transform -> S.Attribute
transform t = AS.transform (mconcat $ transform' t)

transform' :: Transform -> [S.AttributeValue]
transform' (Identity)         = transform' (Translate 0 0)
transform' (Translate tx ty)  = [S.translate tx ty]
transform' (Scale tx ty)      = [S.scale tx ty]
transform' (Rotate theta)     = [S.rotate theta]
transform' (Compose t0 t1)    = transform' t0 ++ transform' t1

-- <<
-- VISUAL TRANSFORMATIONS
-- fill, strokewidth, stroke
-- >>

data VisTransform = Fill Color
                    | StrokeWidth Double
                    | Stroke Color
                    | Opacity Double
                    | ComposeVis VisTransform VisTransform 
                    deriving Read

fill, stroke :: Color -> VisTransform
fill        = Fill
stroke      = Stroke
strokeWidth :: Double -> VisTransform
strokeWidth = StrokeWidth
fillOpacity :: Double -> VisTransform
fillOpacity = Opacity
--t0 <!> t1   = ComposeVis t0 t1

visTransform :: VisTransform -> S.Attribute
visTransform (Fill c)           = AS.fill        $ S.stringValue $ show c
visTransform (StrokeWidth d)    = AS.strokeWidth $ S.stringValue $ show d
visTransform (Stroke c)         = AS.stroke      $ S.stringValue $ show c
visTransform (Opacity a)        = AS.fillOpacity $ S.stringValue $ show a
--visTransform (ComposeVis t0 t1) = visTransform t0 ++ visTransform t1
