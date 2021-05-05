;;; ~/.doom.d/keybindings.el -*- lexical-binding: t; -*-


(map!

 ;;
 ;; Leader key shortcuts
 ;;
 (:leader
   :desc "toggle neotree"       :n "o n"  #'neotree-toggle
   (:prefix-map ("-" . "custom")
     :desc "find file"                  :n "."  #'ido-find-file
     :desc "find file other window"     :n ":"  #'ido-find-file-other-window
     :desc "dired"                      :n "-"  #'dired-jump
     :desc "dired other window"         :n "_"  #'dired-other-window
     :desc "toggle neotree"             :n "n"  #'neotree-toggle
     :desc "toggle minimap"             :n "m"  #'minimap-mode
     :desc "toggle colors"              :n "c"  #'rainbow-mode
     :desc "toggle eshell popup"        :n "e"  #'+eshell/toggle
     :desc "toggle vterm popup"         :n "t"  #'+vterm/toggle
     :desc "git status"                 :n "g"  #'magit
     :desc "open browser"               :n "w"  #'open-browser
     :desc "open email"                 :n "M"  #'open-mail
     :desc "open telegram"              :n "T"  #'telega
     :desc "open whatsapp"              :n "s"  #'open-spotify
     :desc "open spotify"               :n "W"  #'open-whatsapp
     :desc "org agenda"                 :n "a"  #'org-agenda))

 ;;
 ;; Evil
 ;;
 "C-h"          #'evil-window-left
 "C-j"          #'evil-window-down
 "C-k"          #'evil-window-up
 "C-l"          #'evil-window-right
 "C-n"          #'next-buffer
 "C-p"          #'previous-buffer
 "C-<next>"     #'centaur-tabs-forward
 "C-<prior>"    #'centaur-tabs-backward
 "C-s"          #'save-buffer
 "C-q"          #'kill-current-buffer
 :nv    ",,"    #'comment-line

 ;;
 ;; Dired
 ;;
(:after dired
        :map dired-mode-map
        :n  "h"  #'dired-up-directory
        :n  "l"  #'dired-find-file
        :n  "."  #'dired-omit-mode
        :n  "m"  #'dired-mark
        :n  "M"  #'dired-unmark
        :n  "v"  #'dired-toggle-marks
        :n  "y"  #'dired-do-copy
        :n  "d"  #'dired-do-rename
        :n  "D"  #'dired-do-delete
        ;;:n  "md" #'dired-create-directory
        ;;:n  "mf" #'dired-create-empty-file
        ;;:n  "ch" #'dired-do-chmod
        ;;:n  "cr" #'dired-do-compress-to
        :n  "ex" #'dired-do-compress
        :n  "u"  #'dired-undo)

 ;;
 ;; Neotree
 ;;
 (:after neotree
   :map neotree-mode-map
   :n "g"         nil
   :n "h"         #'+neotree/collapse-or-up
   :n "l"         #'+neotree/expand-or-open
   :n "RET"       #'+neotree/expand-or-open
   :n "J"         #'neotree-select-next-sibling-node
   :n "K"         #'neotree-select-previous-sibling-node
   :n "H"         #'neotree-select-up-node
   :n "L"         #'neotree-select-down-node
   :n "v"         #'neotree-enter-vertical-split
   :n "s"         #'neotree-enter-horizontal-split
   :n "R"         #'neotree-refresh)
)
