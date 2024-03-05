module Shapes exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))

shape : Shape userMsg
shape 
    = group
    [
        rect 5 10
        |> filled black
        ,
        circle 5
        |> filled black
    ]