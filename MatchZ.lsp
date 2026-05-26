;;===================================================================
;; MATCHZ.LSP
;; Description: Moves any selected object (block, circle, line) to a 
;;              Z-elevation specified by a clicked text/mtext object,
;;              then changes the moved object's color to green.
;; Author     : yoelhonig
;; Version    : 1.1
;;===================================================================

(defun c:MatchZ ( / ptEnt txtEnt ptData txtData txtStr zVal groupCode oldPt newPt )
  (vl-load-com)
  (princ "\n--- Match Z Command Started ---")
  
  ;; Start an undo group so 'U' undoes the whole session, not individual clicks
  (vla-StartUndoMark (vla-get-ActiveDocument (vlax-get-acad-object)))
  
  (while
    (and
      ;; 1. Select the visual "point" object first (Accepts Blocks, Circles, Lines, etc.)
      (setq ptEnt (car (entsel "\nSelect the POINT object (Block, Circle, etc.) [or press Enter to exit]: ")))
      
      ;; 2. Select the Text object second
      (setq txtEnt (car (entsel "\nSelect the TEXT object for Z reference: ")))
      (if (not (vl-position (cdr (assoc 0 (entget txtEnt))) '("TEXT" "MTEXT")))
        (progn (princ "\nInvalid selection. Second object must be TEXT or MTEXT.") nil)
        t
      )
    )
    
    (setq ptData (entget ptEnt))
    (setq txtData (entget txtEnt))
    (setq txtStr (cdr (assoc 1 txtData)))
    (setq zVal (distof txtStr))
    
    (if zVal
      (progn
        ;; Determine the correct DXF coordinate group code based on object type
        (setq groupCode (if (= (cdr (assoc 0 ptData)) "LINE") 10 10)) 
        
        (setq oldPt (cdr (assoc groupCode ptData)))
        (setq newPt (list (car oldPt) (cadr oldPt) zVal))
        
        ;; Update Z position
        (setq ptData (subst (cons groupCode newPt) (assoc groupCode ptData) ptData))
        
        ;; If it's a line, update the endpoint Z axis as well
        (if (= (cdr (assoc 0 ptData)) "LINE")
          (progn
            (setq oldPt (cdr (assoc 11 ptData)))
            (setq newPt (list (car oldPt) (cadr oldPt) zVal))
            (setq ptData (subst (cons 11 newPt) (assoc 11 ptData) ptData))
          )
        )
        
        ;; Update object color to green (Color code 3)
        (if (assoc 62 ptData)
          (setq ptData (subst (cons 62 3) (assoc 62 ptData) ptData))
          (setq ptData (append ptData (list (cons 62 3))))
        )
        
        (entmod ptData)
        (entupd ptEnt)
        (princ "\n-> Success! Object moved to new Z and changed to green.")
      )
      (princ "\n-> Error: Selected text is not a valid numeric elevation.")
    )
  )
  
  (vla-EndUndoMark (vla-get-ActiveDocument (vlax-get-acad-object)))
  (princ "\n--- Match Z Command Finished ---")
  (princ)
)
