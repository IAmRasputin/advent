LISP ?= sbcl

build:
	$(LISP) --load advent.asd \
		--eval '(asdf:load-system :advent)' \
		--eval '(asdf:make :advent)' \
		--eval '(quit)'
