Date: Mon, 23 May 2022 10:40:54 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2106092351.245143.1653295254227@...2642...>
In-Reply-To: <20220520213250.3126372-5-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-5-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 4/4] Allow scripts and plugins to set
 a custom AUTH_FAILED message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

> Arne Schwabe <arne@...1227...> hat am 20.05.2022 23:32 geschrieben:
> This is currently only possible when using the management interface
> and the client-deny functionality.
> ---
>  src/openvpn/ssl_common.h |  1 +
>  src/openvpn/ssl_verify.c | 74 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 73 insertions(+), 2 deletions(-)
> 
[...]
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index c01841fa9..4cf772fef 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
[...]
> @@ -1184,6 +1218,20 @@ tls_authentication_status(struct tls_multi *multi)
>  #endif
>      if (failed_auth)
>      {
> +        struct gc_arena gc = gc_new();
> +        const struct key_state *ks = get_primary_key(multi);
> +        const char *plugin_message = key_state_check_auth_failed_message_file(&ks->plugin_auth, multi, &gc);
> +        const char *script_message = key_state_check_auth_failed_message_file(&ks->script_auth, multi, &gc);
> +
> +        if (plugin_message)
> +        {
> +            auth_set_client_reason(multi, plugin_message);
> +        }
> +        if (script_message)
> +        {
> +            auth_set_client_reason(multi, script_message);
> +        }
> +

Isn't there a gc_free missing here?

>          /* We have at least one session that failed authentication. There
>           * might be still another session with valid keys.
>           * Although our protocol allows keeping the VPN session alive
> @@ -1248,6 +1296,21 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
>   * this is the place to start.
>   *************************************************************************** */
>  
> +/**
> + * Check if the script/plugin left a message in the auth failed message
> + * file and rely it to the user */

"relay"

> +static void
> +check_for_client_reason(struct tls_multi *multi,
> +                        struct auth_deferred_status *status)
> +{
> +    struct gc_arena gc = gc_new();
> +    const char *msg = key_state_check_auth_failed_message_file(status, multi, &gc);
> +    if (msg)
> +    {
> +        auth_set_client_reason(multi, msg);
> +    }
> +    gc_free(&gc);
> +}
>  /*
>   * Verify the user name and password using a script
>   */

Regards,
--
Frank Lichtenheld

