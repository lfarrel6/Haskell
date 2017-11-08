{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

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
      
    
