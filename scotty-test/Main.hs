{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

import Text.Blaze.Svg11 ((!))
import qualified Text.Blaze.Svg11 as S
import qualified Text.Blaze.Svg11.Attributes as AS
import Text.Blaze.Svg.Renderer.String (renderSvg)

import Data.Text.Lazy

main = scotty 3000 $ do
  get "/" $ do
    html "Hello World!"

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
      H.p ("Welcome to my Scotty app " >> H.toHtml n)
      svgDoc

svgDoc :: S.Svg
svgDoc = S.docTypeSvg ! AS.version "1.1" ! AS.width "150" ! AS.width "150" ! AS.height "100" $ rectangle --AS.viewbox "0 0 3 2" $ rectangle
 where
  rectangle = do 
      S.rect ! AS.width "90" ! AS.height "50" ! AS.fill "#d2232c"
      S.rect ! AS.width "60" ! AS.height "50" ! AS.fill "#ffffff"
      S.rect ! AS.width "30" ! AS.height "50" ! AS.fill "#008d46"
