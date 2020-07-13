References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-10-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <dcf564a2-6b2b-e841-71bf-51b07fb77a99@...277...>
Date: Mon, 13 Jul 2020 14:16:02 +0100
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-10-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v5 10/14] client-connect: Move adding
 inotify watch into its own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


On 11/07/2020 10:36, Arne Schwabe wrote:
> This make the code a bit better readable and also prepares resuing

resuing -> reusing

(Don't ask me why this is not re-using, which is how I would probably 
spell it and my teacher would laugh at me)

Grammar:
This make the code more readable


> the function for client-connect return files
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/multi.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 271d09d8..dafc85f1 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2828,6 +2828,32 @@ multi_schedule_context_wakeup(struct multi_context *m, struct multi_instance *mi
>                          compute_wakeup_sigma(&mi->context.c2.timeval));
>   }
>   
> +#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
> +static void
> +add_inotify_file_watch(struct multi_context *m, struct multi_instance *mi,
> +                       int inotify_fd, const char *file)
> +{
> +    /* watch acf file */
> +    long watch_descriptor = inotify_add_watch(inotify_fd, file,
> +                                              IN_CLOSE_WRITE | IN_ONESHOT);
> +    if (watch_descriptor >= 0)
> +    {
> +        if (mi->inotify_watch != -1)
> +        {
> +            hash_remove(m->inotify_watchers,
> +                        (void *) (unsigned long)mi->inotify_watch);
> +        }
> +        hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor,
> +                 mi, true);
> +        mi->inotify_watch = watch_descriptor;
> +    }
> +    else
> +    {
> +        msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
> +    }
> +}
> +#endif /* if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH) */
> +
>   /*
>    * Figure instance-specific timers, convert
>    * earliest to absolute time in mi->wakeup,
> @@ -2865,21 +2891,8 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
>           if (ks && ks->auth_control_file && was_unauthenticated
>               && (ks->authenticated == KS_AUTH_DEFERRED))
>           {
> -            /* watch acf file */
> -            long watch_descriptor = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);
> -            if (watch_descriptor >= 0)
> -            {
> -                if (mi->inotify_watch != -1)
> -                {
> -                    hash_remove(m->inotify_watchers, (void *) (unsigned long)mi->inotify_watch);
> -                }
> -                hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor, mi, true);
> -                mi->inotify_watch = watch_descriptor;
> -            }
> -            else
> -            {
> -                msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
> -            }
> +            add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
> +                                   ks->auth_control_file);
>           }
>   #endif
>   
> 

