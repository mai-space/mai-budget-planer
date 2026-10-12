"""Erzeugt App-Icon (Android, Web) und In-App-Logo aus einer Vorlage.

    pip install cairosvg && python3 tool/generate_icons.py

Motiv: Ring in den drei Töpfen der Budgetregel (Grundbedarf · Wünsche ·
Sparen) um eine Münze.
"""

from pathlib import Path

import cairosvg
from PIL import Image

ROOT = Path(__file__).resolve().parent.parent
RES = ROOT / "android/app/src/main/res"

SEED = "#2F5D7C"
ACCENT = "#4F95BF"
WANTS = "#F2B84B"
SAVINGS = "#5FD3A0"

# 108×108 = Android-Adaptive-Icon-Raster; Motiv bleibt in der 66er-Schutzzone
# (Ring-Außenradius 21,5 um die Mitte → 43 Einheiten).
R = 17
CIRC = 2 * 3.14159265 * R
GAP = 3.2


def arc(share, start, color):
    length = CIRC * share - GAP
    return (
        f'<circle cx="54" cy="54" r="{R}" fill="none" stroke="{color}" '
        f'stroke-width="9" stroke-dasharray="{length:.2f} {CIRC - length:.2f}" '
        f'stroke-dashoffset="{-CIRC * start:.2f}" transform="rotate(-90 54 54)"/>'
    )


def motif(needs="#fff", wants=WANTS, savings=SAVINGS, coin="#fff"):
    return (
        arc(0.5, 0, needs)
        + arc(0.3, 0.5, wants)
        + arc(0.2, 0.8, savings)
        + f'<circle cx="54" cy="54" r="8" fill="{coin}"/>'
        + f'<rect x="52.6" y="49.5" width="2.8" height="9" rx="1.4" fill="{SEED}"/>'
    )


BACKGROUND = f"""
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="{ACCENT}"/>
      <stop offset="1" stop-color="{SEED}"/>
    </linearGradient>
  </defs>
"""


def svg(body, view="0 0 108 108"):
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="{view}">{body}</svg>'


FOREGROUND = svg(motif())
# Themed Icons (Android 13+) nutzen nur Alpha: Ring einfarbig, Münzenmitte
# ausgespart.
MONOCHROME = svg(
    motif("#fff", "#fff", "#fff", "#fff").replace(
        f'<rect x="52.6" y="49.5" width="2.8" height="9" rx="1.4" fill="{SEED}"/>',
        "",
    )
)
ROUNDED = svg(
    BACKGROUND
    + '<rect x="14" y="14" width="80" height="80" rx="20" fill="url(#bg)"/>'
    + motif(),
    view="14 14 80 80",
)
FULL_BLEED = svg(
    BACKGROUND + '<rect width="108" height="108" fill="url(#bg)"/>' + motif()
)


def png(source, path, size):
    path.parent.mkdir(parents=True, exist_ok=True)
    cairosvg.svg2png(
        bytestring=source.encode(),
        write_to=str(path),
        output_width=size,
        output_height=size,
    )


def main():
    (ROOT / "assets/branding").mkdir(parents=True, exist_ok=True)
    (ROOT / "assets/branding/logo.svg").write_text(ROUNDED + "\n")

    densities = {"mdpi": 1, "hdpi": 1.5, "xhdpi": 2, "xxhdpi": 3, "xxxhdpi": 4}
    for name, factor in densities.items():
        folder = RES / f"mipmap-{name}"
        png(ROUNDED, folder / "ic_launcher.png", round(48 * factor))
        png(FOREGROUND, folder / "ic_launcher_foreground.png", round(108 * factor))
        png(MONOCHROME, folder / "ic_launcher_monochrome.png", round(108 * factor))

    (RES / "mipmap-anydpi-v26").mkdir(exist_ok=True)
    (RES / "mipmap-anydpi-v26/ic_launcher.xml").write_text(
        """<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@mipmap/ic_launcher_foreground" />
    <monochrome android:drawable="@mipmap/ic_launcher_monochrome" />
</adaptive-icon>
"""
    )
    (RES / "drawable/ic_launcher_background.xml").write_text(
        f"""<?xml version="1.0" encoding="utf-8"?>
<!-- Erzeugt von tool/generate_icons.py (Verlauf Akzent → Markenfarbe). -->
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <gradient
        android:angle="315"
        android:endColor="{SEED}"
        android:startColor="{ACCENT}" />
</shape>
"""
    )

    for scale, suffix in [(1, ""), (2, "2.0x/"), (3, "3.0x/")]:
        png(ROUNDED, ROOT / f"assets/branding/{suffix}logo.png", 96 * scale)

    web = ROOT / "web"
    png(ROUNDED, web / "favicon.png", 32)
    png(ROUNDED, web / "icons/Icon-192.png", 192)
    png(ROUNDED, web / "icons/Icon-512.png", 512)
    png(FULL_BLEED, web / "icons/Icon-maskable-192.png", 192)
    png(FULL_BLEED, web / "icons/Icon-maskable-512.png", 512)

    # Play Store: 512 × 512, vollflächig (Google rundet die Ecken selbst ab).
    # Gefordert ist 32-Bit-PNG mit Alphakanal.
    store_icon = ROOT / "store/android/icon-512.png"
    png(FULL_BLEED, store_icon, 512)
    Image.open(store_icon).convert("RGBA").save(store_icon)


if __name__ == "__main__":
    main()
