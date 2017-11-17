{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R
import Text.Blaze.Svg.Renderer.String (renderSvg)

import qualified Shapes as SH
import Data.Text.Lazy

main = scotty 1234 $ do
  get "/" $ do
    html (R.renderHtml $ SH.myTestRender)

  get "/greet" $ do
      html $ "Yo"

  get (literal "/greet/") $ do
      html $ "Oh, wow!"

  get "/greet/:name" $ do
      name <- param "name"
      html $ longresponse name

response :: Text -> Text
response n = do R.renderHtml $ do
                  H.h1 ( "Hello " >> H.toHtml n)

longresponse :: Text -> Text
longresponse n = do
  R.renderHtml $ do
    H.head $ H.title "Welcome page"
    H.body $ do
      H.h1 "Welcome!"
      H.p ("" >> H.toHtml n)
      SH.myTestRender

--svgDoc :: S.Svg
--svgDoc = S.docTypeSvg ! AS.version "1.1" ! AS.width "150" ! AS.height "100" ! AS.viewbox "0 0 3 2" $ rectangle
 --where
  --rectangle = do 
      --S.rect ! AS.width "90" ! AS.height "50" ! AS.fill "#d2232c"
      --S.rect ! AS.width "60" ! AS.height "50" ! AS.fill "#ffffff"
      --S.rect ! AS.width "30" ! AS.height "50" ! AS.fill "#008d46"