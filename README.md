# 🌎 Project TERRA Brasilis
*A nature-based solution for land regeneration, powered by NASA's Terra satellite data.*

---

![Animated preview of our story — "From Waste to Forest"](./media/terra_brasilis_preview.gif)
> 🎞️ *Animated preview from our final submission video — inspired by the real orange peel experiment in Costa Rica.*

---

## 🚀 Our Vision
What if we could turn millions of tons of agricultural waste into thriving new forests?  
That’s the question that drove our project. **TERRA Brasilis** is our answer: a scalable, data-driven framework that does just that.  

We were inspired by a fascinating ecological experiment in Costa Rica, where discarded orange peels helped regenerate a barren landscape. Our project adapts this brilliant idea for **Brazil**, a global agricultural powerhouse.

We use data from **NASA's Terra satellite** to find degraded lands near agricultural centers and then monitor their recovery.  
It’s a powerful synergy between circular economy, community empowerment, and the health of our planet.

---

## 🎬 Project Demonstration — *"From Waste to Forest. From Forest to Future."*

Our submission for the **NASA Space Apps Challenge 2025** includes two complementary videos that tell our story from different perspectives:

### 🎞️ Official Short Pitch (30 seconds)
The quick introduction used for NASA’s submission form — a dynamic and engaging teaser of our project.  
👉 [Watch the 30-second presentation video (YouTube)](https://youtu.be/SEU_LINK_CURTO_AQUI)

---

### 🌍 Full Animated Story (2.5 minutes)
Our main deliverable: a **2.5-minute animated short film** that tells the inspiring story of how agricultural waste — like orange peels and coffee pulp — can help regenerate degraded lands in Brazil, with NASA’s Terra satellite data guiding the way.

🎥 **Watch the full animation here:**  
👉 [🔗 *From Waste to Forest — Official Project Video (YouTube)*](https://youtu.be/SEU_LINK_COMPLETO_AQUI)

---

### 📖 About the Video
The animation showcases:
- The **real case** of 12,000 tons of orange peels restoring a forest in Costa Rica 🌳  
- How this idea can **scale to Brazil** — one of the world’s largest agricultural producers ☕🍊  
- How NASA’s **Terra/MODIS** data (NDVI time-series) helps visualize the “greening” of degraded lands 🌍  
- And finally, how communities and technology can unite for a **new cycle of life from waste** ♻️  

The story is narrated by our original character — the **Orange Astronaut** 🧑‍🚀🍊 — a symbol of curiosity, science, and hope.

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
- **Animation:** We brought our story to life using *[mention your video software, e.g., Adobe After Effects, Blender, CapCut]*.  
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
- 10 Municípios Brasileiros Maiores Produtores de Laranja: https://agronegocioaz.com.br/10-municipios-brasileiros-maiores-produtores-de-laranja/  
- INPE Catálogo de Imagens: https://www.dgi.inpe.br/catalogo/explore  
- Worldview - Explore Your Dynamic Planet: https://worldview.earthdata.nasa.gov  
- Vegetation Index: https://neo.gsfc.nasa.gov/view.php?datasetId=MOD_NDVI_M&year=2017  
- Earth Observatory: https://earthobservatory.nasa.gov  
