module Conversions exposing (..)

import Types exposing (..)

stringToNote : String -> Maybe Note
stringToNote string
    = case string of
        "C" -> Just C
        "CSharp" -> Just CSharp
        "D" -> Just D
        "DSharp" -> Just DSharp
        "E" -> Just E
        "F" -> Just F
        "FSharp" -> Just FSharp
        "G" -> Just G
        "GSharp" -> Just GSharp
        "A" -> Just A
        "ASharp" -> Just ASharp
        "B" -> Just B
        _ -> Nothing

noteTimeToSecond : NoteTime -> Float
noteTimeToSecond noteTime 
    = case noteTime of 
        Whole ->
            4
        Half ->
            2
        Quarter ->
            1
        Eighth ->
            0.5
        Sixteenth ->
            0.25

noteToStartPosition : Note -> (Float, Float)
noteToStartPosition note 
    = case note of
        C -> (-50, 50)
        CSharp -> (-45, 50)
        D -> (-40, 50)
        DSharp -> (-35, 50)
        E -> (-30, 50)
        F -> (-25, 50)
        FSharp -> (-20, 50)
        G -> (-15, 50)
        GSharp -> (-10, 50)
        A -> (-5, 50)
        ASharp -> (0, 50)
        B -> (5, 50)

noteToEndPosition : Note -> (Float, Float)
noteToEndPosition note 
    = case note of
        C -> (-50, -50)
        CSharp -> (-45, -50)
        D -> (-40, -50)
        DSharp -> (-35, -50)
        E -> (-30, -50)
        F -> (-25, -50)
        FSharp -> (-20, -50)
        G -> (-15, -50)
        GSharp -> (-10, -50)
        A -> (-5, -50)
        ASharp -> (0, -50)
        B -> (5, -50)

addTuple : (Float, Float) -> (Float, Float) -> (Float, Float)
addTuple firstTup secondTup
    = case firstTup of
        (x1, y1) -> 
            case secondTup of 
                (x2, y2) ->
                    (x1 + x2, y1 + y2)

bpmToSeconds : Float -> Float
bpmToSeconds bpm
    = bpm/60