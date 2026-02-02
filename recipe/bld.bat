@echo on
set BUILD_DIR=build

meson setup %BUILD_DIR% %MESON_ARGS% ^
    -Dsystemd=disabled
meson compile -C %BUILD_DIR%
meson test -C %BUILD_DIR% --print-errorlogs
meson install -C %BUILD_DIR%
