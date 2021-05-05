ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)
PROGS = sigusr reenter
MOREPROGS = systest2 tsleep2 read1 read2

all:	$(PROGS) $(MOREPROGS) sleep1.o sleep2.o 
$(PROGS): $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

systest2: systest2.o sleep2.o
	$(CC) $(CFLAGS) -o systest2 systest2.o sleep2.o $(LDFLAGS) $(LDLIBS)

tsleep2: tsleep2.o sleep2.o
	$(CC) $(CFLAGS) -o tsleep2 tsleep2.o sleep2.o $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(PROGS) $(MOREPROGS) $(TEMPFILES) *.o file.hole $(CLD)

include $(ROOT)/Make.libapue.inc
