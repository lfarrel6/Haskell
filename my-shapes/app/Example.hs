module Example where

import Shapes
import Signal(Signal, constS, ($$), mapS, timeS)
import Animate (animate)
import Render (defaultWindow)

staticBall :: Signal Drawing
staticBall = constS ball
     where ball = [(scale (point 0.5 0.5) <+> translate (point 1.2 0.4), circle)]

rotatingSquare :: Signal Drawing
rotatingSquare = mapS (:[]) $ mapS sq rs --  constS [( scale (point 0.5 0.5) <+> translate (point 1.2 0.4), square)] -- mapS (:[]) $ mapS sq rs
     where            
           rs :: Signal Transform
           rs = mapS rotate timeS -- using timeS as the source for the rotation angle

           sqs :: Transform -> Signal (Transform,Shape)
           sqs t = mapS sq rs

           sq :: Transform -> (Transform, Shape)
           sq t = ( scale (point 0.5 0.5) <+> translate (point 1.2 0.4) <+> t, square)

movingBall :: Signal Drawing
movingBall = mapS (:[]) $ mapS ball ts
       where
             bs :: Signal (Transform,Shape)
             bs = mapS ball ts
             
             ts :: Signal Transform
             ts = mapS translate pos

             bounceY :: Signal Double
             bounceY = mapS (sin . (3*)) timeS

             pos :: Signal Point
             pos = constS point $$ constS 0.0 $$ bounceY

             ball :: Transform -> (Transform, Shape)
             ball t = ( t <+> scale (point 0.3 0.3), circle )

bouncingBall :: Signal Drawing
bouncingBall = mapS (:[]) $ mapS ball ( mapS translate pos )
       where bounceY = mapS (sin . (3*)) timeS
             bounceX = mapS (sin . (2*)) timeS
             pos = constS point $$ bounceX $$ bounceY
             ball t = ( t <+> scale (point 0.3 0.3), circle )

joinDS :: Signal [a] -> Signal [a] -> Signal [a]
joinDS s0 s1 = (mapS ( (++) ) s0) $$ s1


--example = staticBall
example = bouncingBall `joinDS` rotatingSquare

           
runExample :: IO ()
runExample = animate defaultWindow 0 endTime example
  where endTime = 15

