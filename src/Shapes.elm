module Shapes exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)

-- A function that draws a quarter note to the screen. You can change the outline colour, colour, size, and position. 
quarterNote : Color -> Color -> Float -> (Float, Float) -> Shape userMsg
quarterNote outlineColour colour size position = 
    group [
        group[
            circle 5
            |> filled outlineColour
            |> skewY -0.3
            |> rotate (degrees -30)
            |> scale 0.8
            ,
            roundedRect 2 16 1
            |> filled outlineColour
            |> scaleX 1.3
            |> scaleY 0.85
            |> move (3,8)
        ]
        ,
        group [
            circle 5
            |> filled colour
            --|> skewX -0.1
            |> skewY -0.3
            |> rotate (degrees -30)
            |> scale 0.7
            ,
            roundedRect 2 17 1
            |> filled colour
            |> scale 0.8
            |> move (3,7.5)
        ]
    ]
    |> scale size
    |> move position

-- A function that draws a half note to the screen. You can change the outline colour, colour, size, and position. 
halfNote : Color -> Color -> Float -> (Float, Float) -> Shape userMsg
halfNote outlineColour colour size position = 
    group [
        group[
            circle 5
            |> outlined (solid 1.5) outlineColour
            |> skewY -0.3
            |> rotate (degrees -30)
            |> scale 0.8
            ,
            circle 5
            |> outlined (solid 1.5) outlineColour
            |> skewY -0.3
            |> rotate (degrees -30)
            |> scale 0.6
            ,
            roundedRect 2 16 1
            |> filled outlineColour
            |> scaleX 1.3
            |> scaleY 0.95
            |> move (3.6,8.7)
        ]
        ,
        group [
            circle 5
            |> outlined (solid 1.5) colour
            |> skewY -0.3
            |> rotate (degrees -30)
            |> scale 0.7
            ,
            roundedRect 2 18 1
            |> filled colour
            |> scale 0.8
            |> move (3.6,8.5)
        ]
    ]
    |> scale 0.9
    |> scale size
    |> move position

-- A function that draws a whole note to the screen. You can change the outline colour, colour, size, and position. 
wholeNote : Color -> Color -> Float -> (Float, Float) -> Shape userMsg
wholeNote outlineColour colour size position = 
    group[
        circle 5
        |> outlined (solid 1.5) outlineColour
        |> skewY -0.3
        |> rotate (degrees -45)
        |> scale 0.8
        ,
        circle 5
        |> outlined (solid 1.5) outlineColour
        |> skewY -0.3
        |> rotate (degrees -45)
        |> scale 0.6
        ,
        circle 5
        |> outlined (solid 1.5) colour
        |> skewY -0.3
        |> rotate (degrees -45)
        |> scale 0.7
    ]
    |> skewX -0.1
    |> scale 0.9
    |> scale size
    |> move position

-- A function that draws an eigth note to the screen. You can change the outline colour, colour, size, and position. 
-- !TODO!
eighthNote : Color -> Color -> Float -> (Float, Float) -> Shape userMsg
eighthNote outlineColour colour size position = 
    group [
        group[
            circle 5
            |> filled outlineColour
            |> skewX -0.1
            |> scale 1.1
            ,
            roundedRect 2 16 1
            |> filled outlineColour
            |> scaleX 1.5
            |> scaleY 1.05
            |> move (4,7.5)
        ]
        ,
        group [
            circle 5
            |> filled colour
            |> skewX -0.1
            ,
            roundedRect 2 16 1
            |> filled colour
            |> move (4,7.5)
            
        ]
    ]
    |> scale size
    |> move position






