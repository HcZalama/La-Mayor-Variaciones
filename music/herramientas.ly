%% ===========================================================
%%  herramientas.ly — maquinaria. No hace falta tocarlo.
%% ===========================================================

%% Compás(es) vacío(s) para una voz que calla en un bloque.
vacio = s2.*4

%% Aviso si una voz no mide exactamente 4 compases de 3/4 (= 3 redondas).
#(define (comprobar-bloque voz musica loc)
   (let ((len (ly:moment-main (ly:music-length musica))))
     (if (not (= len 3))
         (ly:input-warning loc
           "voz ~a: ~a compases en vez de 4" voz (/ (* 4 len) 3)))))

%% \bloque { S } { A } { X } { Y }
%% Reparte las cuatro voces de un bloque en sus "etiquetas".
%% Luego cada voz se extrae con \keepWithTag.
bloque =
#(define-music-function (s a x y) (ly:music? ly:music? ly:music? ly:music?)
   (let ((loc (*location*)))
     (comprobar-bloque "S" s loc)
     (comprobar-bloque "A" a loc)
     (comprobar-bloque "X" x loc)
     (comprobar-bloque "Y" y loc)
     #{ \tag #'S #s \tag #'A #a \tag #'X #x \tag #'Y #y #}))

bloqueVacio = \bloque \vacio \vacio \vacio \vacio

%% Cambios de pentagrama (se escriben DENTRO de la voz, donde quieras).
%% Abajo: plicas hacia arriba, para no chocar con el bajo (plicas abajo).
aInf = { \change Staff = "inferior" \voiceOne }
aSup = { \change Staff = "superior" \voiceTwo }
xInf = { \change Staff = "inferior" \voiceOne }
xSup = { \change Staff = "superior" \voiceThree }
yInf = { \change Staff = "inferior" \voiceOne }
ySup = { \change Staff = "superior" \voiceFour }
