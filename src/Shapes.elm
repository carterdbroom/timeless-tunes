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
{--
distance : (Float, Float) -> (Float, Float) -> Float
distance (s1, s2) (e1, e2) =
    let
        x = abs(s1 - s2)
        y = (abs s2) + 
    in

movingNote : (Float, Float) -> (Float, Float) -> Shape userMsg -> Shape userMsg
movingNote startPosition endPosition note
--}
