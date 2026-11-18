%% ===========================================================
%%  voces.ly — AQUÍ SE COMPONE
%%
%%  La pieza = 20 bloques de 4 compases (2 por sistema).
%%  Cada bloque lleva las 4 voces apiladas, siempre en este orden:
%%
%%      \bloque
%%        { ... }   % S  voz 1 — SIEMPRE pentagrama superior
%%        { ... }   % A  voz 2 — superior, o abajo con el bajo (\aInf)
%%        { ... }   % X  voz 3 — extra (casi siempre \vacio)
%%        { ... }   % Y  voz 4 — extra (casi siempre \vacio)
%%
%%  Una voz que calla:  \vacio      Todo el bloque vacío:  \bloqueVacio
%%
%%  REGLAS
%%   · Cada voz mide 4 compases y acaba en |  (si no, LilyPond avisa
%%     con la línea exacta: "voz A: 3 compases en vez de 4").
%%   · Cada voz es UNA línea continua en \relative: la 1ª nota de un
%%     bloque se coloca cerca de la última nota de ESA voz en el
%%     bloque anterior. Ajusta con ' o , si hace falta.
%%     (Inicios: S = do'' · A y X = do' · Y = do)
%%   · Cambiar de pentagrama:  \aInf  \aSup  \xInf  \xSup  \yInf  \ySup
%%     Ej.:  { \aInf dos4 mi la, | ... }   ← la voz A baja al bajo.
%%     Se queda allí hasta que escribas \aSup.
%%   · Tonalidad La mayor: escribe las alteradas  fas  dos  sols
%%   · Ligaduras entre bloques: permitidas (las voces son continuas).
%% ===========================================================

material = {

  %% ─── SISTEMA 1 · cc. 1–8 ───────────────────────────────

  %% cc. 1–4 · 2 voces arriba (S + A) + bajo
  \bloque
    { dos2 mi4 | sols2 la4 | si4 la sols | mi2. | }       % S
    { la'2 la4 | si2 re4   | fas4 re dos | si2.  | }       % A
    \vacio                                                % X
    \vacio                                                % Y

  %% cc. 5–8 · S arriba, A baja a acompañar al bajo
  \bloque
    { la2 sols4 | fas2 mi4 | re4 mi fas | mi2. | }                      % S
    { \aInf dos,4 mi la, | si2 sols4 | fas4 la sols | si2. | }          % A
    \vacio                                                              % X
    \vacio                                                              % Y

  %% ─── SISTEMA 2 · cc. 9–16 ──────────────────────────────

  %% cc. 9–12 · 4 voces + bajo (Y baja al pentagrama del bajo)
  \bloque
    { mi2 la,4 | si2 dos4 | re4 mi fas | si,2. | }                      % S
    { \aSup dos'2 fas,4 | sols2 la4 | fas4 sols la | sols2. | }         % A
    { la'2 re,4 | mi2 fas4 | si,4 si re | mi2. | }                      % X
    { \yInf mi2 fas4 | sols2 la4 | fas4 mi la | si2. | }                % Y

  %% cc. 13–16 · 1 sola voz (corcheas)
  \bloque
    { la8 si dos re mi fas | sols la sols fas mi re | dos si la sols la dos | si2. | }  % S
    \vacio                                                              % A
    \vacio                                                              % X
    \vacio                                                              % Y

  %% ─── SISTEMAS 3–10 · vacíos ─────────────────────────────
  \bloqueVacio   % cc. 17–20
  \bloqueVacio   % cc. 21–24
  \bloqueVacio   % cc. 25–28
  \bloqueVacio   % cc. 29–32
  \bloqueVacio   % cc. 33–36
  \bloqueVacio   % cc. 37–40
  \bloqueVacio   % cc. 41–44
  \bloqueVacio   % cc. 45–48
  \bloqueVacio   % cc. 49–52
  \bloqueVacio   % cc. 53–56
  \bloqueVacio   % cc. 57–60
  \bloqueVacio   % cc. 61–64
  \bloqueVacio   % cc. 65–68
  \bloqueVacio   % cc. 69–72
  \bloqueVacio   % cc. 73–76
  \bloqueVacio   % cc. 77–80
}
