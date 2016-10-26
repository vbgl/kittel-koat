-include user.cfg

HAVE_APRON?=false
HAVE_Z3?=false

LIBPATH_APRON=
LIBS_APRON=
PP_OPTS_APRON=
ifeq (${HAVE_APRON},true)
  LIBPATH_APRON=-cflags -I,+apron -cflags -I,+mlgmpidl -lflags -I,+apron -lflags -I,+mlgmpidl
  LIBS_APRON=,bigarray,gmp,apron,boxMPQ,octD
  PP_OPTS_APRON=-DHAVE_APRON
endif

LIBPATH_Z3=
LIBS_Z3=
PP_OPTS_Z3=
ifeq (${HAVE_Z3},true)
#  LIBPATH_Z3=-cflags "-I /usr/local/lib/ocaml/4.01.0/Z3/" -lflags "-I /usr/local/lib/ocaml/4.01.0/Z3/" -cflags -I,+z3 -lflags "-cclib -lz3"
  LIBPATH_Z3=-cflags "-I /usr/local/lib/ocaml/3.12.1/Z3/" -lflags "-I /usr/local/lib/ocaml/3.12.1/Z3/" -cflags -I,+z3 -lflags "-cclib -lz3"
  LIBS_Z3=,z3
  PP_OPTS_Z3=-DHAVE_Z3
endif

OCB=ocamlbuild -use-ocamlfind
PACKAGES=-package ocamlgraph
PP_OPTS=-pp "camlp4o pa_macro.cmo $(PP_OPTS_APRON) $(PP_OPTS_Z3)"

OPTS=${PP_OPTS} -cflags -warn-error,+a

default: kittel koat

all: kittel koat convert

kittel: git_sha1.ml force_look
	${OCB} ${OPTS} ${PACKAGES} kittel.native

kittel.d.byte: git_sha1.ml force_look
	${OCB} ${OPTS} ${PACKAGES} kittel.d.byte

koat: git_sha1.ml force_look
	${OCB} ${OPTS} ${PACKAGES} koat.native

koat.d.byte: git_sha1.ml force_look
	${OCB} ${OPTS} ${PACKAGES} koat.d.byte

convert: force_look
	${OCB} ${OPTS} ${PACKAGES} convert.native

koatCConv: force_look
	${OCB} ${OPTS} ${PACKAGES} koatCConv.native

koatFSTConv: force_look
	${OCB} ${OPTS} ${PACKAGES} koatFSTConv.native

koatCESConv: force_look
	${OCB} ${OPTS} ${PACKAGES} koatCESConv.native

clean: force_look
	${OCB} -clean
	rm -f git_sha1.ml

git_sha1.ml: force_look
	echo 'let git_sha1 = "6ee36da724f87fe70b75ee5743430f073af10853"' > $@

force_look:
	@true
