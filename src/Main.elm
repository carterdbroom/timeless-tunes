module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.EllieApp exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)
import Songs exposing (twinkle, smokeOnTheWater, eyeOfTheTiger)
import Game exposing (game)
import Shapes exposing (quarterNote, halfNote, wholeNote)
import GameMechanics exposing (updateGuideNote, updateNoteList, playTapAnimation)
import Ports exposing (..)
import Sounds exposing (..)



yDistance : (Float, Float) -> (Float, Float) -> Float
yDistance (s1, s2) (e1, e2) =
    abs(s2 - e2)

myShapes model =
    [
        game model
    ]


update : Types.Msg -> Model -> (Model, Cmd Types.Msg)
update msg model =
    case msg of
        Tick t _ ->
            ({ model | time = t }, Cmd.none)
        ToTitleScreen ->
            case model.state of
                InfoScreen ->
                    ({ model | state = TitleScreen, gameplayed = False, hoveringstart = False}, Cmd.none)
                _ ->
                    (model, Cmd.none)
        ToInfoScreen ->
            case model.state of
                TitleScreen ->
                    ({ model | state = InfoScreen }, Cmd.none)
                GameScreen ->
                    ({ model | state = InfoScreen, top = False, middle = False, bottom = False }, Cmd.none)
                HowToPlay ->
                    ({ model | state = InfoScreen, top = False, middle = False }, Cmd.none)
                _ ->
                    (model, Cmd.none)
        ToGameScreen ->
            case model.state of
                TitleScreen ->
                    ({ model | state = GameScreen, gameplayed = True, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0}, Cmd.none)
                InfoScreen ->
                    ({ model | state = GameScreen, hovering2 = False, startTime = model.time, guideNote = updateGuideNote (((Rest, QuarterRest))::twinkle), noteList = twinkle, sectionsCompleted = 0}, Cmd.none)
                PickASong ->
                    ({ model | state = GameScreen, gameplayed = True, hovering2 = False, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0}, Cmd.none)
                SongFinished ->
                    ({ model | state = GameScreen, gameplayed = True, hovering2 = False, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0}, Cmd.none)
                _ -> 
                    (model, Cmd.none)
        ToPickASong ->
            case model.state of
                InfoScreen ->
                    ({ model | state = PickASong, bottom = False}, Cmd.none)
                TitleScreen ->
                    ({ model | state = PickASong, bottom = False}, Cmd.none)
                HowToPlay ->
                    ({ model | state = PickASong, middle = False, bottom = False}, Cmd.none)
                _ ->
                    (model, Cmd.none)
        ToHowToPlay ->
            case model.state of
                InfoScreen ->
                    ({ model | state = HowToPlay, hovering2 = False, string1 = False, string2 = False, string3 = False, string4 = False, string5 = False, string6 = False}, Cmd.none)
                TitleScreen ->
                    ({ model | state = HowToPlay, hoveringstart = False}, Cmd.none)
                _ ->
                    (model, Cmd.none)
        HoverButton ->
            ({ model | hovering = True }, Cmd.none)
        DontHoverButton ->
            ({ model | hovering = False }, Cmd.none)
        HoverPause ->
            ({ model | hovering2 = True }, Cmd.none)
        NonHoverPause ->
            ({ model | hovering2 = False }, Cmd.none)
        Hover1 ->
            ({ model | string1 = True }, Cmd.none)
        NonHover1 ->
            ({ model | string1 = False }, Cmd.none)
        Hover2 ->
            ({ model | string2 = True }, Cmd.none)
        NonHover2 ->
            ({ model | string2 = False }, Cmd.none)
        Hover3 ->
            ({ model | string3 = True }, Cmd.none)
        NonHover3 ->
            ({ model | string3 = False }, Cmd.none)
        Hover4 ->
            ({ model | string4 = True }, Cmd.none)
        NonHover4 ->
            ({ model | string4 = False }, Cmd.none)
        Hover5 ->
            ({ model | string5 = True }, Cmd.none)
        NonHover5 ->
            ({ model | string5 = False }, Cmd.none)
        Hover6 ->
            ({ model | string6 = True }, Cmd.none)
        NonHover6 ->
            ({ model | string6 = False }, Cmd.none)
        HoverPlay ->
            ({ model | hoveringstart = True }, Cmd.none)
        NonHoverPlay ->
            ({ model | hoveringstart = False }, Cmd.none)
        HoverTop ->
            ({ model | top = True }, Cmd.none)
        NonHoverTop ->
            ({ model | top = False }, Cmd.none)
        HoverMiddle ->
            ({ model | middle = True }, Cmd.none)
        NonHoverMiddle ->
            ({ model | middle = False }, Cmd.none)
        HoverBottom ->
            ({ model | bottom = True }, Cmd.none)
        NonHoverBottom ->
            ({ model | bottom = False }, Cmd.none)
        ChangeTwinkleT ->
            ({ model | songname = TwinkleT, noteList = twinkle, totalSections = 41, gameplayed = True}, Cmd.none)
        ChangeSmokeOn ->
            ({ model | songname = SmokeOn, noteList = smokeOnTheWater, totalSections = 23, gameplayed = True}, Cmd.none)
        ChangeThird ->
            ({ model | songname = Third, noteList = eyeOfTheTiger, totalSections = 74, gameplayed = True}, Cmd.none)
        UpdateGuideNote list ->
            ({ model | waitTime = model.time, guideNote = updateGuideNote list  , noteList = (updateNoteList model.noteList), sectionsCompleted = model.sectionsCompleted + 1, state = (if model.sectionsCompleted == model.totalSections then SongFinished else model.state)}, Cmd.none)
        SongDone ->
            ({ model | state = SongFinished, top = False, middle = False, bottom = False}, Cmd.none)
        GuideNoteDown ->
            ({ model | guideNoteDown = True, guideNoteScale = 0.9 }, Cmd.none)
        GuideNoteUp ->
            ({ model | guideNoteDown = False, guideNoteScale = 1 }, Cmd.none)
        PlayNote note ->
            case note of 
                C -> (model, play cSound)
                CSharp -> (model, play cSharpSound)
                D -> (model, play dSound)
                DSharp -> (model, play dSharpSound)
                E -> (model, play eSound)
                F -> (model, play fSound)
                FSharp -> (model, play fSharpSound)
                G -> (model, play gSound)
                GSharp -> (model, play gSharpSound)
                A -> (model, play aSound)
                ASharp -> (model, play aSharpSound)
                B -> (model, play bSound)
                Rest -> (model, Cmd.none)
init : Model
init = {time = 0, 
        state = TitleScreen, 
        hovering = False , 
        hovering2 = False, 
        string1 = False, 
        string2 = False, 
        string3 = False, 
        string4 = False, 
        string5 = False, 
        string6 = False, 
        hoveringstart = False, 
        bottom = False, 
        middle = False, 
        top = False, 
        gameplayed = False,
        startTime = 0,
        songname = TwinkleT,
        guideNote = Rest,
        noteList = [],
        totalSections = 0,
        sectionsCompleted = 0,
        waitTime = 0,
        animationClickTime = 0,
        clickNote = Rest,
        guideNoteDown = False,
        guideNoteScale = 1
    }

subscriptions : Model -> Sub Types.Msg
subscriptions model = Sub.none

main : EllieAppWithTick () Model Types.Msg
main = 
    ellieAppWithTick Tick
        { init = \flags -> (init, Cmd.none), view = view, update = update, subscriptions = subscriptions }

view : Model -> { title: String, body : Collage Types.Msg }
view model = { title = "Timeless Tunes", body = collage 192 128 (myShapes model) }

