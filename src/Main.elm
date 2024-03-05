module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import Types exposing (..)
import Shapes exposing (shape)

myShapes : a -> List (Shape userMsg)
myShapes model = 
    [
        shape
    ]

type Msg 
    = Tick Float GetKeyState

type alias Model = { time: Float }

update : Msg -> b -> { time : Float }
update msg model = 
    case msg of
        Tick t _ -> { time = t }


init = { time = 0 }

main = gameApp Tick {model = init, view = view, update = update, title = "Retro Riffs"}

view model = collage 230 128 (myShapes model)
