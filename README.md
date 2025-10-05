# 🌎 Project TERRA Brasilis
*A nature-based solution for land regeneration, powered by NASA's Terra satellite data.*

---

## 🚀 Our Vision
What if we could turn millions of tons of agricultural waste into thriving new forests?  
That’s the question that drove our project. **TERRA Brasilis** is our answer: a scalable, data-driven framework that does just that.  

We were inspired by a fascinating ecological experiment in Costa Rica, where discarded orange peels helped regenerate a barren landscape. Our project adapts this brilliant idea for **Brazil**, a global agricultural powerhouse.

We use data from **NASA's Terra satellite** to find degraded lands near agricultural centers and then monitor their recovery.  
It’s a powerful synergy between circular economy, community empowerment, and the health of our planet.

---

## 🎬 Project Demonstration (Full 2.5-min Video)
Our final product is a 2.5-minute animated story that explains our vision, the science behind it, and the transformative potential for communities and the environment.

👉 [Link to your 2.5-minute video hosted on YouTube/Vimeo]

---

## 💡 The Challenge & Our Solution
We chose the **“Animation Celebration of Terra Data!”** challenge.  
Our goal was to create an animated product that tells a compelling Earth science story using data from the Terra satellite.

### The Problem
Degraded lands are expanding globally.  
At the same time, agricultural industries produce massive amounts of organic waste — from oranges, coffee, sugarcane, and açaí — creating a huge logistical and environmental challenge.

### Our Solution
We propose a model where this waste is systematically used as a **powerful composting agent** to kick-start the natural recovery process in nearby degraded areas.

### The NASA Innovation
While the idea of using organic waste isn’t new, scaling it has always been the hard part.  
Our innovation is using **NASA's Earth observation data** to make this possible on a large scale. We can:

- **Identify & Prioritize:** Use MODIS Land Cover and NDVI data to automatically map degraded areas that are logistically viable for intervention.  
- **Monitor & Verify:** Use a time-series analysis of MODIS NDVI and high-resolution ASTER imagery to track vegetation growth over time. This gives us scientific proof that the method is working.  
- **Animate the Story:** Use real satellite data to create compelling “before-and-after” animations, turning scientific metrics into a story of regeneration that everyone can understand.

---

## 🛠️ Our Technical Journey & Tools

### Phase 1: The Automated Data Pipeline (VBA + Python)
Our initial, ambitious goal was to build a fully automated pipeline.  
We used **VBA in Excel** to orchestrate a **Python script** designed to connect to NASA's data services (like AppEEARS) and the **Google Earth Engine (GEE)** API.  
The goal was to process historical imagery from Landsat and Sentinel-2 and download annual true-color composites.

**What we built:**  
A robust VBA framework that could authenticate with cloud services, manage a Python virtual environment, and execute parameterized scripts to fetch data.

**The Hurdles:**  
We hit some real-world technical walls, including tricky API authentication flows, computational limits (Total request size), and inconsistent satellite data availability due to clouds or sensor issues like the famous **Landsat 7 SLC-off problem**.

**The Pivot:**  
Although our code worked, the images we got for the historical period we needed (pre-2015) weren’t consistent enough for a clean animation.  
So, we made a **strategic pivot** — focusing on high-quality curated visuals from NASA to tell our story, while using technical proof from the Terra satellite for recent data.

📁 You can find our original VBA and Python scripts in the `/code` directory.  
They tell the story of our ambitious attempt and the valuable lessons we learned along the way.

---

### Phase 2: Visual Storytelling
- **NASA Worldview & Earth Observatory:** Our go-to platforms for sourcing beautiful “True Color” and NDVI imagery from the MODIS instrument on the Terra satellite.  
- **Animation:** We brought our story to life using *[Mention your video software, e.g., Adobe After Effects, Blender, CapCut]*.  
- **Character:** Our narrator is a friendly **“Orange Astronaut”**, an original concept created with the help of generative AI — a fun nod to our project’s origin story.

---

## 🛰️ NASA Data & Resources
Our project was brought to life by the incredible open data from NASA’s Terra satellite and other resources:

