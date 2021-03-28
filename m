References: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b63128cc-14cf-b1a4-684d-4c3fcb291f04@...2181...>
Date: Sun, 28 Mar 2021 01:52:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAALvpZTo6VYxcLXtXXyMsUU-n3JRSOJ-62fny7Zfi28WSDYXmA@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Stop using deprecated getpass()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?T=c3=b5ivo_Leedj=c3=a4rv?= <toivol@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

sorry if it took this long to get to this patch.

Unfortunately this patch should be rebased on master, because right now
it does not apply and I cannot test.
Can you please rebase and resubmit it (with v2 in the subject)?

However, I have some comments below.

On 13/01/2021 20:19, Tõivo Leedjärv wrote:
> The getpass() function is present in SUSv2, but marked LEGACY. It is
> removed in POSIX.1-2001. Additionally, on Solaris getpass() returns
> maximum 8 bytes. This will make longer passwords fail with no
> possibility for user to know what is happening.
> 

Indeed the manpage clearly says that this function is obsolete, and
users should look into termios.

I believe termios.h should normally be available on any *nix system,
therefore it should be ok to switch to it.

> This patch removes usage of getpass() completely and replaces it with
> direct implementation of what getpass() does: opens tty (existing code),
> outputs the prompt (existing code), turns off echoing (new code), reads
> one line (existing code shared with echoed mode), restores tty state
> (new code) and closes tty (existing code).
> 
> Signed-off-by: Tõivo Leedjärv <69477666+tleedjarv@...2243...>
> ---
>  configure.ac                  |  4 ++-
>  src/openvpn/console_builtin.c | 63 +++++++++++++++++++++--------------
>  2 files changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 1ab8fe59..2c094da7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -645,7 +645,7 @@ AC_FUNC_FORK
> 
>  AC_CHECK_FUNCS([ \
>         daemon chroot getpwnam setuid nice system getpid dup dup2 \
> -       getpass syslog openlog mlockall getgrnam setgid \
> +       syslog openlog mlockall getgrnam setgid \
>         setgroups stat flock readv writev time gettimeofday \
>         ctime memset vsnprintf strdup \
>         setsid chdir putenv getpeername unlink \
> @@ -653,6 +653,8 @@ AC_CHECK_FUNCS([ \
>         epoll_create strsep \
>  ])
> 
> +AC_CHECK_HEADERS([termios.h])

We already have a big list of headers that we check. May it make sense
to append termios.h there?

> +
>  AC_CHECK_LIB(
>         [dl],
>         [dlopen],
> diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
> index 445928bf..f1d91b32 100644
> --- a/src/openvpn/console_builtin.c
> +++ b/src/openvpn/console_builtin.c
> @@ -40,6 +40,10 @@
>  #include "buffer.h"
>  #include "misc.h"
> 
> +#ifdef HAVE_TERMIOS_H
> +#include <termios.h>
> +#endif
> +
>  #ifdef _WIN32
> 
>  #include "win32.h"
> @@ -138,7 +142,7 @@ get_console_input_win32(const char *prompt, const
> bool echo, char *input, const
>  #endif   /* _WIN32 */
> 
> 
> -#ifdef HAVE_GETPASS
> +#ifdef HAVE_TERMIOS_H
> 
>  /**
>   * Open the current console TTY for read/write operations
> @@ -177,7 +181,7 @@ close_tty(FILE *fp)
>      }
>  }
> 
> -#endif   /* HAVE_GETPASS */
> +#endif   /* HAVE_TERMIOS_H */
> 
> 
>  /**
> @@ -201,7 +205,9 @@ get_console_input(const char *prompt, const bool
> echo, char *input, const int ca
> 
>  #if defined(_WIN32)
>      return get_console_input_win32(prompt, echo, input, capacity);
> -#elif defined(HAVE_GETPASS)
> +#elif defined(HAVE_TERMIOS_H)
> +    int restore_tty = 0;

shouldn't this be bool?

> +    struct termios tty_a, tty_save;

how about tty_tmp instead of tty_a ?

> 
>      /* did we --daemon'ize before asking for passwords?
>       * (in which case neither stdin or stderr are connected to a tty and
> @@ -220,33 +226,40 @@ get_console_input(const char *prompt, const bool
> echo, char *input, const int ca
>          close(fd);
>      }
> 
> -    if (echo)
> -    {
> -        FILE *fp;
> +    FILE *fp;
> 
> -        fp = open_tty(true);
> -        fprintf(fp, "%s", prompt);
> -        fflush(fp);
> -        close_tty(fp);
> +    fp = open_tty(true);

since you are touching this code, please move the initialization inline
with the declaration.

> +    fprintf(fp, "%s", prompt);
> +    fflush(fp);
> +    close_tty(fp);
> 
> -        fp = open_tty(false);
> -        if (fgets(input, capacity, fp) != NULL)
> -        {
> -            chomp(input);
> -            ret = true;
> -        }
> -        close_tty(fp);
> +    fp = open_tty(false);
> +
> +    if (!echo && (tcgetattr(fileno(fp), &tty_a) == 0))
> +    {
> +        tty_save = tty_a;
> +        tty_a.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
> +        restore_tty = (tcsetattr(fileno(fp), TCSAFLUSH, &tty_a) == 0);
>      }
> -    else
> +
> +    if (fgets(input, capacity, fp) != NULL)
>      {
> -        char *gp = getpass(prompt);
> -        if (gp)
> -        {
> -            strncpynt(input, gp, capacity);
> -            secure_memzero(gp, strlen(gp));
> -            ret = true;
> -        }
> +        chomp(input);
> +        ret = true;
>      }
> +
> +    if (!echo && restore_tty)

I guess we can simply check restore_tty being true?

> +    {
> +        (void) tcsetattr(fileno(fp), TCSAFLUSH, &tty_save);

We should not need to cast to void - I don't think we have warnings set
for non-checked return values.

> +
> +        /* Echo the non-echoed newline */
> +        close_tty(fp);
> +        fp = open_tty(true);
> +        fprintf(fp, "\n");
> +        fflush(fp);
> +    }
> +
> +    close_tty(fp);
>  #else  /* if defined(_WIN32) */
>      msg(M_FATAL, "Sorry, but I can't get console input on this OS
> (%s)", prompt);
>  #endif /* if defined(_WIN32) */
> 

The rest looks good to me and I believe it is a valid patch.

Once we have a patch that can be committed on master I will perform some
tests.

Best Regards,


-- 
Antonio Quartulli

