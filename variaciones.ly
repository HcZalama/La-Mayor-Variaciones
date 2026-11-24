\version "2.24.0"
\language "espanol"
\header { tagline = ##f }
\paper {
  paper-width = 297\mm
  paper-height = 210\mm
  line-width = 287\mm
  left-margin = 5\mm
  top-margin = 5\mm
  bottom-margin = 5\mm
  ragged-right = ##f
  ragged-bottom = ##f
  print-page-number = ##f
  systems-per-page = #4        % 4 sistemas por página
  system-system-spacing.basic-distance = #10
  system-system-spacing.padding = #0.5
}
#(set-global-staff-size 20)   % tamaño de la partitura (antes 26, luego 21; más pequeño = más cabe)

\include "articulate.ly"
\include "music/herramientas.ly"
\include "music/voces.ly"

global = { \key la \major \time 3/4 }

%% --- El bajo obstinado (4 compases) -----------------------
celula = { la,2 re4 | mi2 fas4 | si,4 dos re | mi2. | } 

%%{ la,4~la,8.. r32 re8.. r32 | mi4~mi8.. r32 fas8.. r32 | si,8.. r32 dos8.. r32 re8.. r32 | mi2~mi8. r16 | }

celulamenor = { fas2 dos4  | la,4  re si,4  | mi4 la, si, | dos2.} 

celulamenora = { fas2 dos4  | la,4  re si,4  | mi4 la, si, | dos2 do8. r16 } 

 

%% \bar es del Score: vale para los dos pentagramas.
%% Los saltos de sistema NO van aquí: los pone "estructura" (abajo),
%% siempre cada 8 compases.
bajo = {
  \repeat unfold 6 { \celula \bar "||" \celula }


    %% cc. 49–52 · dúo en el pentagrama del bajo (arriba: el tema en S;
  %%            la otra voz del dúo está en voces.ly, voz X)
  la,4 dos si,     | % c.49
  sols, la, re    | % c.50
  sol fas si,  | % c.51
  dos8 re mi2  | % c.52


  %% cc. 53–56 · variación del bajo en semicorcheas (arriba: el tema en S)
  %% OJO: el bajo se escribe en alturas ABSOLUTAS (do = Do3, do' = Do4).
  la4 r16 dos re mi fas sols la si               | % c.53
  sols8 si, mi sols la16 sols la dos              | % c.54
  re8 si, la,16 la sols la fas mi fas si,         | % c.55
  sols8 la16 si la8 dos16 si, dos la mi sols      | % c.56



  \bar "||"

la2. la la la

la la la la

  %% cc. 65–68 · hueco para la nueva variación sobre el bajo de quintas
  la,4 r re4 | sol2 dos4 | fas2 si,4 | mi2. | \bar "||"


  la,4 r re4 | sol2 dos4 | fas2 si,4 | mi2. | \bar "||"

  %% cc. 69–72 · variación de quintas que ya existía (hacia Fa# menor)
  %% cc. 73–84 · Fa# menor: celulamenor + celulamenor (nueva) + celulamenora
  la,4 r re4 | sol2 dos4 | fas2 si,4 | dos4 sis, dos | 
\celulamenor \bar "||"
  \celulamenor \bar "||"   % cc. 77–80 · nueva variación sobre el bajo de Fa# menor

    \celulamenor \bar "||"   % cc. 77–80 · nueva variación sobre el bajo de Fa# menor

    
  \celulamenora



 si,2. dos2. re2. mi2~ <mi, mi>4 la,2.   % cc.85–89 (c.88: Mi2 añadido en el 3er tiempo)
  \bar "|."
}

%% --- Estructura: un salto de sistema cada 8 compases --------
%% Se calcula sola con la longitud del bajo (si el bajo crece, se adapta).
cadaOchoCompases =
#(define-music-function (m) (ly:music?)
   (let* ((compases (/ (ly:moment-main (ly:music-length m)) 3/4))
          (n (floor (/ (- compases 1) 8)))
          ;; si el último sistema se quedaría con 1 o 2 compases,
          ;; se une al anterior (mejor 9-10 compases que uno suelto)
          (saltos (if (<= (- compases (* 8 n)) 2) (- n 1) n)))
     (make-sequential-music
       (append-map (lambda (i) (list #{ s2.*8 #} #{ \break #}))
                   (iota saltos)))))

%% --- Pentagrama superior: 4 voces (S arriba siempre) ------
superior = \new Staff = "superior" \with { midiInstrument = "church organ" } <<
  \global
  \new Voice = "S" { \voiceOne   \relative do'' \keepWithTag #'S \material }
  \new Voice = "A" { \voiceTwo   \relative do'  \keepWithTag #'A \material }
  \new Voice = "X" { \voiceThree \relative do'  \keepWithTag #'X \material }
  \new Voice = "Y" { \voiceFour  \relative do   \keepWithTag #'Y \material }
  %% voz invisible tan larga como el bajo: el pentagrama de arriba
  %% no se corta aunque las voces acaben antes
  \new Voice { #(skip-of-length bajo) }
  \new Voice { \cadaOchoCompases \bajo }   % saltos de sistema
>>

%% --- Pentagrama inferior: el bajo -------------------------
inferior = \new Staff = "inferior" \with { midiInstrument = "church organ" } <<
  \global
  \clef bass
  \new Voice = "B" { \voiceTwo \bajo }
>>

%% ===========================================================
%%  ARTICULACIÓN EN EL AUDIO (solo MIDI/MP3; la partitura no cambia)
%%
%%  \articulate hace que cada nota suene un poco más corta que lo
%%  escrito, dejando una pequeña "coma" antes de la siguiente.
%%  Cuánto se acorta una nota normal:
%%     '(15 . 16)  casi legato        '(7 . 8)  natural (por defecto)
%%     '(3 . 4)    bastante separado
#(set! ac:normalFactor '(7 . 8))
%%
%%  Control nota a nota (se ve en la partitura Y se oye):
%%     dos4(  re mi)   ligadura      → esas notas suenan legato, sin coma
%%     dos4--          tenuto        → nota entera, sin coma
%%     dos4-_          portato       → separada (3/4 de su valor)
%%     dos4-.          staccato      → muy separada (1/2)
%%     dos4\turn       grupeto       → se toca el adorno de verdad
%% ===========================================================

musica = \new PianoStaff << \superior \inferior >>

%% 1. PARTITURA (PDF)
\score {
  \musica
  \layout {
    indent = 0
    \context {
      \Score
      proportionalNotationDuration = #(ly:make-moment 1/6)
      %% solo se salta de sistema donde hay \break (cada 8 compases)
      \override NonMusicalPaperColumn.line-break-permission = ##f
      \override SpacingSpanner.uniform-stretching = ##t
      %% (strict-note-spacing quitado: hacía que las semicorcheas
      %%  chocaran con las barras de compás en los compases densos)
    }
  }
}

%% 2. AUDIO (MIDI → MP3), con articulación
\score {
  \articulate \musica
  \midi { \tempo 4 = 70 }
}
