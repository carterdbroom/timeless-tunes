module Shapes exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Html exposing (s)

shape1 : Shape userMsg
shape1 
    = group
    [
        rect 5 10
        |> filled black
        ,
        circle 5
        |> filled red
        |> move (30, 30)
    ]

fallingNote : (Float, Float) -> Float -> Color -> Shape userMsg
fallingNote position size colour = 
    circle 1
    |> outlined (solid 1) colour
    |> scale size
    |> move position




