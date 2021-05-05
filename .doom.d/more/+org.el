;;; +org.el -*- lexical-binding: t; -*-
(after! org
  (require 'org-bullets)
  (setq org-directory "~/DATA/Nextcloud/Org"
        org-agenda-files (list "~/DATA/Nextcloud/Org/Agenda/Universidad"
                               "~/DATA/Nextcloud/Org/Agenda/Personal")
        org-default-notes-file '("~/DATA/Nextcloud/Org/Notes")
        org-bullets-bullet-list '("§" "◉" "○" "✸" "◆" "✜")
        org-ellipsis " ▼ "
        org-log-done 'time
        org-todo-keywords '((sequence "✅ TODO(t)" "📚 UNIVERSIDAD(u)" "🤔 PERSONAL(P)" "🕜 PROGRESS(p)" "|" "☑ DONE(d)" "❕ CANCELLED(c)" ))
        org-todo-keyword-faces (quote (("✅ TODO" :weight bold :foreground "#BE5046")
                                       ("📚 UNIVERSIDAD" :weight bold :foreground "#61AFEF")
                                       ("🤔 PERSONAL" :weight bold :foreground "#98C379")
                                       ("🕜 PROGRESS" :weight bold :foreground "#D19A66" :slant italic)
                                       ("☑ DONE" :weight bold :foreground "#4B5263" :slant italic)
                                       ("❕ CANCELLED" :weight bold :foreground "#4B5263" :slant italic :strike-through t)))))

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(after! ox-latex
  (add-to-list 'org-latex-classes
             '("unipdf"
               "\\documentclass{article}
                \\usepackage[utf8]{inputenc}
                \\usepackage[T1]{fontenc}
                \\usepackage[labelformat=empty]{caption}
                \\usepackage{graphicx}
                \\usepackage{longtable}
                \\usepackage[hidelinks]{hyperref}
                \\usepackage{natbib}
                \\usepackage{caption}
                \\usepackage{booktabs}
                \\usepackage{siunitx}
                \\usepackage{amssymb}
                \\usepackage{parskip}
                \\usepackage{enumitem}
                \\usepackage{amsmath}
                \\usepackage{relsize}
                \\usepackage{xcolor}
                \\usepackage{microtype}
                \\DisableLigatures{encoding = T1, family = tt* }
                \\usepackage{geometry}
                \\geometry{a4paper,left=2cm,top=2cm,right=2cm,bottom=2cm,marginparsep=4pt, marginparwidth=.3in}"
                        ("\\section*{%s}" . "\\section*{%s}")
                        ("\\subsection*{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph*{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph*{%s}" . "\\subparagraph*{%s}"))))

(custom-set-faces! '(org-level-3 :inherit outline-3 :height 1.1))
(custom-set-faces! '(org-level-2 :inherit outline-2 :height 1.25))
(custom-set-faces! '(org-level-1 :inherit outline-1 :height 1.5))
(custom-set-faces! '(org-document-title :height 2.0))

(add-hook 'org-mode-hook
          (lambda ()
            (push '("[ ]" . "") prettify-symbols-alist)
            (push '("[X]" . "" ) prettify-symbols-alist)
            (push '("[-]" . "" ) prettify-symbols-alist)
            (prettify-symbols-mode t)
            (org-bullets-mode t)))
(add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))


(add-hook 'org-agenda-mode-hook
          (lambda ()
            (emojify-mode t)))

;; remove comments from org document for use with export hook
;; https://emacs.stackexchange.com/questions/22574/orgmode-export-how-to-prevent-a-new-line-for-comment-lines
(defun delete-org-comments (backend)
  (loop for comment in (reverse (org-element-map (org-element-parse-buffer)
                    'comment 'identity))
    do
    (setf (buffer-substring (org-element-property :begin comment)
                (org-element-property :end comment))
          "")))

;; add to export hook
(add-hook 'org-export-before-processing-hook 'delete-org-comments)

(defun compile-c-tangled-files ()
  (cond
   ((f-ext? (buffer-file-name) "c")
    (call-process-shell-command (format "gcc %s -o %s" (buffer-file-name) (file-name-sans-extension (buffer-file-name))) nil 0 nil))
   (t
    nil))
  (save-buffer))

(add-hook 'org-babel-post-tangle-hook 'compile-c-tangled-files)
