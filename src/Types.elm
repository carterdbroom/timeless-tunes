module Types exposing (..)

import GraphicSVG.App exposing (..)

type Note
    = C
    | CSharp
    | D
    | DSharp
    | E
    | F
    | FSharp
    | G
    | GSharp
    | A
    | ASharp
    | B 
    | Rest

type NoteTime
    = Whole
    | Half
    | Quarter
    | Eighth
    | WholeRest
    | HalfRest
    | QuarterRest
    | EighthRest

type Song
    = Twinkle (List (Note, NoteTime))

type alias Model = { time : Float, 
                    state : State, 
                    hovering : Bool, 
                    hovering2 : Bool, 
                    string1 : Bool, 
                    string2 : Bool, 
                    string3 : Bool, 
                    string4 : Bool, 
                    string5 : Bool, 
                    string6 : Bool, 
                    hoveringstart : Bool, 
                    bottom : Bool,
                    middle : Bool, 
                    top : Bool, 
                    gameplayed : Bool,
                    startTime : Float,
                    songname : SongState,
                    guideNote : Note,
                    noteList : (List ((Note, NoteTime))),
                    totalSections : Float,
                    sectionsCompleted : Float,
                    waitTime : Float,
                    animationClickTime : Float,
                    clickNote : Note
                }


type Msg = Tick Float GetKeyState
        | ToTitleScreen
        | ToInfoScreen
        | ToGameScreen
        | HoverButton
        | DontHoverButton
        | HoverPause 
        | NonHoverPause
        | Hover1
        | NonHover1
        | Hover2
        | NonHover2
        | Hover3
        | NonHover3
        | Hover4
        | NonHover4
        | Hover5
        | NonHover5
        | Hover6
        | NonHover6
        | HoverPlay
        | NonHoverPlay
        | HoverTop
        | NonHoverTop
        | HoverMiddle
        | NonHoverMiddle
        | HoverBottom
        | NonHoverBottom
        | ToHowToPlay
        | ToPickASong
        | ChangeTwinkleT
        | ChangeSmokeOn
        | ChangeThird
        | UpdateGuideNote (List ((Note, NoteTime)))
        | SongDone
        --| PlayTapAnimation (List ((Note, NoteTime)))
        

type State = TitleScreen
        | InfoScreen
        | GameScreen
        | HowToPlay
        | PickASong
        | SongFinished

type SongState = TwinkleT
        | SmokeOn
        | Third
