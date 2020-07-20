# -*- coding: utf-8 -*-

"""
***************************************************************************
    menus.py
    ---------------------
    Date                 : February 2016
    Copyright            : (C) 2016 by Victor Olaya
    Email                : volayaf at gmail dot com
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""

__author__ = 'Victor Olaya'
__date__ = 'February 2016'
__copyright__ = '(C) 2016, Victor Olaya'

import os
from qgis.PyQt.QtCore import QCoreApplication
from qgis.PyQt.QtWidgets import QAction, QMenu
from qgis.PyQt.QtGui import QIcon
from qgis.PyQt.QtWidgets import QApplication
from processing.core.ProcessingConfig import ProcessingConfig, Setting
from processing.gui.MessageDialog import MessageDialog
from processing.gui.AlgorithmDialog import AlgorithmDialog
from qgis.utils import iface
from qgis.core import QgsApplication, QgsMessageLog, QgsStringUtils, QgsProcessingAlgorithm
from qgis.gui import QgsGui
from processing.gui.MessageBarProgress import MessageBarProgress
from processing.gui.AlgorithmExecutor import execute
from processing.gui.Postprocessing import handleAlgorithmResults
from processing.core.Processing import Processing
from processing.tools import dataobjects

algorithmsToolbar = None
menusSettingsGroup = 'Menus'

defaultMenuEntries = {}
vectorMenu = QApplication.translate('MainWindow', 'Vect&or')
# analysisToolsMenu = vectorMenu + "/" + Processing.tr('&Analysis Tools')
analysisToolsMenu = [vectorMenu + "/" + Processing.tr('&Analysis Tools'), vectorMenu + "/" + 'Analysis_Tools']
defaultMenuEntries.update({'qgis:distancematrix': analysisToolsMenu,
                           'native:sumlinelengths': analysisToolsMenu,
                           'native:countpointsinpolygon': analysisToolsMenu,
                           'qgis:listuniquevalues': analysisToolsMenu,
                           'qgis:basicstatisticsforfields': analysisToolsMenu,
                           'native:nearestneighbouranalysis': analysisToolsMenu,
                           'native:meancoordinates': analysisToolsMenu,
                           'native:lineintersections': analysisToolsMenu})
# researchToolsMenu = vectorMenu + "/" + Processing.tr('&Research Tools')
researchToolsMenu = [vectorMenu + "/" + Processing.tr('&Research Tools'), vectorMenu + "/" + 'Research_Tools']
defaultMenuEntries.update({'native:creategrid': researchToolsMenu,
                           'qgis:randomselection': researchToolsMenu,
                           'qgis:randomselectionwithinsubsets': researchToolsMenu,
                           'native:randompointsinextent': researchToolsMenu,
                           'qgis:randompointsinlayerbounds': researchToolsMenu,
                           'native:randompointsinpolygons': researchToolsMenu,
                           'qgis:randompointsinsidepolygons': researchToolsMenu,
                           'qgis:randompointsonlines': researchToolsMenu,
                           'qgis:regularpoints': researchToolsMenu,
                           'native:selectbylocation': researchToolsMenu,
                           'native:polygonfromlayerextent': researchToolsMenu})
# geoprocessingToolsMenu = vectorMenu + "/" + Processing.tr('&Geoprocessing Tools')
geoprocessingToolsMenu = [vectorMenu + "/" + Processing.tr('&Geoprocessing Tools'), vectorMenu + "/" + 'Geoprocessing_Tools']
defaultMenuEntries.update({'native:buffer': geoprocessingToolsMenu,
                           'native:convexhull': geoprocessingToolsMenu,
                           'native:intersection': geoprocessingToolsMenu,
                           'native:union': geoprocessingToolsMenu,
                           'native:symmetricaldifference': geoprocessingToolsMenu,
                           'native:clip': geoprocessingToolsMenu,
                           'native:difference': geoprocessingToolsMenu,
                           'native:dissolve': geoprocessingToolsMenu,
                           'qgis:eliminateselectedpolygons': geoprocessingToolsMenu})
# geometryToolsMenu = vectorMenu + "/" + Processing.tr('G&eometry Tools')
geometryToolsMenu = [vectorMenu + "/" + Processing.tr('G&eometry Tools'), vectorMenu + "/" + 'Geometry_Tools']
defaultMenuEntries.update({'qgis:checkvalidity': geometryToolsMenu,
                           'qgis:exportaddgeometrycolumns': geometryToolsMenu,
                           'native:centroids': geometryToolsMenu,
                           'qgis:delaunaytriangulation': geometryToolsMenu,
                           'qgis:voronoipolygons': geometryToolsMenu,
                           'native:simplifygeometries': geometryToolsMenu,
                           'native:densifygeometries': geometryToolsMenu,
                           'native:multiparttosingleparts': geometryToolsMenu,
                           'native:collect': geometryToolsMenu,
                           'native:polygonstolines': geometryToolsMenu,
                           'qgis:linestopolygons': geometryToolsMenu,
                           'native:extractvertices': geometryToolsMenu})
# managementToolsMenu = vectorMenu + "/" + Processing.tr('&Data Management Tools')
managementToolsMenu = [vectorMenu + "/" + Processing.tr('&Data Management Tools'), vectorMenu + "/" + 'Data_Management_Tools']
defaultMenuEntries.update({'native:reprojectlayer': managementToolsMenu,
                           'native:joinattributesbylocation': managementToolsMenu,
                           'native:splitvectorlayer': managementToolsMenu,
                           'native:mergevectorlayers': managementToolsMenu,
                           'native:createspatialindex': managementToolsMenu})

rasterMenu = QApplication.translate('MainWindow', '&Raster')
projectionsMenu = [rasterMenu + "/" + Processing.tr('Projections'), rasterMenu + "/" + 'Projections']
defaultMenuEntries.update({'gdal:warpreproject': projectionsMenu,
                           'gdal:extractprojection': projectionsMenu,
                           'gdal:assignprojection': projectionsMenu})
# conversionMenu = rasterMenu + "/" + Processing.tr('Conversion')
conversionMenu = [rasterMenu + "/" + Processing.tr('Conversion'), rasterMenu + "/" + 'Conversion']
defaultMenuEntries.update({'gdal:rasterize': conversionMenu,
                           'gdal:polygonize': conversionMenu,
                           'gdal:translate': conversionMenu,
                           'gdal:rgbtopct': conversionMenu,
                           'gdal:pcttorgb': conversionMenu})
# extractionMenu = rasterMenu + "/" + Processing.tr('Extraction')
extractionMenu = [rasterMenu + "/" + Processing.tr('Extraction'), rasterMenu + "/" + 'Extraction']
defaultMenuEntries.update({'gdal:contour': extractionMenu,
                           'gdal:cliprasterbyextent': extractionMenu,
                           'gdal:cliprasterbymasklayer': extractionMenu})
# analysisMenu = rasterMenu + "/" + Processing.tr('Analysis')
analysisMenu = [rasterMenu + "/" + Processing.tr('Analysis'), rasterMenu + "/" + 'Analysis']
defaultMenuEntries.update({'gdal:sieve': analysisMenu,
                           'gdal:nearblack': analysisMenu,
                           'gdal:fillnodata': analysisMenu,
                           'gdal:proximity': analysisMenu,
                           'gdal:griddatametrics': analysisMenu,
                           'gdal:gridaverage': analysisMenu,
                           'gdal:gridinversedistance': analysisMenu,
                           'gdal:gridnearestneighbor': analysisMenu,
                           'gdal:aspect': analysisMenu,
                           'gdal:hillshade': analysisMenu,
                           'gdal:roughness': analysisMenu,
                           'gdal:slope': analysisMenu,
                           'gdal:tpitopographicpositionindex': analysisMenu,
                           'gdal:triterrainruggednessindex': analysisMenu})
# miscMenu = rasterMenu + "/" + Processing.tr('Miscellaneous')
miscMenu = [rasterMenu + "/" + Processing.tr('Miscellaneous'), rasterMenu + "/" + 'Miscellaneous']
defaultMenuEntries.update({'gdal:buildvirtualraster': miscMenu,
                           'gdal:merge': miscMenu,
                           'gdal:gdalinfo': miscMenu,
                           'gdal:overviews': miscMenu,
                           'gdal:tileindex': miscMenu})


def initializeMenus():
    for m in defaultMenuEntries.keys():
        alg = QgsApplication.processingRegistry().algorithmById(m)
        if alg is None or alg.id() != m:
            QgsMessageLog.logMessage(Processing.tr('Invalid algorithm ID for menu: {}').format(m), Processing.tr('Processing'))

    for provider in QgsApplication.processingRegistry().providers():
        for alg in provider.algorithms():
            d = defaultMenuEntries.get(alg.id(), "")
            if len(d) == 2:
                setting = Setting(menusSettingsGroup, "MENU_" + alg.id(),
                                  "Menu path", d[0])
                ProcessingConfig.addSetting(setting)
                setting = Setting(menusSettingsGroup, "OBJ_NAME_" + alg.id(),
                                  "Object name", d[1])
                ProcessingConfig.addSetting(setting)
            setting = Setting(menusSettingsGroup, "BUTTON_" + alg.id(),
                              "Add button", False)
            ProcessingConfig.addSetting(setting)
            setting = Setting(menusSettingsGroup, "ICON_" + alg.id(),
                              "Icon", "", valuetype=Setting.FILE)
            ProcessingConfig.addSetting(setting)

    ProcessingConfig.readSettings()


def updateMenus():
    removeMenus()
    QCoreApplication.processEvents()
    createMenus()


def createMenus():
    for alg in QgsApplication.processingRegistry().algorithms():
        menuPath = ProcessingConfig.getSetting("MENU_" + alg.id())
        object_name = ProcessingConfig.getSetting("OBJ_NAME_" + alg.id())
        if object_name is not None:
            object_name = object_name.split("/")[-1]
        addButton = ProcessingConfig.getSetting("BUTTON_" + alg.id())
        icon = ProcessingConfig.getSetting("ICON_" + alg.id())
        if icon and os.path.exists(icon):
            icon = QIcon(icon)
        else:
            icon = None
        if menuPath:
            paths = menuPath.split("/")
            addAlgorithmEntry(alg, paths[0], paths[-1], object_name, addButton=addButton, icon=icon)


def removeMenus():
    for alg in QgsApplication.processingRegistry().algorithms():
        menuPath = ProcessingConfig.getSetting("MENU_" + alg.id())
        if menuPath:
            paths = menuPath.split("/")
            removeAlgorithmEntry(alg, paths[0], paths[-1])


def addAlgorithmEntry(alg, menuName, submenuName, object_name, actionText=None, icon=None, addButton=False):
    if actionText is None:
        if (QgsGui.higFlags() & QgsGui.HigMenuTextIsTitleCase) and not (alg.flags() & QgsProcessingAlgorithm.FlagDisplayNameIsLiteral):
            alg_title = QgsStringUtils.capitalize(alg.displayName(), QgsStringUtils.TitleCase)
        else:
            alg_title = alg.displayName()
        actionText = alg_title + QCoreApplication.translate('Processing', '…')
    action = QAction(icon or alg.icon(), actionText, iface.mainWindow())
    alg_id = alg.id()
    action.setData(alg_id)
    action.triggered.connect(lambda: _executeAlgorithm(alg_id))
    action.setObjectName("mProcessingUserMenu_%s" % alg_id)

    if menuName:
        menu = getMenu(menuName, iface.mainWindow().menuBar())
        submenu = getMenu(submenuName, menu)
        submenu.setObjectName(object_name)
        submenu.addAction(action)

    if addButton:
        global algorithmsToolbar
        if algorithmsToolbar is None:
            algorithmsToolbar = iface.addToolBar(QCoreApplication.translate('MainWindow', 'Processing Algorithms'))
            algorithmsToolbar.setObjectName("ProcessingAlgorithms")
            algorithmsToolbar.setToolTip(QCoreApplication.translate('MainWindow', 'Processing Algorithms Toolbar'))
        algorithmsToolbar.addAction(action)


def removeAlgorithmEntry(alg, menuName, submenuName, delButton=True):
    if menuName:
        menu = getMenu(menuName, iface.mainWindow().menuBar())
        subMenu = getMenu(submenuName, menu)
        action = findAction(subMenu.actions(), alg)
        if action is not None:
            subMenu.removeAction(action)

        if len(subMenu.actions()) == 0:
            subMenu.deleteLater()

    if delButton:
        global algorithmsToolbar
        if algorithmsToolbar is not None:
            action = findAction(algorithmsToolbar.actions(), alg)
            if action is not None:
                algorithmsToolbar.removeAction(action)


def _executeAlgorithm(alg_id):
    alg = QgsApplication.processingRegistry().createAlgorithmById(alg_id)
    if alg is None:
        dlg = MessageDialog()
        dlg.setTitle(Processing.tr('Missing Algorithm'))
        dlg.setMessage(
            Processing.tr('The algorithm "{}" is no longer available. (Perhaps a plugin was uninstalled?)').format(alg_id))
        dlg.exec_()
        return

    ok, message = alg.canExecute()
    if not ok:
        dlg = MessageDialog()
        dlg.setTitle(Processing.tr('Missing Dependency'))
        dlg.setMessage(
            Processing.tr('<h3>Missing dependency. This algorithm cannot '
                          'be run :-( </h3>\n{0}').format(message))
        dlg.exec_()
        return

    if (alg.countVisibleParameters()) > 0:
        dlg = alg.createCustomParametersWidget(parent=iface.mainWindow())
        if not dlg:
            dlg = AlgorithmDialog(alg, parent=iface.mainWindow())
        canvas = iface.mapCanvas()
        prevMapTool = canvas.mapTool()
        dlg.show()
        dlg.exec_()
        if canvas.mapTool() != prevMapTool:
            try:
                canvas.mapTool().reset()
            except:
                pass
            canvas.setMapTool(prevMapTool)
    else:
        feedback = MessageBarProgress()
        context = dataobjects.createContext(feedback)
        parameters = {}
        ret, results = execute(alg, parameters, context, feedback)
        handleAlgorithmResults(alg, context, feedback)
        feedback.close()


def getMenu(name, parent):
    menus = [c for c in parent.children() if isinstance(c, QMenu) and c.title() == name]
    if menus:
        return menus[0]
    else:
        return parent.addMenu(name)


def findAction(actions, alg):
    for action in actions:
        if action.data() == alg.id():
            return action
    return None
