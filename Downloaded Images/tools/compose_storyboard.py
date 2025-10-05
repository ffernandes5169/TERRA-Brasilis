import sys, os, json, glob
from PIL import Image, ImageDraw, ImageFont
FRAME_SIZE = 1024  # >=800
def load_font(size):
  try: return ImageFont.truetype('arial.ttf', size)
  except: return ImageFont.load_default()
def ensure_size(img):
  return img.resize((FRAME_SIZE, FRAME_SIZE), Image.NEAREST)
def save_card(out_path, title, sub=''):
  W=H=FRAME_SIZE; img=Image.new('RGB',(W,H),(15,18,20)); d=ImageDraw.Draw(img)
  f1=load_font(72); f2=load_font(32)
  w1,h1=d.textsize(title,font=f1); d.text(((W-w1)//2, H//3), title, fill=(230,255,230), font=f1)
  if sub: w2,h2=d.textsize(sub,font=f2); d.text(((W-w2)//2, H//3+h1+20), sub, fill=(180,200,180), font=f2)
  os.makedirs(os.path.dirname(out_path), exist_ok=True); img.save(out_path,'PNG')
def panel_from_dir(ndvi_dir, out_path):
  pngs = sorted(glob.glob(os.path.join(ndvi_dir,'*.png')))
  if len(pngs)<2: return
  left=Image.open(pngs[0]).convert('RGBA'); right=Image.open(pngs[-1]).convert('RGBA')
  left=ensure_size(left); right=ensure_size(right)
  H=max(left.height,right.height); W=left.width+right.width
  canvas=Image.new('RGBA',(W,H),(255,255,255,255)); canvas.paste(left,(0,0),left); canvas.paste(right,(left.width,0),right)
  os.makedirs(os.path.dirname(out_path), exist_ok=True); canvas.save(out_path,'PNG')
def overlay_ndvi_on_bg(ndvi_dir, bg_path, out_path):
  pngs = sorted(glob.glob(os.path.join(ndvi_dir,'*.png')))
  if not pngs: return
  nd = Image.open(pngs[-1]).convert('RGBA')
  bg = Image.open(bg_path).convert('RGBA')
  bg = ensure_size(bg)
  nd = nd.resize(bg.size, Image.NEAREST)
  comp = Image.alpha_composite(bg, nd)
  os.makedirs(os.path.dirname(out_path), exist_ok=True); comp.save(out_path,'PNG')
def main(out_dir, manifest_path):
  with open(manifest_path,'r',encoding='utf-8') as f: m=json.load(f)
  for op in m.get('ops',[]):
    ts = op.get('ts','0000'); kind = op.get('op')
    if kind=='title':
      save_card(os.path.join(out_dir,f'{ts}_title.png'), op.get('text',''), op.get('sub',''))
    elif kind=='card':
      save_card(os.path.join(out_dir,f'{ts}_card.png'), op.get('text',''), op.get('sub',''))
    elif kind=='panel':
      panel_from_dir(op['src'], os.path.join(out_dir,f'{ts}_panel_before_after.png'))
    elif kind=='overlay':
      overlay_ndvi_on_bg(op['src'], op['bg'], os.path.join(out_dir,f'{ts}_overlay_ndvi.png'))
    elif kind=='label':
      save_card(os.path.join(out_dir,f'{ts}_label.png'), op.get('text',''), '')
  print('Storyboard frames prontos em', out_dir)
if __name__=='__main__':
  out_dir=sys.argv[1]; manifest=sys.argv[2]; main(out_dir,manifest)

