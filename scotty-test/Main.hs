{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Text.Blaze.Html.Renderer.Text as R

import Text.Read (readMaybe)
import Data.Text.Lazy

import qualified Shapes as SH
import SvgHandler

main = scotty 1234 $ do
  get "/" $ file "input.html"
    
  post "/render" $ do
      requested <- (param "shapeDesc") `rescue` return
      html $ R.renderHtml $ case interpret requested of
        Just r  -> svgBuilder r
        Nothing -> H.h1 "Invalid shape entered"

interpret :: Text -> Maybe SH.Renderable
interpret s = readMaybe (unpack s)