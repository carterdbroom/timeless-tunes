module Conversions exposing (..)

import GraphicSVG exposing (..)
import Types exposing (..)
import Shapes exposing (wholeNote, halfNote, quarterNote)

-- Given a String, it returns the String converted to a Note. We use the Maybe type because 
-- we can have random Strings we don't want, so we just return Nothing in that case.
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
        "Rest" -> Just Rest
        _ -> Nothing

-- Given a NoteTime, it returns the NoteTime converted to seconds.
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
        WholeRest ->
            4
        HalfRest ->
            2
        QuarterRest ->
            1
        EighthRest ->
            0.5

-- Given a Note, it returns the position where the note should start as a Tuple of Floats.
noteToStartPosition : Note -> (Float, Float)
noteToStartPosition note 
    = case note of
        C -> (-60, 50)
        CSharp -> (-43.5, 50)
        D -> (-27, 50)
        DSharp -> (-10.5, 50)
        E -> (-43.5, 50)
        F -> (-27, 50)
        FSharp -> (-10.5, 50)
        G -> (6, 50)
        GSharp -> (-60, 50)
        A -> (-43.5, 50)
        ASharp -> (-27, 50)
        B -> (-10.5, 50)
        Rest -> (0, 50)

-- Given a Note, it returns the position where the note should end/disappear as a Tuple of Floats.
noteToEndPosition : Note -> (Float, Float)
noteToEndPosition note 
    = case note of
        C -> (-60, -19)
        CSharp -> (-43.5, -19)
        D -> (-27, -19)
        DSharp -> (-10.5, -19)
        E -> (-43.5, -31.5)
        F -> (-27, -31.5)
        FSharp -> (-10.5, -31.5)
        G -> (6, -31.5)
        GSharp -> (-60, -25.25)
        A -> (-43.5, -25.25)
        ASharp -> (-27, -25.25)
        B -> (-10.5, -25.25)
        Rest -> (0, -50)

-- Given a Note, it returns the associated y-coordinate as a Float.
noteToEndYPosition : Note -> Float
noteToEndYPosition note
    = case note of
        C -> -19
        CSharp -> -19
        D -> -19
        DSharp -> -19
        E -> -31.5
        F -> -31.5
        FSharp -> -31.5
        G -> -31.5
        GSharp -> -25.25
        A -> -25.25
        ASharp -> -25.25
        B -> -25.25
        Rest -> -60

-- Given a two Tuples of Floats, this function adds their elements together and returns a Tuple of Floats.
addTuple : (Float, Float) -> (Float, Float) -> (Float, Float)
addTuple firstTup secondTup
    = case firstTup of
        (x1, y1) -> 
            case secondTup of 
                (x2, y2) ->
                    (x1 + x2, y1 + y2)

-- Given a BPM (Beats Per Minute), converts the BPM to seconds and returns a Float.
bpmToSeconds : Float -> Float
bpmToSeconds bpm
    = bpm/60

-- Given a Note, it returns the associated x-coordinate as a Float.
noteToXPosition : Note -> Float
noteToXPosition note =
    case note of
        C -> -60
        CSharp -> -43.5
        D -> -27
        DSharp -> -10.5
        E -> -43.5
        F -> -27
        FSharp -> -10.5
        G -> 6
        GSharp -> -60
        A -> -43.5
        ASharp -> -27
        B -> -10.5
        Rest -> 10

-- Takes in a Song, finds the first Tuple in the List, finds the Note, then returns the associated start position  
-- as a Tuple of Floats.
getStartPositionFromSong : Song -> (Float, Float)
getStartPositionFromSong song =
    case song of 
        Twinkle list -> 
            case list of 
                (head::_) ->
                    case head of 
                        (note, _) ->
                            noteToStartPosition note
                [] -> 
                    (0,0)

-- Given a list of note tuples, returns the start position of the first note.
getStartPositionFromList : List ((Note, NoteTime)) -> (Float, Float)
getStartPositionFromList list =
    case list of 
        (head::_) ->
            case head of
                (note, _) ->
                    noteToStartPosition note
        [] ->
            (0, 0)

-- Takes in a Song, finds the first Tuple in the List, finds the NoteTime, then returns the associated Shape.
getStartNoteShapeFromSong : Song -> Shape userMsg
getStartNoteShapeFromSong song =
    case song of
        Twinkle list ->
            case list of 
                (head::_) ->
                    case head of
                        (_, noteTime) ->
                            noteTypeToNoteShape noteTime
                [] -> 
                    group[]

