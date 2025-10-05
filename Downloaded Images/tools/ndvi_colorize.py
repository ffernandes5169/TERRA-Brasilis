import sys, os, glob
import numpy as np
import rasterio
import matplotlib; matplotlib.use('Agg')
import matplotlib.pyplot as plt
from PIL import Image
def colorize_ndvi(arr, nodata=None):
  a = arr.astype('float32')
  if nodata is not None: a = np.where(a==nodata, np.nan, a)
  a = a * 0.0001
  a[(a<-0.2)|(a>1.0)] = np.nan
  cmap = plt.get_cmap('YlGn'); norm = plt.Normalize(vmin=0.0, vmax=0.8)
  rgba = cmap(norm(a)); rgba[...,3] = np.where(np.isnan(a),0.0,1.0)
  rgb = (rgba[...,:3]*255).astype('uint8'); alpha = (rgba[...,3]*255).astype('uint8')
  return rgb, alpha
def save_png(rgb, alpha, out_path):
  im = Image.fromarray(rgb,'RGB'); im.putalpha(Image.fromarray(alpha,'L'))
  os.makedirs(os.path.dirname(out_path), exist_ok=True); im.save(out_path,'PNG')
def process_folder(root):
  tifs = sorted(glob.glob(os.path.join(root,'*.tif')))
  out_dir = os.path.join(root,'_png'); os.makedirs(out_dir, exist_ok=True)
  made=[]
  for tif in tifs:
    with rasterio.open(tif) as ds: arr = ds.read(1); nd = ds.nodatavals[0]
    rgb, a = colorize_ndvi(arr, nd)
    name = os.path.splitext(os.path.basename(tif))[0]+'.png'
    save_png(rgb, a, os.path.join(out_dir,name)); made.append(os.path.join(out_dir,name))
  print('PNG NDVI gerados:', len(made))
if __name__=='__main__':
  folder = sys.argv[1] if len(sys.argv)>1 else '.'
  process_folder(folder)

