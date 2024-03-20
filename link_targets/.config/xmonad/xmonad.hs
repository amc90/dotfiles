import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.ClickableWorkspaces
import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Groups.Wmii

import qualified XMonad.StackSet as W

myConfig = def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
      , layoutHook = myLayout
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "flameshot gui")
    , ("M-<Return>", spawn "uxterm")
    , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
    , ("<XF86AudioMute>", spawn "amixer set Master toggle")
    , ("<XF86AudioMicMute>", spawn "amixer set Capture toggle")
    , ("M-S-<Return>", windows W.swapMaster)

    , ("M-m", groupToFullLayout)
    , ("M-s", groupToTabbedLayout)
    , ("M-d", groupToVerticalLayout)
    , ("M-f", toggleGroupFull)
    , ("M-[", zoomGroupOut)
    , ("M-]", zoomGroupIn)
    , ("M-j", focusDown)
    , ("M-k", focusUp)
    , ("S-M-j", swapDown)
    , ("S-M-k", swapUp)
    , ("M-h", focusGroupUp)
    , ("M-l", focusGroupDown)
    , ("S-M-h", moveToGroupUp False)
    , ("S-M-l", moveToGroupDown False)
    , ("M-'", sendMessage ToggleStruts)
    ]

myPP = def { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
    , ppTitle   = xmobarColor "green" "" . shorten 40
    , ppVisible = wrap "(" ")"
    , ppUrgent  = xmobarColor "red" "yellow"
}

-- mySB = statusBarProp "xmobar" (pure myPP)
mySB = statusBarProp "xmobar" (clickablePP myPP)

myLayout = wmii shrinkText def

main :: IO ()
main = xmonad . withSB mySB . ewmhFullscreen . ewmh . docks . xmobarProp $ myConfig



