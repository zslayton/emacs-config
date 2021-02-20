;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zack Slayton"
      user-mail-address "zack.slayton@gmail.com")

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

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


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



;; set the gui window to a larger initial size
(if (window-system) (set-frame-size (selected-frame) 196 64))

;; When editing markdown, line wrap text so it fits in 100 columns
(add-hook 'markdown-mode-hook (lambda () (set-fill-column 100) (turn-on-auto-fill)))

;; Markdown Table of Contents generator
(use-package! markdown-toc
  :ensure t)

;; Customize the output of markdown-toc
(custom-set-variables
 '(markdown-toc-header-toc-start "<!-- markdown-toc start -->")
 '(markdown-toc-header-toc-title "")
 '(markdown-toc-header-toc-end "<!-- markdown-toc end -->")
 '(markdown-toc-indentation-space 4))

;; I don't think this actually does anything.
(after! rustic
  (setq lsp-rust-server 'rust-analyzer))

;; If you disable LSP, uncomment this
;; This causes calls to 'racer' to require the nightly branch.
(after! rustic
  (setq rustic-flycheck-clippy-params "--message-format=json"))

;; Use rust-analyzer instead of the default, RLS
(after! rustic
  (setq rustic-lsp-server 'rust-analyzer))

;; ion-rust pulls in two submodules with a combined 1200+ files.
;; This can overwhelm lsp, which attempts to watch all of them for changes.
;; Adding those submodules to the lsp-file-watch-ignored pattern list speeds up
;; the initialization time for working with Rust substantially.
(after! lsp-mode
  (push "[/\\\\]ion-c-sys\\'" lsp-file-watch-ignored)
  (push "[/\\\\]ion-tests\\'" lsp-file-watch-ignored)
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-eldoc-render-all t)
  (setq lsp-idle-delay 0.6))

(after! lsp-ui
  (setq lsp-ui-peek-always-show t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-doc-enable nil))

;; Support for timestamps
(use-package! ts
  :ensure t)

;; Write the current datetime as an RFC-3339-compliant timestamp
(after! ts
  (defun now-rfc-3339
    ;; Arguments
    ()
    ;; Doc comment
    "Writes today's date as an RFC-3339 formatted timestamp at the cursor's current position."
    (interactive)
    (let ((now (ts-now))
          (format-string "%Y-%m-%dT%H:%M:%S%z"))
      (insert (ts-format format-string now)))))

(defun search-rust-docs-std
  ;; Arguments
  (search-term)
  ;; Doc comment
  "Searches the Rust stdlib documentation for the provided search term."
  (interactive "sSearch term: ")
  (browse-url (concat "https://doc.rust-lang.org/std/?search=" search-term)))

(global-set-key (kbd "C-c C-d") 'search-rust-docs-std)
