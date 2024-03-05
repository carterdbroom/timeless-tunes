module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Main exposing (Model)
import Types exposing (Song(..), Note(..), NoteTime(..))
import Shapes exposing (note)

startSongAnimations : Song -> Model -> Shape userMsg
startSongAnimations song model = 
    case song of
        Twinkle dict -> group[]
{--
drawNote : Song -> (Float, Float) -> (Float, Float) -> Float -> Model -> Shape userMsg 
drawNote song spawn end startTime model =
    let
        timer = model.time - startTime
    in
        case song of 
            Twinkle dict
        if 
            timer > 0
        then
            note
            |> move spawn
        else
            group[]

timing : (Dict (Maybe Note) NoteTime) -> Int -> Bool
timing song currentNote = 
    let
        go = True
    in
--}