Date: Thu, 25 May 2023 17:18:51 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZG98W72xTlY1f0HG@...2685...>
References: <20230509154657.2756-1-gianmarco@...2726...>
 <20230525144045.5484-1-gianmarco@...2726...>
MIME-Version: 1.0
In-Reply-To: <20230525144045.5484-1-gianmarco@...2726...>
Subject: Re: [Openvpn-devel] [PATCH v2] Persist-key: enable persist-key
 option by default.
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, May 25, 2023 at 04:40:46PM +0200, Gianmarco De Gregori wrote:
> This commit changes the default behavior of the OpenVPN
> configuration to enable the persist-key option by default.
> 
> This means that all the key file content will be kept
> in memory throughout the lifetime of the VPN connection.
> 
> Fixes: Trac #1405
> Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
> ---
> Changes from v1:
> * changed "DEPRECATED OPTION" with "**DEPRECATED**" in the documentation
>   and with "(DEPRECATED)" in usage_message().

So I looked into the state of our deprecated options in general,
triggered by your patch. Based on that I have a lot more feedback
this time around ;)

> diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
> index 97e1b5aa..6c23aafc 100644
> --- a/doc/man-sections/generic-options.rst
> +++ b/doc/man-sections/generic-options.rst
> @@ -303,6 +303,8 @@ which mode OpenVPN is configured as.
>    lower priority, ``n`` less than zero is higher priority).
>  
>  --persist-key
> +  **DEPRECATED**, corresponding behavior is now always enabled.
> +
>    Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
>  
>    This option can be combined with ``--user`` to allow restarts

Since the behavior is now always on, we should completely remove the
description and instead check whether other documentation needs to be
adapted. However, documentation should be added to unsupported-options.rst.

Searching for persist-key throughout the documentation and also the sample/
directory shows a lot of references. All of these need to be adapted.

When updating the documentation we might need to make a special note
of the push case. When servers currently push --persist-key then they
may want to continue doing that until all their clients have been
updated to 2.7. So we should be careful when updating the reference in
--push documentation.

[...]
> index e4c596b8..caf45b7e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -275,7 +275,7 @@ static const char usage_message[] =
>      "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart.\n"
>      "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n"
>      "--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-restart.\n"
> -    "--persist-key   : Don't re-read key files across SIGUSR1 or --ping-restart.\n"
> +    "--persist-key   : (DEPRECATED) Don't re-read key files across SIGUSR1 or --ping-restart.\n"

Again, since we completely ignore the option, we should probably just remove this
line completely. DEPRECATED seems more appropriate for options that still do something
but we want to warn about.

>  #if PASSTOS_CAPABILITY
>      "--passtos       : TOS passthrough (applies to IPv4 only).\n"
>  #endif
> @@ -1860,7 +1860,6 @@ show_settings(const struct options *o)
>      SHOW_BOOL(persist_tun);
>      SHOW_BOOL(persist_local_ip);
>      SHOW_BOOL(persist_remote_ip);
> -    SHOW_BOOL(persist_key);
>  
>  #if PASSTOS_CAPABILITY
>      SHOW_BOOL(passtos);
> @@ -3239,18 +3238,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
>          ce->tls_crypt_v2_file_inline = o->tls_crypt_v2_file_inline;
>      }
>  
> -    /* Pre-cache tls-auth/crypt(-v2) key file if persist-key was specified and
> +    /* Pre-cache tls-auth/crypt(-v2) key file if
>       * keys were not already embedded in the config file.
>       */
> -    if (o->persist_key)
> -    {
> -        connection_entry_preload_key(&ce->tls_auth_file,
> -                                     &ce->tls_auth_file_inline, &o->gc);
> -        connection_entry_preload_key(&ce->tls_crypt_file,
> -                                     &ce->tls_crypt_file_inline, &o->gc);
> -        connection_entry_preload_key(&ce->tls_crypt_v2_file,
> -                                     &ce->tls_crypt_v2_file_inline, &o->gc);
> -    }
> +    connection_entry_preload_key(&ce->tls_auth_file,
> +                                 &ce->tls_auth_file_inline, &o->gc);
> +    connection_entry_preload_key(&ce->tls_crypt_file,
> +                                 &ce->tls_crypt_file_inline, &o->gc);
> +    connection_entry_preload_key(&ce->tls_crypt_v2_file,
> +                                 &ce->tls_crypt_v2_file_inline, &o->gc);
> +
>  
>      if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
>      {
> @@ -6938,7 +6935,10 @@ add_option(struct options *options,
>      else if (streq(p[0], "persist-key") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_PERSIST);
> -        options->persist_key = true;
> +        msg(M_WARN, "DEPRECATED: --persist-key option ignored."
> +            "The corresponding behavior will now always be done automatically."

Maybe better: "The corresponding behavior is now always enabled."

> +            "This option will be removed in a future version, "
> +            "please remove it from your configuration.");
>      }
>      else if (streq(p[0], "persist-local-ip") && !p[1])
>      {

Regards,
-- 
  Frank Lichtenheld

