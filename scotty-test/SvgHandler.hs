module SvgHandler(svgBuilder) where

import Transformations
import Shapes

import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS
import Text.Blaze.Svg11 ((!))

svgBuilder :: Drawing -> S.Svg
svgBuilder currentDrawing = S.docTypeSvg ! AS.version "1.1" ! AS.width "1500" ! AS.height "1500" ! AS.viewbox "-25 -25 100 100" $ do mapM_ (\toDraw -> svgBuilder' toDraw) currentDrawing

svgBuilder' :: Renderable -> S.Svg
svgBuilder' = renderShape

renderShape :: Renderable -> S.Svg
renderShape (t, ct, Circle) = circleSVG    ! transform t ! visTransform ct
renderShape (t, ct, Square) = squareSVG    ! transform t ! visTransform ct
renderShape (t, ct, Rect)   = rectangleSVG ! transform t ! visTransform ct

defaultDim :: String
defaultDim = "1"

circleSVG, rectangleSVG, squareSVG :: S.Svg
circleSVG    = S.circle ! AS.r     (S.stringValue defaultDim)
rectangleSVG = S.rect   ! AS.width (S.stringValue defaultDim) ! AS.height (S.stringValue defaultDim)
squareSVG    = S.rect   ! AS.width (S.stringValue defaultDim) ! AS.height (S.stringValue defaultDim)
