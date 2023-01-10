@echo off
setlocal ENABLEDELAYEDEXPANSION
for %%f in (*.png) do (
    for /f %%c in ('magick identify -format "%%[colorspace]" "%%f"') do (
        if "%%c" EQU "sRGB" (
            for /f %%t in ('magick identify -format "%%[type]" "%%f"') do (
                if "%%t" NEQ "Palette" (
                    for /f %%i in ('magick convert "%%f" -colorspace HSB -channel g -separate +channel -format "%%[fx:round(mean*100)]" info:') do (
                        if %%i LEQ 5 (
                            @echo on
                            echo ""%%f" "%%c" "%%t" "%%i" "grayscale"
                            @echo off
                            pingo -sb -strip -grayscale ""%%f"
                        ) else (
                            @echo on
                            echo ""%%f" "%%c" "%%t" "%%i" "color"
                            @echo off
                            pingo -jpgquality=90 "%%f"
                        )
                    )
                )
            )   
        )
    )
)