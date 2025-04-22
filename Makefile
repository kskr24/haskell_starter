GHCUP_DIR := /home/shkumar/.ghcup
GHC := $(GHCUP_DIR)/bin/ghc

.SUFFIXES:

# Initialize common variables
HSFLAGS :=
GHCFLAGS := 
#LDFLAGS := -Wl,-rpath
LDLIBS :=

HSFLAGS = -Wall -Wextra -g 

GHCFLAGS += -O2 -fPIC


MY_COMPILE.hs = $(GHC) $(GHCFLAGS) $(HSFLAGS) $(TARGET_ARCH)
MY_OUTPUT_OPTION = -o $@

%.o: %.hs
	$(MY_COMPILE.hs) -c $(MY_OUTPUT_OPTION) $<

EXE := 
SRC_SRC := $(shell /usr/bin/find -L src -maxdepth 1 -name '*.hs' ! -name "main.hs" ! -name "test.hs" -print)
SRC_SRC += $(shell /usr/bin/find -L src -maxdepth 2 -type d -name test -prune -o -name 'main.hs' -print)

EXE += $(patsubst %/main, %, $(patsubst %.hs, %, $(patsubst src/%, bin/%, $(SRC_SRC))))
# Also include any files with a .mk extension
SUB_MAKES += $(shell /usr/bin/find -L . -name '*.mk' -print)

# build_type was already included
SUB_MAKES := $(filter-out %build_type.mk , $(SUB_MAKES))


ifneq ($(SUB_MAKES),)
    include $(SUB_MAKES)
endif

all : exe

clean: temp_clean
	rm -f bin/*

temp_clean:
	rm -f src/*/main.o
	rm -f src/*/main.hi

exe: $(EXE) temp_clean
