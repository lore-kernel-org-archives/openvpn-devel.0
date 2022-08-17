Message-ID: <956745e3-7958-6c6d-eada-d686bd1adec7@...2181...>
Date: Thu, 18 Aug 2022 00:52:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220817210857.1558-1-timo@...2669...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220817210857.1558-1-timo@...2669...>
Subject: Re: [Openvpn-devel] [PATCH] dco: turn platform config checks into
 separate function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Timo Rothenpieler <timo@...2669...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/08/2022 23:08, Timo Rothenpieler wrote:
> All the checks in there are only relevant during startup, and
> specifically the capability check might cause issues when checking a CCD
> config later at runtime.
> 
> So move them to their own function and call it only during startup.

simple enough and does what we discussed on IRC.
Should we require platform specific option check on pushed options, then 
we can re-introduce the _platform() variant again.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/dco.c     |  9 ++-------
>   src/openvpn/dco.h     | 18 ++++++++++++++++++
>   src/openvpn/options.c |  3 ++-
>   3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index f21997de..9eb2685c 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -222,8 +222,8 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
>       }
>   }
>   
> -static bool
> -dco_check_option_conflict_platform(int msglevel, const struct options *o)
> +bool
> +dco_check_startup_option_conflict(int msglevel, const struct options *o)
>   {
>   #if defined(TARGET_LINUX)
>       /* if the device name is fixed, we need to check if an interface with this
> @@ -327,11 +327,6 @@ dco_check_option_conflict(int msglevel, const struct options *o)
>           return false;
>       }
>   
> -    if (!dco_check_option_conflict_platform(msglevel, o))
> -    {
> -        return false;
> -    }
> -
>       if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
>       {
>           msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
> diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
> index 6b5c016a..e296cf27 100644
> --- a/src/openvpn/dco.h
> +++ b/src/openvpn/dco.h
> @@ -69,6 +69,18 @@ bool dco_available(int msglevel);
>    */
>   bool dco_check_option_conflict(int msglevel, const struct options *o);
>   
> +/**
> + * Check whether the options struct has any further option that is not supported
> + * by our current dco implementation during early startup.
> + * If so print a warning at warning level for the first conflicting option
> + * found and return false.
> + *
> + * @param msglevel  the msg level to use to print the warnings
> + * @param o         the options struct that hold the options
> + * @return          true if no conflict was detected, false otherwise
> + */
> +bool dco_check_startup_option_conflict(int msglevel, const struct options *o);
> +
>   /**
>    * Check whether any of the options pushed by the server is not supported by
>    * our current dco implementation. If so print a warning at warning level
> @@ -236,6 +248,12 @@ dco_check_option_conflict(int msglevel, const struct options *o)
>       return false;
>   }
>   
> +static inline bool
> +dco_check_startup_option_conflict(int msglevel, const struct options *o)
> +{
> +    return false;
> +}
> +
>   static inline bool
>   dco_check_pull_options(int msglevel, const struct options *o)
>   {
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index bd6db826..2415c1a8 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3671,7 +3671,8 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
>   
>       /* check if any option should force disabling DCO */
>   #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
> -    o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
> +    o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o)
> +                                    || !dco_check_startup_option_conflict(D_DCO, o);
>   #endif
>   
>       if (dco_enabled(o) && o->dev_node)

-- 
Antonio Quartulli