- **Terra/MODIS:** Vegetation Indices (NDVI - MOD13Q1) and Land Cover (MCD12Q1) products to analyze vegetation health and changes in land use.  
- **Terra/ASTER:** High-resolution (15–90m) imagery for detailed “before-and-after” case studies.  
- **Landsat Program (NASA/USGS):** Historical imagery from Landsat 5, 7, and 8, crucial for our initial time-series analysis.  
- **NASA Worldview & Earth Observatory:** Essential for visual reference, data exploration, and sourcing curated images.

---

## 👥 The Team
- **Beatriz Zambeti**  
- **Clayton Roza**  
- **Fernando Fernandes**  
- **Lucas Borges da Silva**

---

## 💡 Inspiration

### The Orange Peel Experiment
The foundational case study from Costa Rica, led by Princeton ecologists **Dr. Daniel Janzen** and **Dr. Winnie Hallwachs**, demonstrated how **12,000 tons of orange peels** could regenerate a tropical forest — the cornerstone of our project.

📚 Source: *Princeton University News* — “Orange you glad we didn’t throw away those peels?”

---

### The Coffee Pulp Follow-up
A successful application of the same principle using **coffee pulp**, which we also feature in our story.

📚 Source: *Ecological Solutions and Evidence* — “Coffee pulp accelerates early tropical forest succession on old fields”

---

### Visual Inspiration
Our storytelling was visually inspired by documentaries and reports on land regeneration.  
Example: *YouTube* — “How 12,000 tonnes of orange peel revived a Costa Rican forest”

---

