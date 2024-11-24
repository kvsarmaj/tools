;;******************************************************************************
;;; init.el --- Sarma Jonnavithula's init.el File for GNU Emacs
;;******************************************************************************

;; Author: Sarma Jonnavithula
;; Last-Updated: kArtika kRshNa navami, madhyAhnaM 11:20, krodhi nAma samvatsaraM, SAlivAhana SakaM 1946 i.e., 24 Nov 2024 in Gregorian Calendar
;; Last-Updated: Jyeshta krishna paksha tritiya, Madhyahnam 1:11, Hevalambi nama samvatsaram, Salivahana Sakam 1939 i.e., June 12th, 2017 in Gregorian Calendar

;; Free Software usable, modifiable and re-distributable under GNUGPL

;; No Gurantees. Use it if you will.
;; However, if you find any problems if you can write back to me, it would be good
;; I am reachable at vividvivek[AT]gmail[DOT]com

;;; Author's Note:
;; This is a start-up file for emacs.
;; It covers some basic stuff required for ease in using emacs/xemacs
;; I am and will be mostly using it for HDL Coding and Scripting
;; Therefore, this start-up is mostly suited for such purposes
;; Use it in conjunction with verilog-mode.el for better Verilog results
;; Modify any parameters that are pre-set accordingly
;;******************************************************************************

;; Main settings

;;**********************************************************
;; Welcome message 
;;**********************************************************

(defun startup-echo-area-message ()                           ; Configuring a sanskrit message
  "punah swAgataM .... parabrahmAya idaM na mama")
;;Meaning of the message : Welcome Back .... For Parabrahma, this is not mine

;;**********************************************************

;;**********************************************************
;; Basics
;;  - scroll bar on the right
;;  - highlight expressions in paranthesis
;;  - display time
;;  - accept y/n for yes/noo
;;**********************************************************

