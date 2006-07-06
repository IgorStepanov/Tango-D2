# Makefile to build D runtime library dmd.lib for Win32
# Designed to work with DigitalMars make
# Targets:
#	make
#		Same as make all
#	make lib
#		Build dmd.lib
#   make doc
#       Generate documentation
#	make clean
#		Delete unneeded files created by build process

CP=xcopy /y
RM=del /f
MD=mkdir

CFLAGS=-mn -6 -r
#CFLAGS=-g -mn -6 -r

DFLAGS=-release -O -inline -w
#DFLAGS=-g -release -w

TFLAGS=-O -inline -w
#TFLAGS=-g -w

DOCFLAGS=-version=DDoc

CC=dmc
LC=lib
DC=dmd

LIB_DEST=..

.DEFAULT: .asm .c .cpp .d .html .obj

.asm.obj:
	$(CC) -c $<

.c.obj:
	$(CC) -c $(CFLAGS) $< -o$@

.cpp.obj:
	$(CC) -c $(CFLAGS) $< -o$@

.d.obj:
	$(DC) -c $(DFLAGS) $< -of$@

.d.html:
	$(DC) -c -o- $(DOCFLAGS) -Df$*.html dmd.ddoc $<

targets : lib doc
all     : lib doc
lib     : dmd.lib
doc     : dmd.doc

######################################################

OBJ_BASE= \
    aaA.obj \
    aApply.obj \
    adi.obj \
    arraycast.obj \
    arraycat.obj \
    cast.obj \
    complex.obj \
    critical.obj \
    deh.obj \
    dmain2.obj \
    invariant.obj \
    memory.obj \
    memset.obj \
    monitor.obj \
    obj.obj \
    genobj.obj \
    qsort.obj \
    switch.obj \
    moduleinit.obj \
    trace.obj
# NOTE: trace.obj is not necessary for a successful build
# NOTE: a pre-compiled minit.obj has been provided in dmd
#   minit.obj

OBJ_UTIL= \
    util\console.obj \
    util\ctype.obj \
    util\stringutils.obj \
    util\utf.obj

OBJ_TI= \
    typeinfo\ti_Aa.obj \
    typeinfo\ti_AC.obj \
    typeinfo\ti_Acdouble.obj \
    typeinfo\ti_Acfloat.obj \
    typeinfo\ti_Acreal.obj \
    typeinfo\ti_Adchar.obj \
    typeinfo\ti_Adouble.obj \
    typeinfo\ti_Afloat.obj \
    typeinfo\ti_Ag.obj \
    typeinfo\ti_Aint.obj \
    typeinfo\ti_Along.obj \
    typeinfo\ti_Areal.obj \
    typeinfo\ti_Ashort.obj \
    typeinfo\ti_Aubyte.obj \
    typeinfo\ti_Auint.obj \
    typeinfo\ti_Aulong.obj \
    typeinfo\ti_Aushort.obj \
    typeinfo\ti_Awchar.obj \
    typeinfo\ti_byte.obj \
    typeinfo\ti_C.obj \
    typeinfo\ti_cdouble.obj \
    typeinfo\ti_cfloat.obj \
    typeinfo\ti_char.obj \
    typeinfo\ti_creal.obj \
    typeinfo\ti_dchar.obj \
    typeinfo\ti_Delegate.obj \
    typeinfo\ti_double.obj \
    typeinfo\ti_float.obj \
    typeinfo\ti_idouble.obj \
    typeinfo\ti_ifloat.obj \
    typeinfo\ti_int.obj \
    typeinfo\ti_ireal.obj \
    typeinfo\ti_long.obj \
    typeinfo\ti_ptr.obj \
    typeinfo\ti_real.obj \
    typeinfo\ti_short.obj \
    typeinfo\ti_ubyte.obj \
    typeinfo\ti_uint.obj \
    typeinfo\ti_ulong.obj \
    typeinfo\ti_ushort.obj \
    typeinfo\ti_void.obj \
    typeinfo\ti_wchar.obj

ALL_OBJS= \
    $(OBJ_BASE) \
    $(OBJ_UTIL) \
    $(OBJ_TI)

######################################################

ALL_DOCS=

######################################################

dmd.lib : $(ALL_OBJS)
	$(RM) $@
	$(LC) -c -n $@ $(ALL_OBJS) minit.obj

dmd.doc : $(ALL_DOCS)
	@echo No documentation available.

######################################################

clean :
	$(RM) /s *.di
	$(RM) $(ALL_OBJS)
	$(RM) $(ALL_DOCS)
	$(RM) dmd*.lib

install :
	$(MD) $(LIB_DEST)
	$(CP) dmd*.lib $(LIB_DEST)\.
