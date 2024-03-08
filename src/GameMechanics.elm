module GameMechanics exposing (..)

import GraphicSVG exposing (..)
import Main exposing (Model)
import Types exposing (Song(..), Note(..), NoteTime(..))
import Shapes exposing (fallingNote)
import Conversions exposing (noteTimeToSecond,noteToStartPosition,noteToEndPosition)

startSongAnimations : Song -> Model -> Shape userMsg
startSongAnimations song model = 
    case song of
        Twinkle dict -> group[]

distance : (Float, Float) -> (Float, Float) -> Float
distance (s1, s2) (e1, e2) =
    let
        x = abs(s1 - e1)
        y = abs(s2 - e2)
    in
        sqrt (x^2 + y^2)

speed : Float -> Float -> Float
speed dis t =
    dis/t

calculateDropTime : Model -> Float
calculateDropTime model 
    =
    100/(model.time*9.81)

calculateNextDrop : NoteTime -> Model -> Float
calculateNextDrop notetime model = 
    let
        t = noteTimeToSecond notetime
    in
        (calculateDropTime model) - t
movingNote : Float -> (Float, Float) -> (Float, Float) -> Float -> Model -> Shape userMsg -> Shape userMsg
movingNote startTime startPosition endPosition time model shape = 
    let
        timer = model.time - startTime
        d = distance startPosition endPosition 
    in
        case (startPosition, endPosition) of
            ((x1, y1), (_, y2)) -> 
                if 
                    y1 > y1
                then
                    shape
                    |> move (x1, y1 - (speed d time)*timer)
                else
                    group[]

dropNote : List(Note, NoteTime) -> Float -> Model -> Shape userMsg
dropNote list startTime model = 
    let 
        timer = model.time - startTime
    in
        if 
            timer > 0
        then
            case list of
                (head1::tail1) -> 
                    case head1 of
                        (note1, noteTime1) ->
                            case tail1 of 
                                (head2::tail2) ->
                                    case head2 of
                                        (note2, noteTime2) ->
                                            group(((fallingNote (noteToStartPosition note1) 1 black) |> move (0, -9.81*model.time*model.time))::[dropNote tail1 ((noteTimeToSecond note1) - (calculateDropTime model))])
                                        _ ->
                                            group []
                                _ ->
                                    ((fallingNote (noteToStartPosition note1) 1 black) |> move (0, -9.81*model.time*model.time))
                        _ ->
                            group[]
                _ ->
                    group[]
        else
            group[]

playSong : Song -> (Float, Float) -> (Float, Float) -> Float -> Model -> Shape userMsg 
playSong song spawn end startTime model =
    let
        timer = model.time - startTime
    in
        case song of 
            Twinkle list ->
                case list of 
                    (head::tail) ->
                            case head of
                                (note, noteTime) ->
                                    
                                    if 
                                        timer > 0 && timer < (noteTimeToSecond noteTime)
                                    then
                                        fallingNote (noteToStartPosition note) 1 black
                                        |> movingNote (timer*(noteTimeToSecond noteTime)) (noteToStartPosition note) (noteToEndPosition note) (noteTimeToSecond noteTime) model
                                    else
                                        group[]
                    _ -> 
                        group[]
{--
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
            --}