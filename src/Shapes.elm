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
        |> filled red
        |> move (30, 30)
    ]

note : (Float, Float) -> Shape userMsg
note position =
    circle 5
    |> outlined (solid 1) black
    |> move position