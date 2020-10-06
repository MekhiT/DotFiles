-- Imports
import XMonad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeys)
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CopyWindow
import XMonad.Actions.SwapWorkspaces
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.Dwindle

main = do
    xmproc <- spawnPipe "xmobar -d"
    xmonad $ docks  def        
        { terminal           = myTerminal,
                        modMask            = myModMask,
                        focusedBorderColor =  "#81a1c1",
                        normalBorderColor  = "#2e3440",
                        borderWidth        = myBorderWidth,
                        focusFollowsMouse   = myFocusFollowsMouse,
                        --workspaces         = myWorkspaces,
                        --normalBorderColor  = myNormalBorderColor,
                        -- focusedBorderColor = myFocusedBorderColor,

                        -- key bindings
                        keys                = newKeys,
                        -- mouseBindings      = myMouseBindings,
                         --hooks, layouts
                        layoutHook         = myLayout,
                         --manageHook         = myManageHook,
                        -- handleEventHook    = myEventHook,
                        logHook            = myLogHook xmproc,
                        startupHook        = myStartupHook
                        }

myTerminal          = "st"
myModMask           = mod4Mask
myBorderWidth       = 1
myFocusFollowsMouse = False
myBrowser           = "firefox"
myFileManager       = "thunar"
myLauncher          = "rofi -show drun -theme \"apps\""
myMusicPlayer       = "spotify"
myLayout            = avoidStruts(tiled ||| Mirror tiled ||| Full||| simpleTabbed ||| Dwindle R CW 1.5 1.1)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment when resizing panes
    delta   = 3/100
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
             [ ((modm .|. shiftMask, xK_b), spawn myBrowser)
             , ((modm .|. shiftMask, xK_m), spawn myMusicPlayer)
             , ((modm .|. shiftMask, xK_f), spawn myFileManager)
             , ((modm, xK_x), sendMessage ToggleStruts)
             , ((modm, xK_d), spawn myLauncher)
             , ((modm .|. shiftMask .|. controlMask, xK_s), spawn "systemctl suspend")
             , ((modm .|. shiftMask .|. controlMask, xK_l), spawn "betterlockscreen -l")
             , ((modm, xK_v), windows copyToAll)
             , ((modm .|. shiftMask, xK_v), killAllOtherCopies)
             --, ((modm .|. controlMask, k), windows $ swapWithCurrent i)
             ]
newKeys x = myKeys x `M.union` keys def x
myLogHook h = dynamicLogWithPP $ xmobarPP
        {ppOutput = hPutStrLn h}
myStartupHook::X()
myStartupHook = do
        setDefaultCursor xC_pirate
        spawnOnce "firefox"
        spawnOnce "discord"
        spawnOnce "nitrogen --restore"
        spawnOnce "picom"
        spawnOnce "xbindkeys"
