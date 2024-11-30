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
