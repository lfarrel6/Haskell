module Transformations(Transform, VisTransform, transform, visTransform) where

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS

import Colors
import VisualHandler

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

--transform receives a transform, passes it to transform'
--to get the list of attribute values it creates, and uses
--mconcat to merge them into the transform attribute
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
                    | Stroke Color
                    | Strokewidth Double
                    | Opacity Double
                    | ComposeVis VisTransform VisTransform 
                    deriving Read

fill, stroke :: Color -> VisTransform
fill        = Fill
stroke      = Stroke
strokeWidth :: Double -> VisTransform
strokeWidth = Strokewidth
fillOpacity :: Double -> VisTransform
fillOpacity = Opacity
(<!>) :: VisTransform -> VisTransform -> VisTransform
t0 <!> t1   = ComposeVis t0 t1

--visTransform applies VisTransforms to the VisualHandler and returns the updated VisualHandler
visTransform :: VisTransform -> VisualHandler -> VisualHandler
visTransform (Fill c)           visHandler = setFill        visHandler c
visTransform (Strokewidth d)    visHandler = setStrokeWidth visHandler d
visTransform (Stroke c)         visHandler = setStroke      visHandler c
visTransform (Opacity a)        visHandler = setOpacity     visHandler a
--Compose evaluates t0 on visHandler and gives the result to t1 to ensure
--that the order of execution is maintained
visTransform (ComposeVis t0 t1) visHandler = visTransform t1 newVh
 where
  newVh = visTransform t0 visHandler