## 🔗 References
- Estratégia Nacional de Bioeconomia: https://www.gov.br/mma/pt-br/composicao/sbc/dpeb/estrategia-nacional-de-bioeconomia
- 10 Municípios Brasileiros Maiores Produtores de Larajna: https://agronegocioaz.com.br/10-municipios-brasileiros-maiores-produtores-de-laranja/
- INPE Catálogo de Imagens: https://www.dgi.inpe.br/catalogo/explore
- Worldview - Explore Your Dynamic Planet: https://worldview.earthdata.nasa.gov/?v=-151.47131199875852,-205.57590442693254,39.49743800124148,161.4929824343813&z=4&ics=true&ici=5&icd=30&l=Reference_Labels_15m,Reference_Features_15m,Coastlines_15m,VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_380(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_PyroCumuloNimbus_380(hidden),IMERG_Precipitation_Rate_30min(hidden),IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA20_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA21_CorrectedReflectance_BandsM11-I2-I1(hidden),MODIS_Aqua_CorrectedReflectance_Bands721(hidden),MODIS_Terra_CorrectedReflectance_Bands721(hidden),VIIRS_NOAA21_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor(hidden),BlueMarble_NextGeneration,VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden)&lg=true&l1=Reference_Labels_15m,Reference_Features_15m,Coastlines_15m,VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_380(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_PyroCumuloNimbus_380(hidden),IMERG_Precipitation_Rate_30min(hidden),IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance,VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA20_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA21_CorrectedReflectance_BandsM11-I2-I1(hidden),MODIS_Aqua_CorrectedReflectance_Bands721(hidden),MODIS_Terra_CorrectedReflectance_Bands721(hidden),VIIRS_NOAA21_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor,BlueMarble_NextGeneration(hidden),VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden)&lg1=true&ca=true&cv=64&s=-77.3712,25.0408&t=2025-10-02-T19%3A42%3A00Z&t1=2025-09-25-T19%3A42%3A00Z
- World View - Explore Your Dynamic Planet: https://worldview.earthdata.nasa.gov/?v=-90.79427729107589,-16.786006881135286,-43.052089791075886,6.417118118864714&z=5&i=2&as=2020-10-02-T00%3A00%3A00Z&ae=2024-10-02-T00%3A00%3A00Z&l=Reference_Labels_15m(hidden),Reference_Features_15m,Coastlines_15m,VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_380(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_PyroCumuloNimbus_380(hidden),IMERG_Precipitation_Rate_30min(hidden),IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_CorrectedReflectance_BandsM3-I3-M11,VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA20_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA21_CorrectedReflectance_BandsM11-I2-I1(hidden),MODIS_Aqua_CorrectedReflectance_Bands721(hidden),MODIS_Terra_CorrectedReflectance_Bands721(hidden),VIIRS_NOAA21_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor(hidden),BlueMarble_NextGeneration(hidden),VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden)&lg=true&ab=on&s=-77.3712,25.0408
- Vegetation Index: https://neo.gsfc.nasa.gov/view.php?datasetId=MOD_NDVI_M&year=2017
- Worldview - Explore Your Dynamic Planet: https://worldview.earthdata.nasa.gov/?v=-106.73840246166597,-32.67950852255124,-11.25402746166597,13.726741477448762&z=5&i=2&ics=true&ici=5&icd=30&l=Reference_Labels_15m(hidden),Reference_Features_15m,Coastlines_15m,MODIS_Terra_L3_NDVI_Monthly,VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus
- Worldview - Explore Your Dynamic Planet: https://worldview.earthdata.nasa.gov/?v=-58.538688281249996,-24.6253996368838,-46.603141406249996,-16.12669255061619&z=4&ics=true&ici=5&icd=6&l=Reference_Labels_15m(hidden),Reference_Features_15m,Coastlines_15m,GOES-East_ABI_GeoColor,VIIRS_SNPP_EVI_8Day(hidden),TEMPO_L2_Formaldehyde_Vertical_Column_Granule(count=1),VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_380(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_PyroCumuloNimbus_380(hidden),IMERG_Precipitation_Rate_30min(hidden),IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA20_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA21_CorrectedReflectance_BandsM11-I2-I1(hidden),MODIS_Aqua_CorrectedReflectance_Bands721(hidden),MODIS_Terra_CorrectedReflectance_Bands721(hidden),VIIRS_NOAA21_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor(hidden),BlueMarble_NextGeneration(hidden),VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden)&lg=true&l1=Reference_Labels_15m,Reference_Features_15m,Coastlines_15m,VIIRS_SNPP_Thermal_Anomalies_375m_Night(hidden),VIIRS_SNPP_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA20_Thermal_Anomalies_375m_Day(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Night(hidden),VIIRS_NOAA21_Thermal_Anomalies_375m_Day(hidden),MODIS_Aqua_Thermal_Anomalies_Night(hidden),MODIS_Aqua_Thermal_Anomalies_Day(hidden),MODIS_Terra_Thermal_Anomalies_Night(hidden),MODIS_Terra_Thermal_Anomalies_Day(hidden),OMPS_Aerosol_Index(hidden),OMPS_Aerosol_Index_PyroCumuloNimbus(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_380(hidden),OMPS_NOAA20_NadirMapper_AerosolIndex_PyroCumuloNimbus_380(hidden),IMERG_Precipitation_Rate_30min(hidden),IMERG_Precipitation_Rate(hidden),VIIRS_NOAA20_DayNightBand_At_Sensor_Radiance,VIIRS_NOAA20_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_DayNightBand_At_Sensor_Radiance(hidden),VIIRS_SNPP_DayNightBand_AtSensor_M15(hidden),VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA20_CorrectedReflectance_BandsM11-I2-I1(hidden),VIIRS_NOAA21_CorrectedReflectance_BandsM11-I2-I1(hidden),MODIS_Aqua_CorrectedReflectance_Bands721(hidden),MODIS_Terra_CorrectedReflectance_Bands721(hidden),VIIRS_NOAA21_CorrectedReflectance_TrueColor(hidden),MODIS_Aqua_CorrectedReflectance_TrueColor(hidden),MODIS_Terra_CorrectedReflectance_TrueColor,BlueMarble_NextGeneration(hidden),VIIRS_NOAA20_CorrectedReflectance_TrueColor(hidden),VIIRS_SNPP_CorrectedReflectance_TrueColor(hidden)&lg1=true&ca=true&cv=98&s=-77.3712,25.0408%2B-48.7257,-23.3863%2B-48.7257,-23.3863&t=2025-07-12-T17%3A42%3A59Z&t1=2025-09-25-T19%3A42%3A00Z
- https://earthobservatory.nasa.gov/images/153978/spotting-disruptions-to-earths-vegetation
- https://earthobservatory.nasa.gov/global-maps/MOD_NDVI_M
- https://earthobservatory.nasa.gov/images/153175/fires-rage-along-brazils-deforestation-frontier
