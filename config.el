;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Markus Klink"
      user-mail-address "justjoheinz@gmail.com")

;; setup roswll
(setq exec-path (append exec-path '("/usr/local/bin")))
(load (expand-file-name "~/.roswell/helper.el"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; use a slightly bigger font
(setq doom-font (font-spec :family "Fira Code" :size 16))

;; company mode
(setq company-idle-delay 0.2)

;; setup Mac keybindings for copy, paste, cut
(bind-key "s-x" 'kill-region)
(bind-key "s-c" 'evil-yank)
(bind-key "s-v" 'evil-paste-after)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-journal-dir "~/org/journal/")
(setq org-roam-directory "~/org/roam/")
(setq org-agenda-files '("~/org/" "~/org/roam/" "~/org/journal/"))
(setq org-journal-time-format "")
(setq org-tag-alist '(("private" . ?p)
                      ("work"    . ?w)))
(setq org-log-into-drawer "LOGBOOK")
(setq org-journal-skip-carryover-drawers '("LOGBOOK"))
(require 'org-habit)
(require 'org-clock)
(after! org
  (setq org-agenda-files '("~/org" "~/org/roam" "~/org/journal"))
  (setq org-journal-enable-agenda-integration t)
  (setq org-tags-column 70)
  (org-agenda-files t)
  (setq org-latex-classes '(("article" "\\documentclass[11pt]{scrartcl}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("report" "\\documentclass[11pt]{scrreport}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("book" "\\documentclass[11pt]{scrbook}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "babel" t ("pdflatex")))
  (setq org-clock-persist t)
  (org-clock-persistence-insinuate)
  )

;; Insert a clocktable in each journal entry after creation
(defun journal-template ()
  (save-excursion
    (let ((template "\n\n#+BEGIN: clocktable :scope subtree :maxlevel 2\n#+END:\n\n[[https://odoo.inoio.de/web?#page=0&limit=80&view_type=list&model=hr.analytic.timesheet&action=731][goto ODOO]]"))
      (goto-char (point-max))
      (unless (search-backward template nil t)
        (insert template "\n\n")))))

(add-hook! org-journal-after-header-create #'journal-template)
(add-hook! org-mode auto-save-visited-mode)
(add-hook! 'auto-save-hook #'org-save-all-org-buffers)
;; switch to full screen on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(use-package! olivetti
  :init
  (setq olivetti-body-width 100)
  :hook
  (text-mode . olivetti-mode))

(after! org-roam
  (org-roam-server-mode t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
