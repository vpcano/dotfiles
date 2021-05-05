;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;; Config files
;;
(load! "more/+org")
(load! "more/+keybindings")

;;
;; Personal info
;;
(setq user-full-name "Víctor Pérez Cano"
      user-mail-address "perezcanovictor@gmail.com")

;;
;; Fonts
;;
(setq doom-font (font-spec :family "JetbrainsMono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu Nerd Font" :size 16 :weight 'Light)
      doom-big-font (font-spec :family "Ubuntu Nerd Font" :size 24 :weight 'Light))
(after! doom-themes
  (setq
   doom-themes-enable-bold t
   doom-themes-enable-italic t))

;;
;; Dashboard
;;
;; (setq +doom-dashboard-banner-file (expand-file-name "logo.png" doom-private-dir))

;; Line numbers
(setq display-line-numbers-type 'relative)

;;
;; Neotree
;;
(after! neotree
  (setq neo-smart-open t
        neo-autorefresh t
        doom-themes-neotree-file-icons 'icons
        doom-themes-neotree-enable-file-icons 'icons
        neo-theme (if (display-graphic-p) 'icons 'arrow)
        neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.o$"))
)
(after! doom-themes
  (setq doom-neotree-file-icons t))

;;
;; Evil
;;
(setq-default evil-escape-key-sequence "ii")
(setq evil-vsplit-window-right t
      evil-split-window-below t)

;;
;; Modeline
;;
(setq doom-modeline-height 35)
(setq doom-modeline-icon t)
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)
(custom-set-faces! '(doom-modeline-evil-normal-state :weight bold :foreground "#8BE8FD"))
(custom-set-faces! '(doom-modeline-evil-insert-state :weight bold :foreground "#50FA7B"))

;;
;; Tab bar
;;
(after! centaur-tabs
  (setq centaur-tabs-height 35
        centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-modified-marker t
        centaur-tabs-close-button " "
        centaur-tabs-set-bar 'under
        x-underline-at-descent-line t
        centaur-tabs-show-new-tab-button t
        centaur-tabs-show-navigation-buttons t))
(add-hook 'server-after-make-frame-hook 'centaur-tabs-mode)
(add-hook 'dashboard-mode-hook 'centaur-tabs-local-mode)
(add-hook 'dired-mode-hook 'centaur-tabs-local-mode)
(add-hook 'eshell-mode-hook 'centaur-tabs-local-mode)
(add-hook 'vterm-mode-hook 'centaur-tabs-local-mode)
(add-hook 'after-init-hook 'centaur-tabs-mode)

;;
;; Scrollbar
;;
;; (scroll-bar-mode t)

;;
;; Eshell
;;
(setq eshell-aliases-file "more/aliases")

;;
;; Git
;;
(after! magit (set-evil-initial-state! 'magit-repolist-mode 'normal))
(after! vc (set-evil-initial-state! 'vc-git-region-history-mode 'normal))
(setq +magit-default-clone-url "https://github.com/")

;;
;; Default browser
;;
browse-url-browser-function 'browse-url-firefox

;;
;; Trash
;;
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/")

;;
;; Flycheck
;;
(after! flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
  (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
  (setq flycheck-standard-error-navigation nil))
(global-flycheck-mode t)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; flycheck errors on a tooltip (doesnt work on console)
(when (display-graphic-p (selected-frame))
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

;;
;; Dired
;;
(setq dired-dwim-target t)
;;
;; Peep dired
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; (add-hook! dired-mode 'peep-dired)
(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$\\|^\\..*$")

;;
;; Projectile
;;
(setq projectile-project-search-path "~/DATA/Dev/")


;;
;; Ligatures
;;
(let ((ligatures `((?-  . ,(regexp-opt '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->")))
                   (?/  . ,(regexp-opt '("/**" "/*" "///" "/=" "/==" "/>" "//")))
                   (?*  . ,(regexp-opt '("*>" "***" "*/")))
                   (?<  . ,(regexp-opt '("<-" "<<-" "<=>" "<=" "<|" "<||" "<|||::=" "<|>" "<:" "<>" "<-<"
                                         "<<<" "<==" "<<=" "<=<" "<==>" "<-|" "<<" "<~>" "<=|" "<~~" "<~"
                                         "<$>" "<$" "<+>" "<+" "</>" "</" "<*" "<*>" "<->" "<!--")))
                   (?:  . ,(regexp-opt '(":>" ":<" ":::" "::" ":?" ":?>" ":=")))
                   (?=  . ,(regexp-opt '("=>>" "==>" "=/=" "=!=" "=>" "===" "=:=" "==")))
                   (?!  . ,(regexp-opt '("!==" "!!" "!=")))
                   (?>  . ,(regexp-opt '(">]" ">:" ">>-" ">>=" ">=>" ">>>" ">-" ">=")))
                   (?&  . ,(regexp-opt '("&&&" "&&")))
                   (?|  . ,(regexp-opt '("|||>" "||>" "|>" "|]" "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||")))
                   (?.  . ,(regexp-opt '(".." ".?" ".=" ".-" "..<" "...")))
                   (?+  . ,(regexp-opt '("+++" "+>" "++")))
                   (?\[ . ,(regexp-opt '("[||]" "[<" "[|")))
                   (?\{ . ,(regexp-opt '("{|")))
                   (?\? . ,(regexp-opt '("??" "?." "?=" "?:")))
                   (?#  . ,(regexp-opt '("####" "###" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" "##")))
                   (?\; . ,(regexp-opt '(";;")))
                   (?_  . ,(regexp-opt '("_|_" "__")))
                   (?\\ . ,(regexp-opt '("\\" "\\/")))
                   (?~  . ,(regexp-opt '("~~" "~~>" "~>" "~=" "~-" "~@")))
                   (?$  . ,(regexp-opt '("$>")))
                   (?^  . ,(regexp-opt '("^=")))
                   (?\] . ,(regexp-opt '("]#"))))))
  (dolist (char-regexp ligatures)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(global-auto-composition-mode -1)

;;
;; Frame size
;;
(add-to-list 'default-frame-alist '(height . 46))
(add-to-list 'default-frame-alist '(width  . 168))

;;
;; System Functions
;;
(defun open-mail ()
  (interactive)
  (shell-command-to-string "$BROWSER https://mail.google.com"))

(defun open-whatsapp ()
  (interactive)
  (shell-command-to-string "whatsapp-nativefier"))

(defun open-browser ()
  (interactive)
  (shell-command-to-string "$BROWSER"))

(defun open-spotify ()
  (interactive)
  (shell-command-to-string "spotify"))

;;
;; Dashboard
;;
 (defvar fancy-splash-image-template
   (expand-file-name "emacs-e-template.svg" doom-private-dir)
   "Default template svg used for the splash image, with substitutions from ")

 (defvar fancy-splash-sizes
   `((:height 300 :min-height 50 :padding (0 . 2))
     (:height 250 :min-height 42 :padding (2 . 4))
     (:height 200 :min-height 35 :padding (3 . 3))
     (:height 150 :min-height 28 :padding (3 . 3))
     (:height 100 :min-height 20 :padding (2 . 2))
     (:height 75  :min-height 15 :padding (2 . 1))
     (:height 50  :min-height 10 :padding (1 . 0))
     (:height 1   :min-height 0  :padding (0 . 0)))
   "list of plists with the following properties
   :height the height of the image
   :min-height minimum `frame-height' for image
  :padding `+doom-dashboard-banner-padding' (top . bottom) to apply
  :template non-default template file
  :file file to use instead of template")

(defvar fancy-splash-template-colours
  '(("$colour1" . keywords) ("$colour2" . type) ("$colour3" . base5) ("$colour4" . base8))
  "list of colour-replacement alists of the form (\"$placeholder\" . 'theme-colour) which applied the template")

(unless (file-exists-p (expand-file-name "theme-splashes" doom-cache-dir))
  (make-directory (expand-file-name "theme-splashes" doom-cache-dir) t))

(defun fancy-splash-filename (theme-name height)
  (expand-file-name (concat (file-name-as-directory "theme-splashes")
                            theme-name
                            "-" (number-to-string height) ".svg")
                    doom-cache-dir))

(defun fancy-splash-clear-cache ()
  "Delete all cached fancy splash images"
  (interactive)
  (delete-directory (expand-file-name "theme-splashes" doom-cache-dir) t)
  (message "Cache cleared!"))

(defun fancy-splash-generate-image (template height)
  "Read TEMPLATE and create an image if HEIGHT with colour substitutions as
   described by `fancy-splash-template-colours' for the current theme"
  (with-temp-buffer
    (insert-file-contents template)
    (re-search-forward "$height" nil t)
    (replace-match (number-to-string height) nil nil)
    (dolist (substitution fancy-splash-template-colours)
      (goto-char (point-min))
      (while (re-search-forward (car substitution) nil t)
        (replace-match (doom-color (cdr substitution)) nil nil)))
    (write-region nil nil
                  (fancy-splash-filename (symbol-name doom-theme) height) nil nil)))

(defun fancy-splash-generate-images ()
  "Perform `fancy-splash-generate-image' in bulk"
  (dolist (size fancy-splash-sizes)
    (unless (plist-get size :file)
      (fancy-splash-generate-image (or (plist-get size :template)
                                       fancy-splash-image-template)
                                   (plist-get size :height)))))

(defun ensure-theme-splash-images-exist (&optional height)
  (unless (file-exists-p (fancy-splash-filename
                          (symbol-name doom-theme)
                          (or height
                              (plist-get (car fancy-splash-sizes) :height))))
    (fancy-splash-generate-images)))

(defun get-appropriate-splash ()
  (let ((height (frame-height)))
    (cl-some (lambda (size) (when (>= height (plist-get size :min-height)) size))
             fancy-splash-sizes)))

(setq fancy-splash-last-size nil)
(setq fancy-splash-last-theme nil)
(defun set-appropriate-splash (&rest _)
  (let ((appropriate-image (get-appropriate-splash)))
    (unless (and (equal appropriate-image fancy-splash-last-size)
                 (equal doom-theme fancy-splash-last-theme)))
    (unless (plist-get appropriate-image :file)
      (ensure-theme-splash-images-exist (plist-get appropriate-image :height)))
    (setq fancy-splash-image
          (or (plist-get appropriate-image :file)
              (fancy-splash-filename (symbol-name doom-theme) (plist-get appropriate-image :height))))
    (setq +doom-dashboard-banner-padding (plist-get appropriate-image :padding))
    (setq fancy-splash-last-size appropriate-image)
    (setq fancy-splash-last-theme doom-theme)
    (+doom-dashboard-reload)))

(add-hook 'window-size-change-functions #'set-appropriate-splash)
(add-hook 'doom-load-theme-hook #'set-appropriate-splash)

(setq +doom-dashboard-menu-sections
      '(("Reload last session"
         :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
         :when (cond
                ((featurep! :ui workspaces)
                 (file-exists-p
                  (expand-file-name persp-auto-save-fname persp-save-dir)))
                ((require 'desktop nil t)
                 (file-exists-p
                  (desktop-full-file-name))))
         :face (:inherit (doom-dashboard-menu-title bold))
         :action doom/quickload-session)
        ("Open web browser"
         :icon (all-the-icons-faicon "firefox" :face 'doom-dashboard-menu-title)
         :action open-browser)
        ("Open spotify"
         :icon (all-the-icons-faicon "spotify" :face 'doom-dashboard-menu-title)
         :action open-spotify)
        ("Open telegram"
         :icon (all-the-icons-faicon "paper-plane" :face 'doom-dashboard-menu-title)
         :action telega)
        ("Open whatsapp"
         :icon (all-the-icons-faicon "whatsapp" :face 'doom-dashboard-menu-title)
         :action open-whatsapp)
        ("Open mail"
         :icon (all-the-icons-material "email" :face 'doom-dashboard-menu-title)
         :action open-mail)
        ("Open org-agenda" :icon
         (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
         :when
         (fboundp 'org-agenda)
         :action org-agenda)
        ("Recently opened files" :icon
         (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Open project" :icon
         (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Jump to bookmark" :icon
         (all-the-icons-octicon "bookmark" :face 'doom-dashboard-menu-title)
         :action bookmark-jump)
        ("Open private configuration" :icon
         (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
         :when
         (file-directory-p doom-private-dir)
         :action doom/open-private-config)
        ("Open documentation" :icon
         (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
         :action doom/help)))

;;
;; Theme
;;
(setq programming-theme 'doom-monokai-pro)
(setq text-editing-theme 'doom-acario-light)
(setq doom-theme programming-theme)

(defun apply-text-editing-theme ()
  (display-line-numbers-mode -1)
  (variable-pitch-mode t)
  (emojify-mode t)
  (unless (eq doom-theme text-editing-theme))
  (load-theme text-editing-theme))

(add-hook 'org-mode-hook #'apply-text-editing-theme)
(add-hook 'markdown-mode-hook #'apply-text-editing-theme)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
