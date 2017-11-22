module SvgHandler(svgBuilder) where

import Transformations
import Shapes
import VisualHandler

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS
import Text.Blaze.Svg11 ((!))

svgBuilder :: Drawing -> S.Svg
svgBuilder currentDrawing = S.docTypeSvg ! AS.version "1.1" ! AS.width "1500" ! AS.height "1500" ! AS.viewbox "-25 -25 100 100" $ do mapM_ (\toDraw -> renderShape toDraw getDefaultVH) currentDrawing

renderShape :: Renderable -> VisualHandler -> S.Svg
renderShape (t, ct, sh)  vh = getSvg sh ! transform t ! renderFill visuals ! renderStroke visuals ! renderSWidth visuals ! renderOpacity visuals
 where
  visuals = visTransform ct vh

defaultDim :: String
defaultDim = "10"

getSvg :: Shape -> S.Svg
getSvg s = do
    case s of
      Circle  -> S.circle  ! AS.r     (S.stringValue defaultDim)
      Square  -> S.rect    ! AS.width (S.stringValue defaultDim) ! AS.height (S.stringValue defaultDim)
      Rect    -> S.rect    ! AS.width (S.stringValue defaultDim) ! AS.height (S.stringValue defaultDim)
      Ellipse -> S.ellipse ! AS.rx    (S.stringValue defaultDim) ! AS.ry     (S.stringValue defaultDim)

renderFill,renderStroke,renderSWidth,renderOpacity :: VisualHandler -> S.Attribute
renderFill    visuals = AS.fill         $ S.stringValue $ show $ getFill visuals
renderStroke  visuals = AS.stroke       $ S.stringValue $ show $ getStroke visuals
renderSWidth  visuals = AS.strokeWidth  $ S.stringValue $ show $ getStrokeWidth visuals
renderOpacity visuals = AS.fillOpacity  $ S.stringValue $ show $ getOpacity visuals
