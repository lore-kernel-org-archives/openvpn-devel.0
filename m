Date: Wed, 14 Sep 2022 17:59:00 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyH6RL7q13+juVuJ@...2685...>
References: <Yx5JdRcEXh2tTqPE@...1296...>
 <20220912091057.752-1-lstipakov@...277...>
MIME-Version: 1.0
In-Reply-To: <20220912091057.752-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use DCO on Windows by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

So, to be more specific about the suggested changes

On Mon, Sep 12, 2022 at 12:10:57PM +0300, Lev Stipakov wrote:
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2e567571..2a379f94 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -183,7 +183,7 @@ static const char usage_message[] =
>      "                  does not begin with \"tun\" or \"tap\".\n"
>      "--dev-node node : Explicitly set the device node rather than using\n"
>      "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
> -#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
> +#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32))

As Antonio said, here the part after the && is redundant with ENABLE_DCO now.

>      "--disable-dco   : Do not attempt using Data Channel Offload.\n"
>  #endif
>      "--lladdr hw     : Set the link layer address of the tap device.\n"
> @@ -851,7 +851,7 @@ init_options(struct options *o, const bool init_gc)
>      o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
>      o->route_method = ROUTE_METHOD_ADAPTIVE;
>      o->block_outside_dns = false;
> -    o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
> +    o->windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
>  #endif
>      o->vlan_accept = VLAN_ALL;
>      o->vlan_pvid = 1;
> @@ -903,6 +903,10 @@ init_options(struct options *o, const bool init_gc)
>      }
>  #endif /* _WIN32 */
>      o->allow_recursive_routing = false;
> +
> +#if !defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32))

Here I would definitely say it would be better to just always have a disable_dco in tuntap_options
instead of limiting this to platforms that have DCO.

> +    o->tuntap_options.disable_dco = true;
> +#endif /* !defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)) */
>  }
>  
>  void
> @@ -3606,8 +3610,6 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
>      options_set_backwards_compatible_options(o);
>  
>      options_postprocess_cipher(o);
> -    options_postprocess_mutate_invariant(o);
> -
>      o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
>      if (o->ncp_ciphers == NULL)
>      {
> @@ -3683,18 +3685,31 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
>              "incompatible with each other.");
>      }
>  
> -#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
> -    /* check if any option should force disabling DCO */
> -    o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
> -                                    || !dco_check_startup_option(D_DCO, o);
> -#elif defined(_WIN32)
> -    /* in Windows we have no 'fallback to non-DCO' strategy, so if a conflicting
> -     * option is found, we simply bail out by means of M_USAGE
> -     */
> +#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)

Here the #if seems redundant with dco_enabled, which will already return false
if ENABLE_DCO is not set.

> +    if (dco_enabled(o))
> +    {
> +        /* check if any option should force disabling DCO */
> +        o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
> +                                        || !dco_check_startup_option(D_DCO, o);
> +    }
> +#endif
> +
> +#ifdef _WIN32
>      if (dco_enabled(o))
>      {
> -        dco_check_option(M_USAGE, o);
> -        dco_check_startup_option(M_USAGE, o);
> +        o->windows_driver = WINDOWS_DRIVER_DCO;
> +    }
> +    else
> +    {
> +        if (o->windows_driver == WINDOWS_DRIVER_DCO)
> +        {
> +            msg(M_WARN, "Option --windows-driver ovpn-dco is ignored because Data Channel Offload is disabled");
> +            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
> +        }
> +        else if (o->windows_driver == WINDOWS_DRIVER_UNSPECIFIED)
> +        {
> +            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
> +        }
>      }
>  #endif
>  
> @@ -3705,6 +3720,9 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
>          o->dev_node = NULL;
>      }
>  
> +    /* this depends on o->windows_driver, which is set above */
> +    options_postprocess_mutate_invariant(o);
> +
>      /*
>       * Save certain parms before modifying options during connect, especially
>       * when using --pull
> @@ -5903,7 +5921,7 @@ add_option(struct options *options,
>  #endif
>      else if (streq(p[0], "disable-dco"))
>      {
> -#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
> +#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)

Again, no need to limit this by platform.

>          options->tuntap_options.disable_dco = true;
>  #endif
>      }
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 6d9174a4..557054ba 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -882,9 +882,7 @@ bool key_is_external(const struct options *options);
>  static inline bool
>  dco_enabled(const struct options *o)
>  {
> -#if defined(_WIN32)
> -    return o->windows_driver == WINDOWS_DRIVER_DCO;
> -#elif defined(ENABLE_DCO)
> +#if defined(ENABLE_DCO)
>      return !o->tuntap_options.disable_dco;
>  #else
>      return false;

BTW, you can't see it in the diff, but there is a wrong
#endif /* defined(_WIN32) */
now immediately afterwards. I wonder why uncrustify didn't
complain?

Regards,
-- 
  Frank Lichtenheld

