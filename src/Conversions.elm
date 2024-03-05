module Conversions exposing (..)
import Types exposing (Note)
import Types exposing (Note(..))

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