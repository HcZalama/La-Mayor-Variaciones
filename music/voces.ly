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
    { dos4 la fas | sols mi'8 re dos4 | re mi fas | mi8 re dos si la sols | }       % S
    { mi4 dos re | si sols' la | si la la sols8 fas mi re dos si |}       % A
    \vacio                                            % X
    \vacio                                                % Y

  %% cc. 5–8 · S arriba, A baja a acompañar al bajo
  \bloque
    { la4 la'8 sols fas4~ | fas mi re~ | re dos si~| si la si | }                      % S
    { dos4 r r8 la' | sols fas sols si la4~ | la8 sols la mi fas re | sols, si dos mi sols4 | }          % A
    \vacio                                                              % X
    \vacio                                                              % Y

  %% ─── SISTEMA 2 · cc. 9–16 ──────────────────────────────

  %% cc. 9–12 · 4 voces + bajo (Y baja al pentagrama del bajo)
  \bloque
    { dos8 la16 si dos8 re16 mi fas4| r8 mi16 fas | sols8 la16 si la4~ |  la4 sols4 fas ~ | fas mi re |}                      % S
    { la8 r8 r4 r8 si16 la | sols4 r4 r8 fas16 mi | re8 mi16 fas mi8 sols16 dos| si8 la | sols2. |}         % A
    \vacio
    \vacio               % Y

  %% cc. 13–16 · 1 sola voz (corcheas)
  \bloque
    { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    \vacio                                                              % X
    \vacio         
    
      %% cc. 17-20

     \bloque
    { dos4 mi fas8 re16 dos | si la sol fas mi' re dos mi las, fas sols las | si8 dos16 re mi mi re mi fas mi re dos| si la sols si mi, sols si mi sols mi fas sols | }  % S
    {mi8 la dos si la4 | dos, sol' dos, | re la' la | sols mi si' |}                                                         % A
    \vacio                                                              % X
    \vacio        
    
    
         \bloque
    { la4 sols fas | sols mi dos|  re la'8 sols fas mi | re dos si la sols si | }  % S
    {dos4 ~ dos4~ dos8 si~| si8 dos4 sols la8 ~ | la4 mi la | sols re8 dos si sols' |}                                                         % A
    \vacio                                                              % X
    \vacio    



         \bloque
    { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    \vacio                                                              % X
    \vacio    


    %      \bloque
    % { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    % {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    % \vacio                                                              % X
    % \vacio    
    %      \bloque
    % { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    % {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    % \vacio                                                              % X
    % \vacio    
    %      \bloque
    % { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    % {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    % \vacio                                                              % X
    % \vacio    
    %      \bloque
    % { dos8 dos16 si dos8 la dos la | sols8 mi'16 re mi8 sols, mi' la, | re la mi' sols, re' fas, |sols si'16 la si8 sols mi re |}  % S
    % {la8 r8 mi4 fas | mi re dos | si2.|  si8 sols'16 fas sols8 si sols fas |}                                                         % A
    % \vacio                                                              % X
    % \vacio    
    %                                                  % Y


  \bloqueVacio   % cc. 69–72
  \bloqueVacio   % cc. 73–76
  \bloqueVacio   % cc. 77–80
}
