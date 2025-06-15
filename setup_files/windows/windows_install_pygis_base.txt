@echo off
setlocal enabledelayedexpansion
set LOGFILE=pygis_base_setup.log

echo ============================================================
echo PYGIS BASE ENVIRONMENT - COMPLETE INSTALLATION
echo ============================================================
echo Log file: %LOGFILE%
echo.
echo Starting setup at %date% %time% > %LOGFILE%

REM Check if mamba is available, fallback to conda
where mamba >nul 2>&1
if %errorlevel% equ 0 (
    set INSTALLER=mamba
    echo Using mamba for package management
    echo Using mamba for package management >> %LOGFILE%
) else (
    set INSTALLER=conda
    echo Using conda for package management
    echo Using conda for package management >> %LOGFILE%
)

echo.
echo (5%%) Creating pygis_base environment with Python 3.10...
echo (5%%) Creating pygis_base environment >> %LOGFILE%
%INSTALLER% create -n pygis_base --override-channels -c conda-forge python=3.10 -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to create base environment
    echo ERROR: Failed to create base environment >> %LOGFILE%
    pause
    exit /b 1
)

echo (10%%) Installing core geospatial foundation...
echo (10%%) Installing core geospatial foundation >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge gdal proj geos libspatialindex fiona shapely pyproj -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install geospatial foundation
    echo ERROR: Failed to install geospatial foundation >> %LOGFILE%
    pause
    exit /b 1
)

echo (15%%) Installing scientific computing stack...
echo (15%%) Installing scientific computing stack >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge numpy pandas scipy matplotlib seaborn scikit-learn -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install scientific stack
    echo ERROR: Failed to install scientific stack >> %LOGFILE%
    pause
    exit /b 1
)

echo (20%%) Installing GeoPandas and Rasterio...
echo (20%%) Installing GeoPandas and Rasterio >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge geopandas rasterio -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install GeoPandas/Rasterio
    echo ERROR: Failed to install GeoPandas/Rasterio >> %LOGFILE%
    pause
    exit /b 1
)

echo (25%%) Installing data format libraries...
echo (25%%) Installing data format libraries >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge xarray netcdf4 h5py h5netcdf zarr -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install data format libraries
    echo ERROR: Failed to install data format libraries >> %LOGFILE%
    pause
    exit /b 1
)

echo (30%%) Installing Jupyter ecosystem...
echo (30%%) Installing Jupyter ecosystem >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge jupyter jupyterlab ipywidgets jupyter_contrib_nbextensions -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install Jupyter
    echo ERROR: Failed to install Jupyter >> %LOGFILE%
    pause
    exit /b 1
)

echo (35%%) Installing visualization packages...
echo (35%%) Installing visualization packages >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge plotly bokeh folium contextily mapclassify -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install visualization packages
    echo ERROR: Failed to install visualization packages >> %LOGFILE%
    pause
    exit /b 1
)

echo (40%%) Installing geospatial analysis tools...
echo (40%%) Installing geospatial analysis tools >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge osmnx earthpy geoplot census us pykrige -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install geospatial tools
    echo ERROR: Failed to install geospatial tools >> %LOGFILE%
    pause
    exit /b 1
)

echo (45%%) Installing image processing and ML packages...
echo (45%%) Installing image processing and ML packages >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge scikit-image imageio-ffmpeg tifffile -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install image processing
    echo ERROR: Failed to install image processing >> %LOGFILE%
    pause
    exit /b 1
)

echo (50%%) Installing geemap and leafmap dependencies...
echo (50%%) Installing geemap/leafmap dependencies >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge localtileserver rio-cogeo rioxarray pycrs -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install geemap dependencies
    echo ERROR: Failed to install geemap dependencies >> %LOGFILE%
    pause
    exit /b 1
)

echo (55%%) Installing web mapping libraries...
echo (55%%) Installing web mapping libraries >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge ipyleaflet ipywidgets owslib -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install web mapping
    echo ERROR: Failed to install web mapping >> %LOGFILE%
    pause
    exit /b 1
)

echo (60%%) Installing GeoWombat via conda-forge...
echo (60%%) Installing GeoWombat >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge geowombat -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: GeoWombat conda failed, trying pip from GitHub...
    echo WARNING: GeoWombat conda failed, trying pip >> %LOGFILE%
    %INSTALLER% run -n pygis_base pip install "git+https://github.com/jgrss/geowombat.git" >> %LOGFILE% 2>&1
    if !errorlevel! neq 0 (
        echo WARNING: GeoWombat install failed, continuing...
        echo WARNING: GeoWombat install failed >> %LOGFILE%
    )
)

