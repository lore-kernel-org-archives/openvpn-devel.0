References: <20170725145718.13175-1-davids@...515...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <f06ba94e-2ac9-f8e4-5748-8c521f9b0624@...1435...>
Date: Tue, 25 Jul 2017 17:15:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170725145718.13175-1-davids@...515...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] cleanup: Move write_pid() to where it
 is being used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 25-07-17 16:57, David Sommerseth wrote:
> The write_pid() function is only used in openvpn.c, so no
> need to have that in the misc.[ch] mixed bag.
> 
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/misc.c    | 21 ---------------------
>  src/openvpn/misc.h    |  2 --
>  src/openvpn/openvpn.c | 21 +++++++++++++++++++++
>  3 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index ae96aa69..8a76bba8 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -142,27 +142,6 @@ run_up_down(const char *command,
>      gc_free(&gc);
>  }
>  
> -/* Write our PID to a file */
> -void
> -write_pid(const char *filename)
> -{
> -    if (filename)
> -    {
> -        unsigned int pid = 0;
> -        FILE *fp = platform_fopen(filename, "w");
> -        if (!fp)
> -        {
> -            msg(M_ERR, "Open error on pid file %s", filename);
> -        }
> -
> -        pid = platform_getpid();
> -        fprintf(fp, "%u\n", pid);
> -        if (fclose(fp))
> -        {
> -            msg(M_ERR, "Close error on pid file %s", filename);
> -        }
> -    }
> -}
>  
>  /*
>   * Set standard file descriptors to /dev/null
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index 32b64e8b..734e679c 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -68,8 +68,6 @@ void run_up_down(const char *command,
>                   const char *script_type,
>                   struct env_set *es);
>  
> -void write_pid(const char *filename);
> -
>  /* system flags */
>  #define S_SCRIPT (1<<0)
>  #define S_FATAL  (1<<1)
> diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
> index 08c09e6b..794de1a8 100644
> --- a/src/openvpn/openvpn.c
> +++ b/src/openvpn/openvpn.c
> @@ -47,6 +47,27 @@ process_signal_p2p(struct context *c)
>      return process_signal(c);
>  }
>  
> +/* Write our PID to a file */
> +static void
> +write_pid(const char *filename)
> +{
> +    if (filename)
> +    {
> +        unsigned int pid = 0;
> +        FILE *fp = platform_fopen(filename, "w");
> +        if (!fp)
> +        {
> +            msg(M_ERR, "Open error on pid file %s", filename);
> +        }
> +
> +        pid = platform_getpid();
> +        fprintf(fp, "%u\n", pid);
> +        if (fclose(fp))
> +        {
> +            msg(M_ERR, "Close error on pid file %s", filename);
> +        }
> +    }
> +}
>  
>  
>  /**************************************************************************/
> 

Looks good, but let's make the (new?) dependency of openvpn.c to
platforum.h/c explicit by adding an #include "platform.h".

Trivial enough to do when applying, so ACK.

-Steffan

