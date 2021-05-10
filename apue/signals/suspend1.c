#include "apue.h"

static void sig_int(int);

int
main(void)
{
	sigset_t newmask, oldmask, waitmask;

	pr_mask("program start pr_mask: ");

	if(signal(SIGINT, sig_int) == SIG_ERR)
		err_sys("signal(SIGINT) error");
	sigemptyset(&waitmask);
	sigemptyset(&newmask);
	sigaddset(&waitmask, SIGUSR1);
	sigaddset(&newmask, SIGINT);

	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0)
		err_sys("sigprocmask(SIG_BLOCK) error");

	pr_mask("in critical region pr_mask: ");

	if(sigsuspend(&waitmask) != -1)
		err_sys("sigsuspend error");

	pr_mask("after return from sissuspend pr_mask: ");

	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
		err_sys("sigprocmask(SIG_SETMASK) error");

	pr_mask("program exit pr_mask");

	exit(0);
}

static void
sig_int(int signo)
{
	pr_mask("\nin sig_int pr_mask: ");
}
