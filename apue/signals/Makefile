ROOT=..
PLATFORM=$(shell $(ROOT)/systype.sh)
include $(ROOT)/Make.defines.$(PLATFORM)
PROGS = critical mask sigusr reenter read1 read2 suspend1 suspend2 sigtstp
MOREPROGS = systest2 tsleep2 

all:	$(PROGS) $(MOREPROGS) abort.o sleep1.o sleep2.o system.o system.o child
$(PROGS): $(LIBAPUE)
	$(CC) $(CFLAGS) $@.c -o $@ $(LDFLAGS) $(LDLIBS)

tsleep2: tsleep2.o sleep2.o
	$(CC) $(CFLAGS) -o tsleep2 tsleep2.o sleep2.o $(LDFLAGS) $(LDLIBS)

systest2: systest2.o system.o
	$(CC) $(CFLAGS) -o systest2 systest2.o system.o $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(PROGS) $(MOREPROGS) $(TEMPFILES) *.o file.hole $(CLD)

include $(ROOT)/Make.libapue.inc