(if (fboundp 'set-scroll-bar-mode)                            ; Keep scrollbar on the right side
    (set-scroll-bar-mode 'right))
(display-time)                                                ; To display time of the day
(if (fboundp 'paren-set-mode)                                 ; Highlight expressions
    (paren-set-mode 'sexp)
  (setq show-paren-style 'expression)
  (show-paren-mode t))

;;(auto-fill-mode t)                                            ; Automatically wrap lines

(fset 'yes-or-no-p 'y-or-n-p)                                 ; Use short forms for Yes or No - y or n

;;**********************************************************

;;**********************************************************
;; Font lock customization
;;  - For color scheme - GNU Emacs, XEmacs,
;;  - Some custom scenarios to highlight code comments
;;     We use WTFix to indicate a possible fix for a BUG/FIXME/REVISIT
;;**********************************************************

(require 'font-lock)
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode t))
(make-face 'trailing-spaces-face)
(add-hook 'font-lock-mode-hook                                ; Show trailing spaces and make fixme tags standout
          (lambda ()
            (font-lock-add-keywords nil
             '(("[ \t]+$" 0 'trailing-spaces-face)
               ("FIXME:\\|TODO:\\|BUG:\\|REVISIT:\\|WTFix:" 0 'font-lock-warning-face t)))))

;;**********************************************************

;;**********************************************************
;; Some usefule keybindings
;;**********************************************************

(define-key global-map [(control ?q)] nil)                    ; Ctrl-q is prefix key
(define-key global-map [(control ?q) ?g] 'goto-line)          ; Ctrl-q g takes you to a line
(define-key global-map [(control ?q) ?t] 'delete-trailing-whitespace)     ; Ctrl-q t removes trailing whitespace
(define-key global-map [(control ?q) (control ?j)] (kbd "RET"))     ; Ctrl-q Ctrl-j is RET

;;**********************************************************

;;**********************************************************
;; This method is taken from Andrew Kensler's customization code
;; with a slight modification
;;**********************************************************

(defun goto-matching-paren ()
  "If point is sitting on a parenthetic character, jump to its match."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1))
        ((progn
           (backward-char 1)
           (looking-at "\\s\)")) (forward-char 1) (backward-list 1))))
(define-key global-map [(control ?q) ?p] 'goto-matching-paren) ; Bind to Ctrl-q p

;;**********************************************************

;;**********************************************************
;; Custom variables set by emacs customization
;;**********************************************************
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(mouse-scroll-delay 0.2)
 '(mouse-yank-at-point t)
 '(normal-erase-is-backspace t)
 '(repeat-on-final-keystroke t)
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values (quote ((byte-compile-docstring-max-column . 90))))
 '(show-paren-mode t nil (paren))
 '(tab-width 4)
 '(undo-limit 10000)
 '(undo-strong-limit 30000)
 '(verilog-align-assign-expr t)
 '(verilog-align-ifelse t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-endcomments t)
 '(verilog-auto-indent-on-newline nil)
 '(verilog-auto-inst-column 30)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-newline nil)
 '(verilog-case-indent 4)
 '(verilog-cexp-indent 4)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-p1800-keywords nil)
 '(verilog-highlight-translate-off t)
 '(verilog-indent-begin-after-if nil)
 '(verilog-indent-declaration-macros nil)
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-directive 4)
 '(verilog-indent-level-module 4)
 '(verilog-minimum-comment-distance 4)
 '(verilog-tab-always-indent t)
 '(verilog-tab-to-comment nil)
 '(verilog-typedef-regexp       ".*_intf\\.\\|.*_intf\\|.*put.*_t\\|.*_t\\|.*_e")
 '(verilog-align-typedef-regexp ".*_intf\\.\\|.*_intf\\|.*put.*_t\\|.*_t\\|.*_e")
 '(visible-bell nil)
 '(warning-suppress-log-types (quote ((initialization)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "#000000" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :height 87 :width normal :family "b&h-lucidatypewriter")))))
;;**********************************************************

;;**********************************************************
;; Load path
;;**********************************************************
(add-to-list 'load-path "~/.emacs.d/" )
;;**********************************************************

;;**********************************************************
;; Verilog mode and verilog file extensions
;;  - my generated files take
;;     the extensions .gen.vh, .gen.v, .gen.svh, .gen.svh
;;**********************************************************

(autoload 'verilog-mode "verilog-mode.el" "Verilog mode" t)
(add-to-list 'auto-mode-alist '("\\.v$" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.vh$" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.sv$" . verilog-mode))
(add-to-list 'auto-mode-alist '("\\.svh$" . verilog-mode))

;;**********************************************************

;;**********************************************************
;; YAML mode - commenting it for now - didnt like it
;;**********************************************************
;;;;For yaml mode
;;(require 'yaml-mode)
;;    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;**********************************************************


;;**********************************************************
;; Mouse scroll 
;;**********************************************************

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

;;**********************************************************

;;**********************************************************
;; Untabify, untabify-save
;;**********************************************************

;;display name of the opened buffer as window title
(setq frame-title-format
  '("emacs - " (buffer-file-name "%f"
    (dired-directory dired-directory "%b"))))

;; Tabs to space - untabify the current buffer
(defun untabify-buffer ()
  "Untabify the whole (accessible part of the) current buffer"
  (interactive)
  (save-excursion
    (untabify (point-min) (point-max)))
)

(defun untabify-save ()
 "Untabify the current buffer and save the file"
  (interactive)
  (save-excursion
   (untabify-buffer)
   (save-buffer)
  )
)

;; binds for untabify and untabify-save
(define-key global-map [(control ?x) ?w] 'untabify-buffer)   ; Ctrl-x w untabifies the current buffer
(define-key global-map [(control ?x) ?c] 'untabify-save)     ; Ctrl-x c untabifies and saves the current buffer

(put 'upcase-region 'disabled nil)

;;**********************************************************

;;**********************************************************
;;Functions and keybinds for copy operations
;; - took some of this code from some online source
;;**********************************************************

;;base functions

;;Where is the point?
(defun get-point (symbol &optional arg)
      "get the point"
      (funcall symbol arg)
      (point)
     )

;;What to copy
(defun copy-thing (begin-of-thing end-of-thing &optional arg)
       "copy thing between beg & end into kill ring"
        (save-excursion
          (let ((beg (get-point begin-of-thing 1))
             (end (get-point end-of-thing arg)))
            (copy-region-as-kill beg end)))
     )

;;Paste yanked stuff to mark
(defun paste-to-mark(&optional arg)
       "Paste things to mark, or to the prompt in shell-mode"
       (let ((pasteMe
         (lambda()
           (if (string= "shell-mode" major-mode)
             (progn (comint-next-prompt 25535) (yank))
           (progn (goto-char (mark)) (yank) )))))
        (if arg
            (if (= arg 1)
            nil
              (funcall pasteMe))
          (funcall pasteMe))
        ))

;;Functions and key binds

;copy word under point
(defun copy-word (&optional arg)
      "Copy words at point into kill-ring"
       (interactive "P")
       (copy-thing 'backward-word 'forward-word arg)
       ;;(paste-to-mark arg)
     )


(global-set-key (kbd "C-c w")         (quote copy-word))

;copy line under point
(defun copy-line (&optional arg)
      "Save current line into Kill-Ring without mark the line "
       (interactive "P")
       (copy-thing 'beginning-of-line 'end-of-line arg)
       (paste-to-mark arg)
     )

(global-set-key (kbd "C-c l")         (quote copy-line))

;copy paranthesis
(defun beginning-of-parenthesis(&optional arg)
       "  "
       (re-search-backward "[[<(?\"]" (line-beginning-position) 3 1)
             (if (looking-at "[[<(?\"]")  (goto-char (+ (point) 1)) )
     )

(defun end-of-parenthesis(&optional arg)
       " "
       (re-search-forward "[]>)?\"]" (line-end-position) 3 arg)
             (if (looking-back "[]>)?\"]") (goto-char (- (point) 1)) )
     )

(defun thing-copy-parenthesis-to-mark(&optional arg)
       " Try to copy a parenthesis and paste it to the mark
     When used in shell-mode, it will paste parenthesis on shell prompt by default "
       (interactive "P")
       (copy-thing 'beginning-of-parenthesis 'end-of-parenthesis arg)
       (paste-to-mark arg)
     )

(global-set-key (kbd "C-c e")         (quote thing-copy-parenthesis-to-mark))

;;**********************************************************

;;**********************************************************
;; Refresh
;;  - basically revert the changes in the buffer
;;     back to the file if we dont like what we did!
;;**********************************************************

(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

(global-set-key (kbd "<f5>") 'revert-buffer)

;;**********************************************************

;;**********************************************************
;; Set font
;;  - I like Nimbus Mono PS Bold font
;;    Only problem I have with it is
;;     it takes a bit of effort to distinguish l and 1 
;;**********************************************************

(set-background-color "black")
(set-foreground-color "white")

(set-face-attribute 'default nil :font "Nimbus Mono PS Bold" )
(set-face-attribute 'default (selected-frame) :height 140)

;;**********************************************************

;;**********************************************************
;; Miscallaneous settings
;;**********************************************************
(setq line-number-display-limit-width 200000)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
;;**********************************************************

;;**********************************************************
;; Settings that I took from some online source but didnt find to my liking
;; Nevertheless, keeping it ... perhaps I may want to use it in future!

;;(setq-default initial-scratch-message nil
;;              default-truncate-lines t
;;              ;;font control
;;              font-lock-use-fonts '(or (mono) (grayscale))    ; Syntax Hilighting - On.
;;              font-lock-use-colors '(color)
;;              font-lock-maximum-decoration t
;;              font-lock-maximum-size nil
;;              font-lock-auto-fontify t
;;              global-font-lock-mode t
;;              ;;display details
;;              paren-mode 'sexp                                ; Parenthesis
;;              blink-cursor-alist '((t . hollow))              ; Cursor blinks solid and hollow
;;              ;;user-full-name "K V Sarma Jonnavithula"       ; Set name
;;              ;;user-mail-address "vividvivek@gmail.com"      ; Set e-mail address
;;              ;;display-warning-minimum-level 'error          ; Uncomment to avoid warning messages
;;              delete-key-deletes-forward t                    ; Delete key work Function
;;              ;;kill-read-only-ok t
;;              column-number-mode t                            ; Display line and column numbers
;;              line-number-mode t
;;              tab-width 4                                     ; Set tab stops
;;              indent-tabs-mode nil                            ; Use spaces only, no tabs
;;              //Print Function
;;              toolbar-print-function 'ps-print-buffer-with-faces ; Print Button function. I dont use it much
;;              ps-line-number t
;;              ps-n-up-printing 2
;;              ps-print-color-p nil
;;              fill-column 70                                  ; Wrap lines at 70th column
;;              display-time-day-and-date t                     ; Display the time and date on the mode line
;;              case-fold-search t                              ; Fold case on searches
;;              )
;;**********************************************************
