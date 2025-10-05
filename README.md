Project TERRA Brasilis
A nature-based solution for land regeneration, powered by NASA's Terra satellite data.
🚀 Our Vision
What if we could turn millions of tons of agricultural waste into thriving new forests? That's the question that drove our project. TERRA Brasilis is our answer: a scalable, data-driven framework that does just that. We were inspired by a fascinating ecological experiment in Costa Rica, where discarded orange peels helped regenerate a barren landscape. Our project adapts this brilliant idea for Brazil, a global agricultural powerhouse.

We use data from NASA's Terra satellite to find degraded lands near agricultural centers and then monitor their recovery. It’s a powerful synergy between circular economy, community empowerment, and the health of our planet.

🎬 Project Demonstration (Full 2.5-min Video)
Our final product is a 2.5-minute animated story that explains our vision, the science behind it, and the transformative potential for communities and the environment.

[Link to your 2.5-minute video hosted on YouTube/Vimeo]

💡 The Challenge & Our Solution
We chose the "Animation Celebration of Terra Data!" challenge. Our goal was to create an animated product that tells a compelling Earth science story using data from the Terra satellite.

The Problem: Degraded lands are expanding globally. At the same time, agricultural industries produce massive amounts of organic waste from oranges, coffee, sugarcane, and açaí, creating a huge logistical and environmental challenge.

Our Solution: We propose a model where this waste is systematically used as a powerful composting agent to kick-start the natural recovery process in nearby degraded areas.

The NASA Innovation: While the idea of using organic waste isn't new, scaling it has always been the hard part. Our innovation is using NASA's Earth observation data to make this possible on a large scale. We can:

Identify & Prioritize: Use MODIS Land Cover and NDVI data to automatically map degraded areas that are logistically viable for intervention.

Monitor & Verify: Use a time-series analysis of MODIS NDVI and high-resolution ASTER imagery to track vegetation growth over time. This gives us scientific proof that the method is working.

Animate the Story: Use real satellite data to create compelling "before-and-after" animations, turning scientific metrics into a story of regeneration that everyone can understand.

🛠️ Our Technical Journey & Tools
Our hackathon weekend was a deep dive into data acquisition and processing.

Phase 1: The Automated Data Pipeline (VBA + Python)
Our initial, ambitious goal was to build a fully automated pipeline. We used VBA in Excel to orchestrate a Python script designed to connect to NASA's data services (like AppEEARS) and the Google Earth Engine (GEE) API. The goal was to process historical imagery from Landsat and Sentinel-2 and download annual true-color composites.

What we built: We successfully created a robust VBA framework that could authenticate with the necessary cloud services, manage a Python virtual environment, and execute parameterized scripts to fetch data.

The Hurdles: We hit some real-world technical walls. These included tricky API authentication flows, computational limits (Total request size), and inconsistent satellite data availability due to clouds or sensor issues, like the famous Landsat 7 SLC-off problem.

The Pivot: Although our code worked, the images we got for the historical period we needed (pre-2015) weren't consistent enough for a clean animation. So, we made a strategic pivot. We decided to focus on high-quality curated visuals from NASA to tell our story, while using the technical proof for more recent and reliable data from the Terra satellite.

You can find our original VBA and Python scripts in the /code directory. They tell the story of our ambitious attempt and the valuable lessons we learned along the way.

Phase 2: Visual Storytelling
NASA Worldview & Earth Observatory: These platforms became our go-to for sourcing beautiful "True Color" and NDVI imagery from the MODIS instrument on the Terra satellite.

Animation: We brought our story to life using [Mention your video software, e.g., Adobe After Effects, Blender, CapCut].

Character: Our narrator is a friendly "Orange Astronaut," an original concept created with the help of generative AI as a fun nod to our project's origin story.

🛰️ NASA Data & Resources
Our project was brought to life by the incredible open data from NASA's Terra satellite and other resources:

Terra/MODIS: We focused on the Vegetation Indices (NDVI - MOD13Q1) and Land Cover (MCD12Q1) products to analyze vegetation health and changes in land use.

Terra/ASTER: ASTER's high-resolution (15-90m) imagery was key for our detailed "before-and-after" case studies.

Landsat Program (NASA/USGS): We explored historical imagery from Landsat 5, 7, and 8, which was crucial for our initial time-series analysis.

NASA Worldview & Earth Observatory: These were essential for visual reference, data exploration, and sourcing curated images.

👥 The Team
Beatriz Zambeti

Clayton Roza

Fernando Fernandes

Lucas F. de Oliveira

💡 Inspiration & References
Our project was inspired by groundbreaking ecological restoration research. We stand on the shoulders of giants and want to acknowledge the work that sparked our idea:

The Orange Peel Experiment: The foundational case study from Costa Rica was led by Princeton ecologists Dr. Daniel Janzen and Dr. Winnie Hallwachs. Their work, demonstrating how 12,000 tons of orange peels could regenerate a tropical forest, is the cornerstone of our project.

Source: Princeton University News: "Orange you glad we didn't throw away those peels?"

The Coffee Pulp Follow-up: The successful application of the same principle using coffee pulp, which we also feature in our story.

Source: Ecological Solutions and Evidence: "Coffee pulp accelerates early tropical forest succession on old fields"

Visual Inspiration: Our storytelling was visually inspired by documentaries and reports on land regeneration.

Example: YouTube: "How 12,000 tonnes of orange peel revived a Costa Rican forest"
