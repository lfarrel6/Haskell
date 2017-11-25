{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html.Renderer.Text as R

import Text.Read (readMaybe)
import Data.Text.Lazy

import qualified Shapes as SH
import SvgHandler

--serve input file
--read input received from form submission
--evaluate if valid

main :: IO ()
main = scotty 1234 $ do
  get "/" $ file "input.html"

  post "/render" $ do
      requested <- (param "shapeDesc") `rescue` return
      html $ R.renderHtml $ case interpretDrawing requested of
        Just d  -> svgBuilder d
        Nothing -> do
          case interpretRenderable requested of
            Just r  -> svgBuilder [r]
            Nothing -> H.h1 "Invalid Shape description"

interpretDrawing :: Text -> Maybe SH.Drawing
interpretDrawing s = readMaybe $ unpack s

interpretRenderable :: Text -> Maybe SH.Renderable
interpretRenderable s = readMaybe $ unpack s