module Songs exposing (..)

import Types exposing (..)

twinkle : List (Note, NoteTime)
twinkle 
    =   [ 
            (C, Quarter),
            (C, Quarter),
            (G, Quarter),
            (G, Quarter),

            (A, Quarter),
            (A, Quarter),
            (G, Half),

            (F, Quarter),
            (F, Quarter),
            (E, Quarter),
            (E, Quarter),

            (D, Quarter),
            (D, Quarter),
            (C, Half),

            (G, Quarter),
            (G, Quarter),
            (F, Quarter),
            (F, Quarter),

            (E, Quarter),
            (E, Quarter),
            (D, Half),

            (G, Quarter),
            (G, Quarter),
            (F, Quarter),
            (F, Quarter),

            (E, Quarter),
            (E, Quarter),
            (D, Half),

            (C, Quarter),
            (C, Quarter),
            (G, Quarter),
            (G, Quarter),

            (A, Quarter),
            (A, Quarter),
            (G, Half),

            (F, Quarter),
            (F, Quarter),
            (E, Quarter),
            (E, Quarter),

            (D, Quarter),
            (D, Quarter),
            (C, Half)
        ]

smokeOnTheWater : List (Note, NoteTime)
smokeOnTheWater 
    =   [ 
            -- TIME SIGNATURE: 4/4
            (G, Eighth),
            -- need an eighth rest here.
            (ASharp, Eighth),
            -- need an eighth rest here
            (C, Quarter),
            -- need an eighth rest here
            (G, Eighth),
            -- need an eighth rest here

            (ASharp, Eighth),
            -- need an eighth rest here
            (CSharp, Eighth),
            (C, Half),
            -- need an eighth rest here

            (G, Eighth),
            -- need an eighth rest here.
            (ASharp, Eighth),
            -- need an eighth rest here
            (C, Quarter),
            -- need an eighth rest here
            (ASharp, Eighth),
            
            -- need an quarter rest
            (G, Half),
            -- need an quarter rest

                        (G, Eighth),
            -- need an eighth rest here.
            (ASharp, Eighth),
            -- need an eighth rest here
            (C, Quarter),
            -- need an eighth rest here
            (G, Eighth),
            -- need an eighth rest here

            (ASharp, Eighth),
            -- need an eighth rest here
            (CSharp, Eighth),
            (C, Half),
            -- need an eighth rest here

            (G, Eighth),
            -- need an eighth rest here.
            (ASharp, Eighth),
            -- need an eighth rest here
            (C, Quarter),
            -- need an eighth rest here
            (ASharp, Eighth),
            
            -- need an quarter rest
            (G, Half)
            -- need an quarter rest
        ]