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
                            magick "%%f" -colorspace gray -quality 100 "%%f"
                        ) else (
                            @echo on
                            echo ""%%f" "%%c" "%%t" "%%i" "color"
                            @echo off
                            magick "%%f" -quality 90 "%%~dnf".jpg
                        )
                    )
                )
            )   
        )
    )
)