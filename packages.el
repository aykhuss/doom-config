;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

(package! gnuplot)

(package! org-ref)

(package! pdf-tools)

;; neat theme
(package! catppuccin-theme)

;;(package! wolfram-mode)
;; this is ahead in commits and also includes ob-wolfram for org babel
(package! wolfram-mode
  :recipe (:host github
           :repo "dalanicolai/wolfram-mode"))

;; more icons
(package! all-the-icons)

;; emacsclient in terminal looks ugly -> fix(?)
;; (package! solaire-mode :disable t)

;; fussy for fuzzy search [[https://github.com/jojojames/fussy]]
(package! fussy)
;; hotfuzz better fuzzy matching in emacs
(package! hotfuzz
  :recipe (:host github
           :repo "axelf4/hotfuzz"))

;; ways to link to mac applications
(when IS-MAC  (package! org-mac-link))

;; mixed-pitch fonts
;;(package! mixed-pitch
;;  :hook (org-mode . mixed-pitch-mode)
;;  :config
;;  (setq mixed-pitch-set-heigth t)
;;  (set-face-attribute 'variable-pitch nil :height 1.3))
(package! mixed-pitch)

;; we need to first unpin the package before overriding the build-in
;(unpin! org-appear)
;(package! org-appear :disable t)
; (package! org-appear
;  ;:pin "ddba200bb4db6947d384dcc1907b559dfcf5ef74"
;  :pin nil
;  :recipe (:type git
;           :host github
;           :repo "awth13/org-appear"
;           :branch "org-9.7-fixes"
;           :inherit nil
;           :source nil
;           ;:build nil
;           ))
; (package! org-appear :recipe (:branch "org-9.7-fixes"))
; (package! org-appear
;   :recipe (:fork (:host github
;                   :repo "awth13/org-appear"
;                   :branch "org-9.7-fixes")))
(package! org-appear
 :recipe (:type git
          :host github
          :repo "awth13/org-appear"
          :branch "org-9.7-fixes"))

;; manually do the "+pretty" part
(package! org-superstar)
(package! org-fancy-priorities)