-- Takes in a NoteTime, and returns the associated Shape.
noteTypeToNoteShape : NoteTime -> Shape userMsg
noteTypeToNoteShape noteTime =
    case noteTime of
        Whole -> 
            wholeNote black green 1 (0, 0)
            |> scale 0.5
        Half ->
            halfNote black green 1 (0, 0)
            |> scale 0.5
        Quarter ->
            quarterNote black green 1 (0, 0)
            |> scale 0.5
        Eighth ->
            square 5
            |> filled red 
        WholeRest ->
            group[]
        HalfRest ->
            group[]
        QuarterRest ->
            group[]
        EighthRest ->
            group[]

noteToGuitarGuideButton : Note -> Shape userMsg
noteToGuitarGuideButton note =
    case note of
        C -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-87.5,-87)
                |> scale 0.5
                |> makeTransparent 0.9,  
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-87.5,-87)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        CSharp -> 
            group[
            circle 5
            |> filled (rgb 4 251 4)
            |> move (-2.5,-55)
            |> scale 0.5 --      
            |> makeTransparent 0.9,   
            circle 5     
            |> outlined (solid 2.4) (rgb 4 251 4)     
            |> move (-2.5,-55)     
            |> scale 0.5      
            |> makeTransparent 0.7]
        D -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                -- filled red
                |> move (-45,-7)
                |> scale 0.5 --      
                |> makeTransparent 0.9,    
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-45,-7)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        DSharp -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-2.5,-87)
                |> scale 0.5 --      
                |> makeTransparent 0.9, 
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-2.5,-87)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        E -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (40,-7) -- -120
                |> scale 0.5
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (40,-7)   
                |> scale 0.5      
                |> makeTransparent 0.7]
        F -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-45,-39)
                |> scale 0.5 --      
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-45,-39)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        FSharp -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-87.5,-71)
                |> scale 0.5 --      
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-87.5,-71)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        G -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-130,-23)
                |> scale 0.5
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-130,-23)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        GSharp -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-87.5,-23)
                |> scale 0.5 --      
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-87.5,-23)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        A -> 
            group[
            circle 5
            |> filled (rgb 4 251 4)
            |> move (-172.5,-55)
            |> scale 0.5 --      
            |> makeTransparent 0.9,   
            circle 5     
            |> outlined (solid 2.4) (rgb 4 251 4)     
            |> move (-172.5,-55)     
            |> scale 0.5      
            |> makeTransparent 0.7]
        ASharp -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-130,-55)
                |> scale 0.5 --      
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-130,-55)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        B -> 
            group[
            circle 5
                |> filled (rgb 4 251 4)
                |> move (-172.5,-7)
                |> scale 0.5 --      
                |> makeTransparent 0.9,   
            circle 5     
                |> outlined (solid 2.4) (rgb 4 251 4)     
                |> move (-172.5,-7)     
                |> scale 0.5      
                |> makeTransparent 0.7]
        Rest -> 
            group[]

noteToGuitarGuidePosition : Note -> (Float, Float)
noteToGuitarGuidePosition note =
    case note of 
        C -> (-87.5,-87)
        CSharp -> (-2.5,-55)
        D -> (-45,-7)
        DSharp -> (-2.5,-87)
        E -> (40,-7)
        F -> (-45,-39)
        FSharp -> (-87.5,-71)
        G -> (-130,-23) 
        GSharp -> (-87.5,-23)
        A -> (-172.5,-55)
        ASharp -> (-130,-55)
        B -> (-172.5,-7)
        Rest -> (0, 0)

getFirstNoteFromList : List((Note, NoteTime)) -> Note
getFirstNoteFromList list =
    case list of
        (head::_) ->
            case head of 
                (note, _) ->
                    note
        [] ->
            Rest

noteToString : Note -> String
noteToString note =
    case note of
        C -> "C"
        CSharp -> "C#"
        D -> "D"
        DSharp -> "D#"
        E -> "E#"
        F -> "F"
        FSharp -> "F#"
        G -> "G"
        GSharp -> "G#"
        A -> "A"
        ASharp -> "A#"
        B -> "B"
        Rest -> "Rest"