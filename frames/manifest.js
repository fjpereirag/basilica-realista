/* Secuencia de fotogramas del recorrido.
   Para cambiar a la versión realista: sustituye las carpetas lo/ y hi/ por las
   que genera convertir-video.bat y actualiza "count" y "keys".
   keys = número de fotograma de cada parada (15 paradas, en orden). */
window.FRAMES = {
  version: "maqueta",            // "maqueta" (provisional) o "realista"
  count: 281,
  pad: 4,
  ext: "webp",
  keys: [0,20,40,60,80,100,120,140,160,180,200,220,240,260,280]
};
