module Main exposing (main)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (..)
import Types exposing (..)

myShapes model = 
    [
        circle 10
        |> filled red
    ]

type alias Model = { time: Float }

update msg model = 
    case msg of
        Tick t _ -> { time = t }


init = { time = 0 }

main = gameApp Tick {model = init, view = view, update = update, title = "Retro Riffs"}

view model = collage 230 128 (myShapes model)
