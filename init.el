;; Enable package management with MELPA

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
 
;; Suppress the 'About Emacs' splash screen on startup
(setq inhibit-splash-screen t)

;; Location information for sunrise/sunset
(setq calendar-longitude -74.0060)
(setq calendar-latitude 40.7128)
(setq qcalendar-location-name "New York City, NY")

;; When opening a symlink to a version controlled file (e.g. in a git repo),
;; follow the symlink to the true file without prompting the user for a 'y/n?'
;; Note that this discards the symlink path that was used to open the file; emacs
;; will always refer to the 'true' path of the file from this point on.
(setq vc-follow-symlinks t)

;; Dictionary
(use-package define-word
  :ensure t
  :bind (("C-c d" . define-word-at-point)
	 ("C-c D" . define-word)))

;; Show which key chords are available after what you've typed so far
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Move between windows/frames via the arrow keys instead of "C-x o"
(use-package windmove
  :ensure t
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))

;; Linting
(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

;; Completion
(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
          (setq company-minimum-prefix-length 1))

;; Language Server Protocol
(use-package lsp-mode
  :ensure t
  :commands lsp)

(use-package lsp-ui
  :ensure t)

;; Auto-generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f2c35f8562f6a1e5b3f4c543d5ff8f24100fae1da29aeb1864bbc17758f52b70" default))
 '(package-selected-packages
   '(which-key company flycheck-rust flycheck lsp-ui zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package zenburn-theme
  :ensure t)
(load-theme 'zenburn t)
