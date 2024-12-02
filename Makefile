LISP ?= sbcl 

all: build

clean:
	rm -f ./advent
	rm -f *.fasl

build:
	$(LISP) --load advent.asd \
		--eval '(asdf:load-system :advent)' \
		--eval '(asdf:make :advent)' \
		--eval '(quit)'
debug:
	$(LISP) --load advent.asd \
		--eval '(declaim (optimize (speed 0) (safety 0) (debug 3)))' \
		--eval '(asdf:load-system :advent)' \
		--eval '(asdf:make :advent)' \
		--eval '(quit)'

