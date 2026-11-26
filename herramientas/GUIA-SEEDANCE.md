# Guía de producción · versión realista

Objetivo: sustituir los fotogramas provisionales de la maqueta por un **plano secuencia fotorrealista** del recorrido. La web ya está preparada: solo cambian las imágenes de `frames/`.

El recorrido tiene **15 paradas** (fotogramas clave) y **14 tramos** (clips de vídeo) entre ellas:

| # | Parada | Archivo guía |
|---|---|---|
| 00 | El lago | `keys/00_lago.jpg` |
| 01 | La colina | `keys/01_colina.jpg` |
| 02 | El pórtico | `keys/02_portico.jpg` |
| 03 | La puerta norte | `keys/03_puerta.jpg` |
| 04 | Dentro, bajo el tambor | `keys/04_entrada.jpg` |
| 05–12 | Las ocho vidrieras (I–VIII) | `keys/05_beat1.jpg` … `keys/12_beat8.jpg` |
| 13 | El altar | `keys/13_altar.jpg` |
| 14 | La cúpula | `keys/14_cupula.jpg` |

En `herramientas/guias/` tienes además **14 vídeos guía** (`01.mp4` … `14.mp4`) renderizados desde la maqueta: es el movimiento de cámara exacto de cada tramo, para usarlo como referencia de movimiento («modelo blanco»).

---

## Paso 0 · Reúne fotos reales de referencia

Necesitas 6–10 fotos tuyas o con permiso: la basílica desde el lago, el pórtico con sus arcos, la puerta norte, el interior hacia el tambor, una vidriera, el altar y la cúpula dorada. Guárdalas en `herramientas/referencias/`.

Sin fotos de referencia, la IA inventará detalles del edificio. Con ellas, respeta el basalto negro, los arcos blancos y la cúpula verde.

## Paso 1 · Los 15 fotogramas clave realistas (imagen)

Herramienta: el generador de imágenes de Jimeng/Dreamina (Seedream) u otro que admita **imagen de estructura + imágenes de referencia**.

Para cada parada:
1. Sube el fotograma guía (`keys/NN_….jpg`) como **referencia de composición/estructura**.
2. Sube 2–3 fotos reales del mismo lugar como **referencia de estilo/material**.
3. Pega el **bloque de estilo común** y después la línea de esa parada.
4. Formato 16:9, máxima resolución. Guarda el resultado como `herramientas/claves/NN.jpg`.

**Bloque de estilo común (pegar siempre):**

```
Photorealistic architectural photograph of the Church of the Beatitudes (Antonio Barluzzi, 1938) on the Mount of Beatitudes above the Sea of Galilee. Keep the exact composition, camera position and geometry of the structure reference image. Octagonal church: rough grey-black basalt masonry, white Nazareth limestone arches and cornices, travertine columns in the surrounding arched portico, green weathered copper dome. Late afternoon light, warm low sun from the west, soft long shadows, clear sky with a light haze over the lake. Shot on a full-frame camera, 24 mm lens, natural colours, fine detail, no people, no text overlays, no watermark.
```

**Línea de cada parada:**

- **00 El lago** — `Wide aerial view from above the lake looking north-west at the hill; the church crowns the hilltop among olive trees, cypresses and palms; the blue lake in the foreground.`
- **01 La colina** — `Closer aerial view descending towards the church from the south-east; gardens, olive trees and the arched portico all around the octagon.`
- **02 El pórtico** — `Eye-level view at the north-west corner: the arched portico with travertine columns, black basalt walls and the copper dome above.`
- **03 La puerta norte** — `Standing in front of the north entrance building, looking straight at the tall central arch and the wooden door; portico arches on both sides.`
- **04 Dentro** — `Interior, standing just inside the north door, looking up and towards the centre: eight white arches around the central space, the high drum with eight stained-glass windows, golden mosaic dome above, warm light entering through the windows.`
- **05–12 Vidriera I–VIII** — `Interior, looking up at one stained-glass window in the drum below the golden dome; the window glows with coloured light; white walls, soft warm daylight; the window is the centre of attention.` *(La misma línea para las ocho; cambia solo el fotograma guía. El texto latino de la vidriera saldrá ilegible: no importa, la web lo escribe encima).*
- **13 El altar** — `Interior, looking down at the central altar of alabaster and onyx under a slender arch, the bronze tabernacle, and the mosaic floor with a river of grace flowing from the altar into seven branches.`
- **14 La cúpula** — `Interior, looking straight up into the golden mosaic dome, the octagonal drum with its eight glowing stained-glass windows around it, light pouring down.`

**Revisa cada imagen antes de seguir:** ocho lados, basalto oscuro con arcos claros, cúpula verde por fuera y dorada por dentro, pórtico alrededor. Repite las que fallen; esta parte decide el realismo.

## Paso 2 · Los 14 clips con Seedance 2.5 (vídeo)

Modo: **primer y último fotograma** (first/last frame).
- Primer fotograma = `claves/NN.jpg`, último = `claves/NN+1.jpg`.
- Si tu plataforma lo permite, añade `guias/NN.mp4` como **vídeo de referencia de movimiento de cámara**.
- Formato 16:9 · 1080p (o borrador y luego 4K) · duración **6 s** (8 s en los tramos 01 y 04) · audio desactivado · misma semilla en todos.

Pega siempre al final: `Single continuous camera move, no cuts, no people, stable architecture, consistent lighting, smooth and slow cinematic motion.`

| Clip | De → a | Indicación |
|---|---|---|
| 01 | 00 → 01 | `Slow aerial descent from above the lake towards the church on the hilltop.` |
| 02 | 01 → 02 | `The camera keeps descending and glides around the portico to eye level at the north-west corner.` |
| 03 | 02 → 03 | `Steady walk along the portico to face the north entrance.` |
| 04 | 03 → 04 | `The camera walks through the open door into the church and tilts up towards the drum and the dome.` |
| 05 | 04 → 05 | `Gentle move to the first stained-glass window, which begins to glow.` |
| 06–12 | 05 → 06 … 11 → 12 | `Slow circular glide around the octagon, from one stained-glass window to the next, the new window lighting up.` |
| 13 | 12 → 13 | `The camera lowers its gaze from the windows down to the altar and the mosaic river at its foot.` |
| 14 | 13 → 14 | `The camera rises from the altar and looks straight up into the golden dome.` |

Guarda los clips como `herramientas/clips/01.mp4` … `14.mp4`.

**Consejos de coherencia**
- Los tramos 06–12 son el mismo movimiento: genera uno bueno y repite la misma indicación y semilla en los demás.
- Si un clip sale con un salto al final, regenera con «ease out at the end, stop exactly on the last frame».
- Compara siempre el último fotograma del clip con el primero del siguiente.

## Paso 3 · Pasarlo a la web

Doble clic en `herramientas/convertir-video.bat`. Crea los fotogramas en `frames/hi` y `frames/lo`, actualiza `frames/manifest.js` y la web pasa sola a la versión realista (desaparece el aviso de «vista provisional» y cambia la nota de la página).

## Coste orientativo

Unos 2 minutos de vídeo final (14 clips de 6–8 s). Con repeticiones, calcula generar 3–4 veces esa duración: entre 50 y 250 USD según calidad y plataforma (tarifas de agosto de 2026, de 0,11 a 1,10 USD por segundo). Las 15 imágenes clave cuestan muy poco en comparación.
