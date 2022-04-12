Date: Tue, 12 Apr 2022 12:33:50 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2078542256.353074.1649759630031@...2642...>
In-Reply-To: <20220411133528.27279-1-a@...2181...>
References: <20220402070902.30282-5-a@...2181...>
 <20220411133528.27279-1-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 4/7] ovpn-dco: introduce linux
 data-channel offload support
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Honestly still not sure one would start reviewing the actual code but here
are at least a few minor things I noticed while browsing through it:

> Antonio Quartulli <a@...2181...> hat am 11.04.2022 15:35 geschrieben:
> 
>  
> Implement the data-channel offloading using the ovpn-dco kernel
> module. See README.dco.md for more details.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Changes from v1:
> * uncrustified code. Note that uncrustify wanted to change way more
>   code in our repo, therefore I had to dig into the proposed changes and
>   pick only those related to this patch. For this reason I may have
>   missed something.

You also incorporated my review suggestions.

[...]
> diff --git a/README.dco.md b/README.dco.md
> new file mode 100644
> index 00000000..e73e0fc2
> --- /dev/null
> +++ b/README.dco.md
[...}
> +DCO and P2P mode
> +----------------
> +DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
> +The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
> +overall routing and behave more like a "dumb" tunnel like GRE.
> +
> +However, DCO requires DATA_V2 to be enabled. This requires P2P with NCP capability, which
> +is only available in OpenVPN 2.6 and later.

Changes.rst doesn't mention this change, should it?
Should we mention here what "NCP" stands for?

> +OpenVPN prints a diagnostic message for the P2P NCP result when running in P2P mode:
> +
> +    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 9484735, cipher=AES-256-GCM
> +
> +Double check that your have `DATA_v2=1` in your output and a supported AEAD cipher
> +(AES-XXX-GCM or CHACHA20POLY1305).
[...]
> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
> index 5157c561..6019aefe 100644
> --- a/doc/man-sections/advanced-options.rst
> +++ b/doc/man-sections/advanced-options.rst
> @@ -91,3 +91,16 @@ used when debugging or testing out special usage scenarios.
>    *(Linux only)* Set the TX queue length on the TUN/TAP interface.
>    Currently defaults to operating system default.
>  
> +--disable-dco
> +  Disables the opportunistic use of the data channel offloading if available.

Nitpick: would remove "the" in "the data channel offloading".

[...]
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 9e10f64e..7e49d710 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -845,6 +845,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
>               cipher_kt_iv_size(kt->cipher));
>          warn_insecure_key_type(ciphername);
>      }
> +

Spurious uncrustify change?

>      if (md_defined(kt->digest))
>      {
>          ctx->hmac = hmac_ctx_new();
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> new file mode 100644
> index 00000000..2f7779f6
> --- /dev/null
> +++ b/src/openvpn/dco.c
[...]
> +/**
> + * Find a usable key that is not the primary (i.e. the secondary key)
> + *
> + * @param multi     The TLS struct to retrieve keys from
> + * @param primary   The primary key that should be skipped doring the scan

"during"

[...]
> +static bool
> +dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
> +{
> +    if (ce->fragment)
> +    {
> +        msg(msglevel, "Note: --fragment disables data channel offload.");
> +        return true;
> +    }
> +
> +    if (ce->http_proxy_options)
> +    {
> +        msg(msglevel, "Note: --http-proxy disables data channel offload.");
> +        return true;
> +    }
> +
> +    if (ce->socks_proxy_server)
> +    {
> +        msg(msglevel, "Note --socks-proxy disable data channel offload.");

"Note: --socks-proxy disables data channel offload."

Missing ':' after "Note" and missing 's' in "disables".

> +        return true;
> +    }
> +
> +    return false;
> +}
[...]
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> new file mode 100644
> index 00000000..6c670950
> --- /dev/null
> +++ b/src/openvpn/dco_linux.c
[...]
> +/**
> + * @brief resolves the netlink ID for ovpn-dco
> + *
> + * This function queries the kernel via a netlink socket
> + * whether the ovpn-dco netlink namespace is available
> + *
> + * This function can be used to determine if the kernel
> + * support DCO offloading.

"supports"

> + *
> + * @return ID on success, negative error code on error
> + */
> +static int
> +resolve_ovpn_netlink_id(int msglevel)
[...]
> +/**
> + * Send a preprared netlink message and registers cb as callback if non-null.
> + *
> + * The method will also free nl_msg
> + * @param dco       The dco context to use
> + * @param nl_msg    the message to use
> + * @param cb        An optional callback if the caller expects an answers\

"an answer", also spurious '\'

> + * @param prefix    A prefix to report in the error message to give the user context
> + * @return          status of sending the message
> + */
> +static int
> +ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
> +                 const char *prefix)
> +{
> +    dco->status = 1;
> +
> +    if (cb)
> +    {
> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
> +    }
> +    else
> +    {
> +        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, NULL, dco);
> +    }

Is there an actual difference to just writing

nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);

without the whole if/else?

> +    nl_send_auto(dco->nl_sock, nl_msg);
> +
> +    while (dco->status == 1)
> +    {
> +        ovpn_nl_recvmsgs(dco, prefix);
> +    }
> +
> +    if (dco->status < 0)
> +    {
> +        msg(M_INFO, "%s: failed to send netlink message: %s (%d)",
> +            prefix, strerror(-dco->status), dco->status);
> +    }
> +
> +    return dco->status;
> +}
> +
> +struct sockaddr *
> +mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
> +{
> +    struct sockaddr_in6 *sock6 = ((struct sockaddr_in6 *)sock);
> +    if (sock->sa_family == AF_INET6
> +        && memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff", 12)==0)

magic constant?

> +    {
> +
> +        struct sockaddr_in *sock4;
> +        ALLOC_OBJ_CLEAR_GC(sock4, struct sockaddr_in, gc);
> +        memcpy(&sock4->sin_addr, sock6->sin6_addr.s6_addr +12, 4);
> +        sock4->sin_port = sock6->sin6_port;
> +        sock4->sin_family = AF_INET;
> +        return (struct sockaddr *) sock4;
> +    }
> +    return sock;
> +}
[...]

Regards,
--
Frank Lichtenheld

