/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const char *upvol[] = {"amixer", "set", "Master", "3+", NULL};
static const char *downvol[] = {"amixer", "set", "Master", "3-", NULL};
static const char *mutevol[] = {"amixer", "set", "Master", "toggle", NULL};
static const char *brupcmd[] = {"brightnessctl", "set", "3%+", NULL};
static const char *brdowncmd[] = {"brightnessctl", "set", "3%-", NULL};
static const int rmaster =
    1; /* 1 means master-area is initially on the right */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int systraypinning =
    0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor
          X */
static const unsigned int systrayonleft =
    0; /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst =
    1; /* 1: if pinning fails, display systray on the first monitor, False:
          display systray on the last monitor*/
static const int showsystray = 1; /* 0 means no systray */
static const int user_bh = 24; /* 0 means that dwm will calculate bar height, >=
                                  1 means dwm will user_bh as bar height */
static const int showbar = 1;  /* 0 means no bar */
static const int topbar = 0;   /* 0 means bottom bar */
static const char *fonts[] = {"Fira Code SemiBold:size=12"};
static const char dmenufont[] = "Source Code Pro Black:size=14";
static const char col_gray1[] = "#121212";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_orange[] = "#ffa500";
static const char col_cyan[] = "#00ffff";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray4, col_gray1, col_gray1},
    [SchemeSel] = {col_cyan, col_gray1, col_cyan},
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
const char *scratchcmd[] = {"st",
                            "-f",
                            "Fira Code:size=12",
                            "-n",
                            "scratch",
                            "-g",
                            "72x29",
                            "-e",
                            "nvim",
                            "/home/zim/.scratch.md",
                            "/home/zim/.todo.md",
                            "/home/zim/.ideas.md",
                            NULL};
const char *tagcmd[] = {
    "st",   "-f", "Fira Code:size=13", "-n", "tag", "-g", "50x9", "-e",
    "tags", NULL};
static Sp scratchpads[] = {
    /* name          cmd  */
    {"scratch", scratchcmd},
    {"tag", tagcmd},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title */
    /* class      instance    title       tags mask     isfloating   monitor */
    {NULL, "scratch", NULL, SPTAG(0), 1, -1},
    {NULL, "tag", NULL, SPTAG(1), 1, -1},
    {NULL, "qjackctl", NULL, SPTAG(1), 1, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"TILED", tile}, /* first entry is default */
    {"[M]", monocle},
    {NULL, NULL},
    {"FLOAT", NULL}, /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static const char *lockcmd[] = {"slock", NULL};
static const char *webcmd[] = {"brave", NULL};
static const char *termcmd[] = {"alacritty", NULL};
static const char *touchcmd[] = {"toggle_touchpad", NULL};
static const char *powercmd[] = {"systemctl", "suspend", NULL};
static const char *themecmd[] = {"/usr/local/bin/theme", NULL};
static const char *picomcmd[] = {"/usr/bin/bash"
                                 "/home/zim/.config/picom/picom-toggle.sh",
                                 NULL};

static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[]    = { "dmenu_run", "-m", dmenumon, "-fn",
// dmenufont, "-nb", col_gray1, "-nf", col_gray4, "-sb", col_gray1, "-sf",
// col_orange, NULL };
static const char *dmenucmd[] = {"rofi", "-show", "drun", "-show-icons", NULL};

static Key keys[] = {
    /* modifier                     key        function        argument */
    {0, XF86XK_PowerOff, spawn, {.v = powercmd}},
    {0, XF86XK_PowerOff, spawn, {.v = lockcmd}},
    {0, XF86XK_AudioMute, spawn, {.v = mutevol}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = downvol}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = upvol}},
    {0, XF86XK_MonBrightnessUp, spawn, {.v = brupcmd}},
    {0, XF86XK_MonBrightnessDown, spawn, {.v = brdowncmd}},
    {0, XF86XK_TouchpadToggle, spawn, {.v = touchcmd}},
    {Mod1Mask, XK_t, spawn, {.v = themecmd}},
    {MODKEY, XK_d, spawn, {.v = dmenucmd}},
    {MODKEY, XK_s, spawn, {.v = termcmd}},
    {MODKEY, XK_w, spawn, {.v = webcmd}},
    {MODKEY, XK_p, spawn, {.v = picomcmd}},
    {MODKEY, XK_n, spawn, SHCMD("neovide")},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_f, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_BackSpace, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY | ShiftMask, XK_space, setlayout, {.v = &layouts[3]}},
    {MODKEY, XK_space, cyclelayout, {.i = +1}},
    {MODKEY, XK_m, focusmaster, {0}},
    {MODKEY, XK_Return, togglefloating, {0}},
    {MODKEY, XK_x, togglermaster, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_o, togglescratch, {.ui = 0}},
    {MODKEY | ShiftMask, XK_o, togglescratch, {.ui = 1}},
    {MODKEY, XK_q, quit, {0}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8)

}; // Here all the bindings end

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button1, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
