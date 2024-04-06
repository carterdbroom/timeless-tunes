module Main exposing (..)

import GraphicSVG exposing (..)
import GraphicSVG.App exposing (..)
import GraphicSVG.Secret exposing (Pull(..))
import Types exposing (..)
import Conversions exposing (noteToStartPosition, noteToEndPosition, noteTimeToSecond, noteTypeToNoteShape, getStartNoteShapeFromSong, getStartPositionFromSong)
import Songs exposing (twinkle, smokeOnTheWater, eyeOfTheTiger)
import Game exposing (game)
import Shapes exposing (quarterNote, halfNote, wholeNote)
import GameMechanics exposing (updateGuideNote, updateNoteList, playTapAnimation)




yDistance : (Float, Float) -> (Float, Float) -> Float
yDistance (s1, s2) (e1, e2) =
    abs(s2 - e2)

myShapes model =
    [
        game model
    ]



update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        ToTitleScreen ->
            case model.state of
                InfoScreen ->
                    { model | state = TitleScreen }
                _ ->
                    model
        ToInfoScreen ->
            case model.state of
                TitleScreen ->
                    { model | state = InfoScreen }
                GameScreen ->
                    { model | state = InfoScreen, top = False, middle = False, bottom = False }
                HowToPlay ->
                    { model | state = InfoScreen, top = False, middle = False }
                _ ->
                    model
        ToGameScreen ->
            case model.state of
                TitleScreen ->
                    { model | state = GameScreen, gameplayed = True, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0} -- note list total sections
                InfoScreen ->
                    { model | state = GameScreen, hovering2 = False, startTime = model.time, guideNote = updateGuideNote (((Rest, QuarterRest))::twinkle), noteList = twinkle, sectionsCompleted = 0}
                PickASong ->
                    { model | state = GameScreen, gameplayed = True, hovering2 = False, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0}
                SongFinished ->
                  { model | state = GameScreen, gameplayed = True, hovering2 = False, startTime = model.time, guideNote = (if model.songname == TwinkleT then updateGuideNote (((Rest, QuarterRest))::twinkle) else updateGuideNote (((Rest, QuarterRest))::smokeOnTheWater)), sectionsCompleted = 0}
                _ -> 
                    model
        ToPickASong ->
            case model.state of
                InfoScreen ->
                    { model | state = PickASong }
                TitleScreen ->
                    { model | state = PickASong }
                HowToPlay ->
                    { model | state = PickASong, middle = False}
                _ ->
                    model
        ToHowToPlay ->
            case model.state of
                InfoScreen ->
                    { model | state = HowToPlay, hovering2 = False }
                TitleScreen ->
                    { model | state = HowToPlay, hoveringstart = False}
                _ ->
                    model
        HoverButton ->
            { model | hovering = True }
        DontHoverButton ->
            { model | hovering = False }
        HoverPause ->
            { model | hovering2 = True }
        NonHoverPause ->
            { model | hovering2 = False }
        Hover1 ->
            { model | string1 = True }
        NonHover1 ->
            { model | string1 = False }
        Hover2 ->
            { model | string2 = True }
        NonHover2 ->
            { model | string2 = False }
        Hover3 ->
            { model | string3 = True }
        NonHover3 ->
            { model | string3 = False }
        Hover4 ->
            { model | string4 = True }
        NonHover4 ->
            { model | string4 = False }
        Hover5 ->
            { model | string5 = True }
        NonHover5 ->
            { model | string5 = False }
        Hover6 ->
            { model | string6 = True }
        NonHover6 ->
            { model | string6 = False }
        HoverPlay ->
            { model | hoveringstart = True }
        NonHoverPlay ->
            { model | hoveringstart = False }
        HoverTop ->
            { model | top = True }
        NonHoverTop ->
            { model | top = False }
        HoverMiddle ->
            { model | middle = True }
        NonHoverMiddle ->
            { model | middle = False }
        HoverBottom ->
            { model | bottom = True }
        NonHoverBottom ->
            { model | bottom = False }
        ChangeTwinkleT ->
            { model | songname = TwinkleT, noteList = twinkle, totalSections = 42}
        ChangeSmokeOn ->
            { model | songname = SmokeOn, noteList = smokeOnTheWater, totalSections = 24}
        ChangeThird ->
            { model | songname = Third, noteList = eyeOfTheTiger, totalSections = 75}
        UpdateGuideNote list ->
            { model | waitTime = model.time, guideNote = updateGuideNote list  , noteList = (updateNoteList model.noteList), sectionsCompleted = model.sectionsCompleted + 1, state = (if model.sectionsCompleted == model.totalSections then SongFinished else model.state)}
        SongDone ->
          { model | state = SongFinished }
        GuideNoteDown ->
                { model | guideNoteDown = True, guideNoteScale = 0.8 }
        GuideNoteUp ->
                { model | guideNoteDown = False, guideNoteScale = 1 }

        




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
        totalSections = 42,
        sectionsCompleted = 0,
        waitTime = 0,
        animationClickTime = 0,
        clickNote = Rest,
        guideNoteDown = False,
        guideNoteScale = 1
    }


view model = collage 192 128 (myShapes model)

main = gameApp Tick { model = init, view = view, update = update, title = "Timeless Tunes" }
