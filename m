References: <87375t6qas.fsf@...2274...>
 <20171105094641.55673-1-jca@...2272...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <fb62dc46-7e48-4db4-dd92-e7f831080132@...1856...>
Date: Fri, 10 Nov 2017 12:31:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171105094641.55673-1-jca@...2272...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Use long long to format time_t-related
 environment variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 05-11-17 10:46, Jeremie Courreges-Anglas wrote:
> Signed-off-by: Jeremie Courreges-Anglas <jca@...2272...>
> ---
>  src/openvpn/misc.c    | 4 ++--
>  src/openvpn/misc.h    | 2 +-
>  src/openvpn/multi.c   | 7 ++-----
>  src/openvpn/options.c | 2 +-
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 8c7f6116..001fe1c4 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -553,10 +553,10 @@ setenv_int(struct env_set *es, const char *name, int value)
>  }
>  
>  void
> -setenv_unsigned(struct env_set *es, const char *name, unsigned int value)
> +setenv_long_long(struct env_set *es, const char *name, long long value)
>  {
>      char buf[64];
> -    openvpn_snprintf(buf, sizeof(buf), "%u", value);
> +    openvpn_snprintf(buf, sizeof(buf), "%lld", value);
>      setenv_str(es, name, buf);
>  }
>  
> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
> index eb39ce3f..f6c810a2 100644
> --- a/src/openvpn/misc.h
> +++ b/src/openvpn/misc.h
> @@ -98,7 +98,7 @@ void setenv_counter(struct env_set *es, const char *name, counter_type value);
>  
>  void setenv_int(struct env_set *es, const char *name, int value);
>  
> -void setenv_unsigned(struct env_set *es, const char *name, unsigned int value);
> +void setenv_long_long(struct env_set *es, const char *name, long long value);
>  
>  void setenv_str(struct env_set *es, const char *name, const char *value);
>  
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 4545bce1..82a0b9d9 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -565,10 +565,7 @@ multi_client_disconnect_setenv(struct multi_context *m,
>      setenv_stats(&mi->context);
>  
>      /* setenv connection duration */
> -    {
> -        const unsigned int duration = (unsigned int) now - mi->created;
> -        setenv_unsigned(mi->context.c2.es, "time_duration", duration);
> -    }
> +    setenv_long_long(mi->context.c2.es, "time_duration", now - mi->created);
>  }
>  
>  static void
> @@ -1769,7 +1766,7 @@ multi_client_connect_setenv(struct multi_context *m,
>      {
>          const char *created_ascii = time_string(mi->created, 0, false, &gc);
>          setenv_str(mi->context.c2.es, "time_ascii", created_ascii);
> -        setenv_unsigned(mi->context.c2.es, "time_unix", (unsigned int)mi->created);
> +        setenv_long_long(mi->context.c2.es, "time_unix", mi->created);
>      }
>  
>      gc_free(&gc);
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 7aa311aa..641a26e2 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -990,7 +990,7 @@ setenv_settings(struct env_set *es, const struct options *o)
>      setenv_int(es, "verb", o->verbosity);
>      setenv_int(es, "daemon", o->daemon);
>      setenv_int(es, "daemon_log_redirect", o->log);
> -    setenv_unsigned(es, "daemon_start_time", time(NULL));
> +    setenv_long_long(es, "daemon_start_time", time(NULL));
>      setenv_int(es, "daemon_pid", platform_getpid());
>  
>      if (o->connection_list)
> 

Change makes sense and patch looks good.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

