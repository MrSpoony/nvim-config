; (attribute
;   (
;     (attribute_name) @_name
;     (#lua-match? @_name "%[.*%]")
;     (quoted_attribute_value
;       (attribute_value) @javascript
;     ) @_q_value
;   )
; ) @keyword
;
; (attribute
;   (
;     (attribute_name) @_name
;     (#lua-match? @_name "%(.*%)")
;     (quoted_attribute_value
;       (attribute_value) @javascript
;     ) @_value
;   )
; ) @keyword
;
; (attribute
;   (
;     (attribute_name) @_name
;     (#lua-match? @_name "^%*.*")
;     (quoted_attribute_value
;       (attribute_value) @javascript
;     ) @_value
;   )
; ) @keyword
;
; (
;   (text) @javascript
;   (#lua-match? @javascript "{{.*}}")
; )
