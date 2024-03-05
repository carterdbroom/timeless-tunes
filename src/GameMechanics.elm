module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Main exposing (Model)
import Types exposing (Song(..), Note(..), NoteTime(..))
import Shapes exposing (note)
import List exposing (isEmpty)

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
--}
timing : List (Note, NoteTime) -> Float ->  Model -> Shape userMsg
timing song startTime model = 
    let
        timer = startTime - model.time
    in
        if
            timer > 0
        then
            case (List.head song) of
                Just (n, notetime) -> 
                    case notetime of
                        Whole -> 
                            group
                            [
                            if 
                                timer > 4
                            then
                                timing (List.drop 1 song) 0 model
                            else
                                case n of
                                    C -> 
                                        note (-50, 50)                        
                                    CSharp ->
                                        note (-45, 50)
                                    D ->
                                        note (-40, 50)
                                    DSharp ->
                                        note (-35, 50)
                                    E ->
                                        note (-30, 50)
                                    F ->
                                        note (-25, 50)
                                    FSharp ->
                                        note (-20, 50)
                                    G ->
                                        note (-15, 50)
                                    GSharp ->
                                        note (-10, 50)
                                    A ->
                                        note (-5, 50)
                                    ASharp ->
                                        note (0, 50)
                                    B ->
                                        note (5, 50)
                            ]
                        Half -> 
                            group
                            [
                            if 
                                timer > 2
                            then
                                timing (List.drop 1 song) 0 model
                            else
                                case n of
                                    C -> 
                                        note (-50, 50)                        
                                    CSharp ->
                                        note (-45, 50)
                                    D ->
                                        note (-40, 50)
                                    DSharp ->
                                        note (-35, 50)
                                    E ->
                                        note (-30, 50)
                                    F ->
                                        note (-25, 50)
                                    FSharp ->
                                        note (-20, 50)
                                    G ->
                                        note (-15, 50)
                                    GSharp ->
                                        note (-10, 50)
                                    A ->
                                        note (-5, 50)
                                    ASharp ->
                                        note (0, 50)
                                    B ->
                                        note (5, 50)
                            ]
                        Quarter ->
                            group
                            [
                            if 
                                timer > 1
                            then
                                timing (List.drop 1 song) 0 model
                            else
                                case n of
                                    C -> 
                                        note (-50, 50)                        
                                    CSharp ->
                                        note (-45, 50)
                                    D ->
                                        note (-40, 50)
                                    DSharp ->
                                        note (-35, 50)
                                    E ->
                                        note (-30, 50)
                                    F ->
                                        note (-25, 50)
                                    FSharp ->
                                        note (-20, 50)
                                    G ->
                                        note (-15, 50)
                                    GSharp ->
                                        note (-10, 50)
                                    A ->
                                        note (-5, 50)
                                    ASharp ->
                                        note (0, 50)
                                    B ->
                                        note (5, 50)
                            ]
                        Eighth -> 
                            group
                            [
                            if 
                                timer > 0.5
                            then
                                timing (List.drop 1 song) 0 model
                            else
                                case n of
                                    C -> 
                                        note (-50, 50)                        
                                    CSharp ->
                                        note (-45, 50)
                                    D ->
                                        note (-40, 50)
                                    DSharp ->
                                        note (-35, 50)
                                    E ->
                                        note (-30, 50)
                                    F ->
                                        note (-25, 50)
                                    FSharp ->
                                        note (-20, 50)
                                    G ->
                                        note (-15, 50)
                                    GSharp ->
                                        note (-10, 50)
                                    A ->
                                        note (-5, 50)
                                    ASharp ->
                                        note (0, 50)
                                    B ->
                                        note (5, 50)
                            ]
                        Sixteenth -> 
                            group
                            [
                            if 
                                timer > 0.25
                            then
                                timing (List.drop 1 song) 0 model
                            else
                                case n of
                                    C -> 
                                        note (-50, 50)                        
                                    CSharp ->
                                        note (-45, 50)
                                    D ->
                                        note (-40, 50)
                                    DSharp ->
                                        note (-35, 50)
                                    E ->
                                        note (-30, 50)
                                    F ->
                                        note (-25, 50)
                                    FSharp ->
                                        note (-20, 50)
                                    G ->
                                        note (-15, 50)
                                    GSharp ->
                                        note (-10, 50)
                                    A ->
                                        note (-5, 50)
                                    ASharp ->
                                        note (0, 50)
                                    B ->
                                        note (5, 50)
                            ]
                Nothing -> group[]
        else
            group[]