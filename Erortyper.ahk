;Force AutoHotkey to treat files as UTF-8
FileEncoding, UTF-8

; Emergency Stop Hotkey (Ctrl + Esc)
^Esc::
{
    ExitApp  ; Stops the entire script
}

^+v::
{
    ; Get the text from the clipboard
    textToType := /beg

    ; Loop through each character in the text
    for each, char in StrSplit(textToType)
    {
        ; 0% chance to enter error mode
        if (Random(1, 100) <= 1)
        {
            ; Generate 1-3 random characters for the error
            errorLength := Random(1, 3)
            randomChars := ""
            Loop, %errorLength%
            {   
                randomChar := Chr(Random(97, 122)) ; Random lowercase letter (a-z)
                randomChars .= randomChar
            }
            
            ; Type the random characters
            Send %randomChars%
            
            ; Big pause before backspacing
            Sleep, 400  ; Longer pause before pressing backspace
            
            ; Backspace the same number of times
            Loop, %errorLength%
            {
                Send {Backspace}
                Sleep, 100  ; Shorter pause between each backspace
            }
        }

        ; Type the actual intended character
        Send %char%
        
        ; Set different pauses based on the character type with ±20% random variation
        if (char = " ")
        {
            ; Base sleep for space is 120ms ± 20%
            Sleep, % RandomVariation(10)
        }
        else if (char = ".")
        {
            ; Base sleep for periods is 500ms ± 20%
            Sleep, % RandomVariation(100)
        }
        else
        {
            ; Base sleep for regular letters is 30ms ± 20%
            Sleep, % RandomVariation(10)
        }
    }
}
return

; Helper function to generate a random number in a range
Random(min, max)
{
    Random, result, %min%, %max%
    return result
}

; Helper function to introduce ±20% variation to a base value
RandomVariation(baseValue)
{
    variation := baseValue * 0.2  ; Calculate 20% of the base value
    return Random(baseValue - variation, baseValue + variation)  ; Return a value between -20% and +20% of base value
}

