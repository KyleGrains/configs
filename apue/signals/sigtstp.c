#include "apue.h"

#define BUFFSIZE 1024

static void
sig_tstp(int signo)
{
	sigset_t mask;
	printf("call user defined SIGTSTP handler\n");
	sigemptyset(&mask);
	sigaddset(&mask, SIGTSTP);
	sigprocmask(SIG_UNBLOCK, &mask, NULL);
	signal(SIGTSTP, SIG_DFL);
	printf("send SIGTSTP to itself and call default SIGTSTP handler\n");
	kill(getpid(), SIGTSTP);
	signal(SIGTSTP, sig_tstp);
	printf("after SIGCONT, restore to user defined SIGTSTP handler\n");
}

int
main(void)
{
	int n;
	char buf[BUFFSIZE];
	if(signal(SIGTSTP, SIG_IGN) == SIG_DFL)
		signal(SIGTSTP, sig_tstp);
	while((n = read(STDIN_FILENO, buf, BUFFSIZE)) > 0)
		if(write(STDOUT_FILENO, buf, n) != n)
			err_sys("write error");
	if(n < 0)
			err_sys("read error");
	exit(0);
}
