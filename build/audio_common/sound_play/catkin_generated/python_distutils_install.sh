#!/bin/sh -x

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

cd "/home/satellite/factorymonitor/src/audio_common/sound_play"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
/usr/bin/env \
    PYTHONPATH="/home/satellite/factorymonitor/install/lib/python2.7/dist-packages:/home/satellite/factorymonitor/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/satellite/factorymonitor/build" \
    "/usr/bin/python" \
    "/home/satellite/factorymonitor/src/audio_common/sound_play/setup.py" \
    build --build-base "/home/satellite/factorymonitor/build/audio_common/sound_play" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/satellite/factorymonitor/install" --install-scripts="/home/satellite/factorymonitor/install/bin"
