
// QGSCONFIG.H

#ifndef QGSCONFIG_H
#define QGSCONFIG_H

// Version must be specified according to
// <int>.<int>.<int>-<any text>.
// or else upgrading old project file will not work
// reliably.
// TODO QGIS 4: remove in favor of _QGIS_VERSION
#define VERSION "3.13.0-Master"
#define _QGIS_VERSION "3.13.0-Master"

//used in vim src/core/qgis.cpp
//The way below should work but it resolves to a number like 0110 which the compiler treats as octal I think
//because debuggin it out shows the decimal number 72 which results in incorrect version status.
//As a short term fix I (Tim) am defining the version in top level cmake. It would be good to
//reinstate this more generic approach below at some point though
//#define VERSION_INT 3130
// TODO QGIS 4: Remove in favor of _QGIS_VERSION_INT
#define VERSION_INT 31300
#define _QGIS_VERSION_INT 31300
#define ABISYM(x) x ## 31300
//used in main.cpp and anywhere else where the release name is needed
#define RELEASE_NAME "Master"

#define QGIS_PLUGIN_SUBDIR "lib/qgis/plugins"
#define QGIS_DATA_SUBDIR "share/qgis"
#define QGIS_LIBEXEC_SUBDIR "lib/qgis"
#define QGIS_LIB_SUBDIR "lib"
#define QGIS_QML_SUBDIR "qml"
#define CMAKE_INSTALL_PREFIX "/usr/local"
#define CMAKE_SOURCE_DIR "/mnt/storage/QGIS"

#define QGIS_SERVER_MODULE_SUBDIR "lib/qgis/server"

#define QSCINTILLA_VERSION_STR "2.10.2"

#if defined( __APPLE__ )
//used by Mac to find system or bundle resources relative to amount of bundling
#define QGIS_MACAPP_BUNDLE 
#endif

#define QT_PLUGINS_DIR "/usr/lib/x86_64-linux-gnu/qt5/plugins"
#define OSG_PLUGINS_PATH ""

/* #undef USING_NMAKE */

/* #undef USING_NINJA */

#define HAVE_GUI

#define HAVE_POSTGRESQL

/* #undef HAVE_ORACLE */

/* #undef HAVE_OSGEARTHQT */

/* #undef SERVER_SKIP_ECW */

/* #undef HAVE_SERVER_PYTHON_PLUGINS */

#define HAVE_OPENCL

/* #undef ENABLE_MODELTEST */

/* #undef HAVE_3D */

#define USE_THREAD_LOCAL

/* #undef QGISDEBUG */

/* #undef HAVE_QUICK */

//#define HAVE_QT5SERIALPORT

/* #undef HAVE_STATIC_PROVIDERS */

#endif