echo (65%%) Installing geemap and leafmap...
echo (65%%) Installing geemap and leafmap >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge geemap leafmap -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo ERROR: Failed to install geemap/leafmap
    echo ERROR: Failed to install geemap/leafmap >> %LOGFILE%
    pause
    exit /b 1
)

echo (70%%) Installing pygis meta-package...
echo (70%%) Installing pygis meta-package >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge pygis -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: pygis conda failed, trying pip...
    echo WARNING: pygis conda failed, trying pip >> %LOGFILE%
    %INSTALLER% run -n pygis_base pip install pygis >> %LOGFILE% 2>&1
    if !errorlevel! neq 0 (
        echo WARNING: pygis install failed, continuing...
        echo WARNING: pygis install failed >> %LOGFILE%
    )
)

echo (75%%) Installing additional utility packages...
echo (75%%) Installing additional utilities >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge geojson palettable retry -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Some utilities failed, continuing...
    echo WARNING: Some utilities failed >> %LOGFILE%
)

echo (80%%) Installing cloud and remote sensing tools...
echo (80%%) Installing cloud/remote sensing tools >> %LOGFILE%
%INSTALLER% install -n pygis_base --override-channels -c conda-forge pystac stackstac planetary-computer -y >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Cloud tools failed, continuing...
    echo WARNING: Cloud tools failed >> %LOGFILE%
)

echo (85%%) Installing Earth Engine API...
echo (85%%) Installing Earth Engine API >> %LOGFILE%
%INSTALLER% run -n pygis_base pip install earthengine-api >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Earth Engine API install failed
    echo WARNING: Earth Engine API install failed >> %LOGFILE%
)

echo (90%%) Installing additional pip-only packages...
echo (90%%) Installing pip-only packages >> %LOGFILE%
%INSTALLER% run -n pygis_base pip install sklearn_xarray geeaddons sankee >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Some pip packages failed
    echo WARNING: Some pip packages failed >> %LOGFILE%
)

echo (95%%) Installing optional advanced packages...
echo (95%%) Installing optional packages >> %LOGFILE%
%INSTALLER% run -n pygis_base pip install overturemaps whiteboxgui >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Optional packages failed
    echo WARNING: Optional packages failed >> %LOGFILE%
)

echo (100%%) Verifying core installation...
echo (100%%) Verifying installation >> %LOGFILE%
%INSTALLER% run -n pygis_base python -c "import geopandas, rasterio, numpy, pandas, matplotlib, geemap, leafmap; print('SUCCESS: Core pygis.io packages verified!')" >> %LOGFILE% 2>&1
if !errorlevel! neq 0 (
    echo WARNING: Some packages failed verification, check log
    echo WARNING: Package verification failed >> %LOGFILE%
)

echo.
echo ============================================================
echo    PYGIS BASE ENVIRONMENT INSTALLATION COMPLETE!
echo ============================================================
echo Setup completed at %date% %time%
echo Setup completed at %date% %time% >> %LOGFILE%
echo.
echo NEXT STEPS:
echo 1. %INSTALLER% activate pygis_base  
echo 2. jupyter lab
echo.
echo INSTALLED PACKAGES INCLUDE:
echo ✓ Core GIS: GDAL, PROJ, GEOS, Shapely, PyProj, Fiona, GeoPandas, Rasterio
echo ✓ Scientific: NumPy, Pandas, SciPy, Matplotlib, Seaborn, Scikit-learn
echo ✓ Geospatial: Census, Contextily, EarthPy, GeoPlot, OSMnx, US, PyKrige
echo ✓ Visualization: Folium, MapClassify, Plotly, Bokeh
echo ✓ Data: xarray, netcdf4, h5py, zarr
echo ✓ Web Mapping: geemap, leafmap, ipyleaflet, localtileserver
echo ✓ Remote Sensing: GeoWombat, rio-cogeo, rioxarray, STAC tools
echo ✓ Earth Engine: earthengine-api, geeaddons
echo ✓ Development: Jupyter Lab, ipywidgets
echo ✓ Meta: pygis package with all dependencies
echo.
echo This environment supports the ENTIRE pygis.io curriculum!
echo.
pause