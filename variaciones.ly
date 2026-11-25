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
celula = { la,2 re4 | mi2 fas4 | si,4 dos4 re4 | mi2. | } 

%%{ la,4~la,8.. r32 re8.. r32 | mi4~mi8.. r32 fas8.. r32 | si,8.. r32 dos8.. r32 re8.. r32 | mi2~mi8. r16 | }

celulamenor = { fas2 dos4  | la,4  re4 si,4  | mi4 la,4 si,4 | dos2.} 

celulamenora = { fas2 dos4  | la,4  re4 si,4  | mi4 la,4 si,4 | dos2 do8. r16 } 

 

%% \bar es del Score: vale para los dos pentagramas.
%% Los saltos de sistema NO van aquí: los pone "estructura" (abajo),
%% siempre cada 8 compases.
bajo = {
  \repeat unfold 6 { \celula \bar "||" \celula }

  %% cc. 49–52 · dúo en el pentagrama del bajo (arriba: el tema en S;
  %%            la otra voz del dúo está en voces.ly, voz X)
  la,4 dos4 si,4                                          | % c.49
  sols,4 la,4 re4                                         | % c.50
  sol4 fas4 si,4                                          | % c.51
  dos8 re8 mi2                                            | % c.52

  %% cc. 53–56 · variación del bajo en semicorcheas (arriba: el tema en S)
  %% OJO: el bajo se escribe en alturas ABSOLUTAS (do = Do3, do' = Do4).
  la4 r16 dos16 re16 mi16 fas16 sols16 la16 si16          | % c.53
  sols8 si,8 mi8 sols8 la16 sols16 la16 dos16             | % c.54
  re8 si,8 la,16 la16 sols16 la16 fas16 mi16 fas16 si,16  | % c.55
  sols8 la16 si16 la8 dos16 si,16 dos16 la16 mi16 sols16  | % c.56

  \bar "||"

  %% cc. 57–60
  la,2~ la,8 fas8                                         | % c.57
  dos4. si,16 dos16 re4                                   | % c.58
  sol,4 la,8 las,8 si,4                                   | % c.59
  dos4 re4 mi4 \bar "||"                                  | % c.60

  %% cc. 61–64 · bajo en tresillos
  \tuplet 3/2 4 { la8 si8 la8 sols8 fas8 mi8 fas8 mi8 re8 | % c.61
  dos8 mi8 la8 si,8 mi8 sols8 las,4 dos8                  | % c.62
  re8 dos8 si,8 la,4. fas,8 mi,8 fas,8                    | % c.63
  sols,8 la,8 si,8 mi8 res8 mi8 mi,4. } \bar "||"         | % c.64

  %% cc. 65–68 · bajo de quintas (1ª vez, termina en Mi)
  la,4 r4 re4                                             | % c.65
  sols4 r4 dos4                                           | % c.66
  fas4 r4 si,4                                            | % c.67
  mi2. \bar "||"                                          | % c.68

  %% cc. 69–72 · bajo de quintas (2ª vez, termina en Mi)
  la,4 r4 re4                                             | % c.69
  sols4 r4 dos4                                           | % c.70
  fas4 r4 si,4                                            | % c.71
  mi2. \bar "||"                                          | % c.72

  %% cc. 73–76 · bajo de quintas hacia Fa# menor (termina Do# Si# Do#)
  la,4 r4 re4                                             | % c.73
  sol4 r4 dos4                                            | % c.74
  fas4 r4 si,4                                            | % c.75
  dos4 sis,4 dos4                                         | % c.76

  %% cc. 77–92 · Fa# menor
  \celulamenor \bar "||"     % cc. 77–80 · variación en Fa# menor
  \celulamenor \bar "||"     % cc. 81–84 · hueco (1ª vez)
  \celulamenor \bar "||"     % cc. 85–88 · hueco (2ª vez)
  \celulamenora              % cc. 89–92 · con la 4ª voz, vuelta a La

  %% cc. 93–97 · final: Si – Do# – Re – Mi – La
  si,2.                                                   | % c.93
  dos2.                                                   | % c.94
  re2.                                                    | % c.95
  mi2~ <mi, mi>4                                          | % c.96   (Mi2 añadido en el 3er tiempo)
  la,2.                                                   | % c.97
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
