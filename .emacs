(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(require 'org)
;; add and enable evil mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;;rebind jk to escape evil states from insert mode
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

;; You can change the path here
;;(add-to-list 'load-path "C:/Users/mdtho/emacs")

;; enable/disable global line numbers
(global-linum-mode 1)

;; enable/disable menu-bar, tool-bar and scroll-bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;Commands for enabling and loading powerline
(require 'powerline)
(powerline-default-theme)

;;Rebinding agenda keybinds
;;(define-key org-agenda-mode-map "j" 'org-agenda-next-item)
;;(define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
;;(define-key org-agenda-mode-map "J" 'air-org-agenda-next-header)
;;(define-key org-agenda-mode-map "K" 'air-org-agenda-previous-header)

;; Commands for enabling and loading airline themes for powerline
;;(require 'airline-themes)
;;(load-theme 'airline-raven)

;;bind org-mode agenda to S-SPC
(defun air-pop-to-org-agenda (&optional split)
  "Visit the org agenda, in the current window or a SPLIT."
  (interactive "P")
  (org-agenda nil "d")
  (when (not split)
    (delete-other-windows)))

(define-key evil-normal-state-map (kbd "S-SPC") 'air-pop-to-org-agenda)
;;specify org-mode agenda states
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELLED")))

;;specify org-mode agenda files
(setq org-agenda-files '("C:/Users/mdtho/Documents/Org-Files/Agendas/"))
(setq org-directory "C:/Users/mdtho/Documents/Org-Files/")
(setq org-mobile-directory "C:/Users/mdtho/Documents/mobile-Org/")
(setq org-mobile-inbox-for-pull "C:/Users/mdtho/Documents/mobile-Org-inbox/inbox.Org")
;;specify agenda option to view all scheduled and unscheduled TODOS and to see top
;; priority items first
(setq org-agenda-custom-commands
      '(("d" "Daily Agenda and all TODOs"
	 (( tags "PRIORITY=\"A\""
		 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
		  (org-agenda-overriding-header "High-priority unfinished tasks:")))
	 (agenda "" ((org-agenda-ndays 1)))
	 (alltodo ""
		  ((org-agenda-skip-function
		    '(or (air-org-skip-subtree-if-habit)
			 (air-org-skip-subtree-if-priority ?A)
			 (org-agenda-skip-if nil '(scheduled deadline))))
		   (org-agenda-overriding-header "ALL normal priority tasks:"))))
	 ((org-agenda-compact-blocks t)))))

;;Perspective mode commands
(with-eval-after-load "persp-mode-autoloads"
  (setq wg-morph-on nil) ;; switch off animation
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

;;doom theme code
(require 'doom-themes)

;;Global setting (defaults)
(setq doom-themes-enable-bold t ;if nil, bold is universally disabled
      doom-themes-enable-italic t) ;if nil, italics is universally disables

;; Load the theme (doom-one, doom-molokai, etc) ; keep in mind each theme
;; may have their own settings.
(load-theme 'doom-molokai t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)

;; or for treemacs users
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification
(doom-themes-org-config)

;; add custome theme path
;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" "da538070dddb68d64ef6743271a26efd47fbc17b52cc6526d932b9793f92b718" default)))
 '(display-line-numbers (quote relative))
 '(global-linum-mode nil)
 '(linum-format (quote dynamic))
 '(org-agenda-files
   (quote
    ("C:/Users/mdtho/Documents/Org-Files/Agendas/MutliWK.Org" "C:/Users/mdtho/Documents/Org-Files/Agendas/WK14.Org" "C:/Users/mdtho/Documents/Org-Files/Agendas/habits.org")))
 '(package-selected-packages
   (quote
    (lsp-java eclim key-chord org-mobile-sync persp-mode spaceline airline-themes powerline nerdtab pdf-tools org-cua-dwim mmm-mode helm doom-themes))))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; elisp function to skip over TODOs of a certain priority
(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
	(pri-value (* 1000 (- org-lowest-priority priority)))
	(pri-current (org-get-priority (thing-at-point 'line t))))
	(if (= pri-value pri-current)
	    subtree-end
	  nil)))

;;elisp function to filter out habits
(defun air-org-skip-subtree-if-habit ()
  "Skip and agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
	subtree-end
      nil)))

;; elisp function to jump between headers in agenda view
(defun air-org-agenda-next-header ()
  "Jump to the next header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header))

(defun air-org-agenda-previous-header ()
  "Jump to the previous header in an agenda series."
  (interactive)
  (air--org-agenda-goto-header t))

(defun air--org-agenda-goto-header (&optional backwards)
  "Find the next agenda series header forwards or BACKWARDS."
  (let ((pos (save-excursion
               (goto-char (if backwards
                              (line-beginning-position)
                            (line-end-position)))
               (let* ((find-func (if backwards
                                     'previous-single-property-change
                                   'next-single-property-change))
                      (end-func (if backwards
                                    'max
                                  'min))
                      (all-pos-raw (list (funcall find-func (point) 'org-agenda-structural-header)
                                         (funcall find-func (point) 'org-agenda-date-header)))
                      (all-pos (cl-remove-if-not 'numberp all-pos-raw))
                      (prop-pos (if all-pos (apply end-func all-pos) nil)))
                 prop-pos))))
    (if pos (goto-char pos))
    (if backwards (goto-char (line-beginning-position)))))

;; Code to enable and set-up lsp-java
;;(require 'lsp-java)
;;(add-hook 'java-mode-hook #'lsp)
