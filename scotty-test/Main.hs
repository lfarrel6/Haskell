{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R
import Text.Blaze.Svg.Renderer.String (renderSvg)
import Text.Read (readMaybe)
import qualified Shapes as SH
import Data.Text.Lazy

main = scotty 1234 $ do
  get "/" $ file "input.html"
    --html (R.renderHtml $ SH.testDrawings)
    
  post "/render" $ do
      requested <- (param "shapeDesc") `rescue` return
      html $ R.renderHtml $ case interpret requested of
        Just r  -> SH.svgBuilder r
        Nothing -> H.h1 "Invalid shape entered"
      --html $ R.renderHtml (SH.svgBuilder $ (read $ unpack requested :: SH.Renderable))

  get "/greet" $ do
      html $ "Yo"

  get (literal "/greet/") $ do
      html $ "Oh, wow!"

  get "/greet/:name" $ do
      name <- param "name"
      html $ longresponse name

interpret :: Text -> Maybe SH.Renderable
interpret s = readMaybe (unpack s)

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
