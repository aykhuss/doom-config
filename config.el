;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alexander Huss"
      user-mail-address "alexander.huss@cern.ch")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; override fonts
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :size 15))
      ;;doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 15))

;; mixed-pitch mode for org files (no clue how to get the variable-pitch-font to match size?!)
;;(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;;(add-hook! 'org-mode-hook #'solaire-mode)
;;(setq mixed-pitch-variable-pitch-cursor nil)
(use-package mixed-pitch
  :hook (org-mode . mixed-pitch-mode))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-solarized-light)
;; using the `catppuccin-theme` package
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'mocha) ;; 'latte, 'frappe, 'macchiato, or 'mocha
;;(catppuccin-reload)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")


;; more performant and resolves conflict with org-appear
(setq org-fold-core-style 'text-properties)


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; set default coding system and line ending symbol
(setq-default buffer-file-coding-system 'utf-8-unix)

(require 'gnuplot)

(require 'org-ref)
;;(use-package org-ref
;;  :after org)

(setq bibtex-completion-bibliography '("~/Dropbox/bibliography/references.bib")
      bibtex-completion-notes-path "~/Dropbox/bibliography/bibtex-notes"
      bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
      bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
      bibtex-completion-additional-search-fields '(keywords)
      bibtex-completion-display-formats
      '((article       . "${=has-pdf=:1}${=has-note=:1} ${=key=} ${year:4} ${author:36} ${title:*} ${journal:40}")
        (inbook        . "${=has-pdf=:1}${=has-note=:1} ${=key=} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
        (incollection  . "${=has-pdf=:1}${=has-note=:1} ${=key=} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${=key=} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (t             . "${=has-pdf=:1}${=has-note=:1} ${=key=} ${year:4} ${author:36} ${title:*}"))
      bibtex-completion-pdf-open-function
      (lambda (fpath)
        (call-process "open" nil 0 nil fpath)))

;;(setq! bibtex-completion-bibliography '("/path/to/references.bib"))
(setq! citar-bibliography '("~/Dropbox/bibliography/references.bib"))


(define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)


;; org appear
(use-package org-appear ; better markup edit
  :after org
  :ensure t
  :hook (org-mode . org-appear-mode)
  :config
  (setq
    org-link-descriptive t
    ;;org-hide-emphasis-markers t
    org-appear-trigger 'always
    org-appear-autolinks t
    org-appear-autoemphasis t
    org-appear-autosubmarkers t
    org-appear-autoentities t
    org-appear-autokeywords t
    org-appear-inside-latex t
    org-appear-delay 0.0))

(use-package! org-superstar ; "prettier" bullets
  :hook (org-mode . org-superstar-mode)
  :config
  ;; Make leading stars truly invisible, by rendering them as spaces!
  (setq org-superstar-leading-bullet ?\s
        org-superstar-leading-fallback ?\s
        org-hide-leading-stars nil
        org-superstar-todo-bullet-alist
        '(("TODO" . 9744)
          ("[ ]"  . 9744)
          ("DONE" . 9745)
          ("[X]"  . 9745))))


(use-package! org-fancy-priorities ; priority icons
  :hook (org-mode . org-fancy-priorities-mode)
  :hook (org-agenda-mode . org-fancy-priorities-mode)
  :config (setq org-fancy-priorities-list '("⚑" "⬆" "■")))


;; use minted for listings
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
;; minted settings
(setq org-latex-minted-options
 '(("frame" "lines")
   ;;("style" "github-dark")
   ;;("breaklines" "")
   ("fontsize" "\\scriptsize")
  )
)

;; shell escape needed for minted
(setq org-latex-pdf-process (list "latexmk -shell-escape -f -pdf %f"))


(setq org-src-fontify-natively t)

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((cpp . t)
   (C . t)
   (F90 . t)
   (shell . t)
   (awk . t)
   (css . t)
   (gnuplot . t)
   (screen . t)
   (sed . t)
   (latex . t)
   (makefile . t)
   (wolfram . t)
   (python . t)
   (emacs-lisp . t)))


;; open new frame (when opening a file in Finder: new frame)
(setq ns-pop-up-frames t)


;; for wolfram-mode [https://melpa.org/#/wolfram-mode]
(autoload 'wolfram-mode "wolfram-mode" nil t)
(autoload 'run-wolfram "wolfram-mode" nil t)
(setq wolfram-program "/Applications/Mathematica.app/Contents/MacOS/MathKernel")
(add-to-list 'auto-mode-alist '("\\.m$" . wolfram-mode))
(add-to-list 'auto-mode-alist '("\\.wls$" . wolfram-mode))
(setq wolfram-path "directory-in-Mathematica-$Path") ;; e.g. on Linux ~/.Mathematica/Applications
;; use math instead of wolframscript
;;(setq org-babel-wolfram-command org-babel-wolfram-command-alt)
(setq org-babel-wolfram-command "/Applications/Mathematica.app/Contents/MacOS/wolframscript -print all -file")
;;(setq org-babel-wolfram-command "~/bin/mash")


;; automatically update files
(global-auto-revert-mode t)

;; `hotfuzz` better than emacs internal `flex` completion
;;(setq completion-styles '(hotfuzz orderless basic))
;;(setq completion-styles '(flex orderless basic))
(use-package fussy
  :ensure t
  :config
  (setq fussy-filter-fn 'fussy-filter-default)
  (setq fussy-use-cache t)
  (setq fussy-compare-same-score-fn 'fussy-histlen->strlen<)

  (push 'fussy completion-styles)
  (setq
   ;; For example, project-find-file uses 'project-files which uses
   ;; substring completion by default. Set to nil to make sure it's using
   ;; flx.
   completion-category-defaults nil
   completion-category-overrides nil))

;; defaults proposed in the manual [https://orgmode.org/manual/Activation.html]
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; more org settings
(setq org-log-done 'time
      org-agenda-files   (list "~/Dropbox/org/")
      org-refile-targets '((org-agenda-files :maxlevel . 3))
      org-refile-use-outline-path 'file
)

;; org-mac-link key binding for `g`rab
(when IS-MAC
  (add-hook 'org-mode-hook (lambda ()
    (define-key org-mode-map (kbd "C-c g") 'org-mac-link-get-link))))

;; multiple cursors
;;  > add cursor to each line
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;  > cursors based on selection
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; smooth scrolling (emacs > 29)
;; particularly useful with inline images to avoid "jumps"
(pixel-scroll-precision-mode)

;; disable company word suggestions in org text mode
(setq company-global-modes '(not text-mode org-mode))
