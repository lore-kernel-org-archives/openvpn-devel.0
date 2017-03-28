References: <1485290304-12292-1-git-send-email-steffan@...1856...>
	<1487344823-8125-1-git-send-email-steffan@...1856...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <840322ea-3118-c2ba-9b08-765758634f0e@...1435...>
Date: Tue, 28 Mar 2017 10:08:33 +0200
MIME-Version: 1.0
In-Reply-To: <1487344823-8125-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Allow changing cipher from a ccd file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 17-02-17 16:20, Steffan Karger wrote:
> As described in msg  <374a7eb7-f539-5231-623b-41f208ed856e@...1823...> on
> openvpn-devel@lists.sourceforge.net, clients that are compiled with
> --disable-occ (included in --enable-small) won't send an options string.
> Without the options string, the 2.4 server doesn't know which cipher to
> use for poor man's NCP.
> 
> This patch allows working around that issue by allowing the 'cipher'
> directive to be used in --client-config-dir files.  That way, a server
> admin can add ccd files to specify per-client which cipher to use.
> 
> Because the ccd files are read after where we would normally generate keys,
> this patch delays key generation for non-NCP p2mp servers until after
> reading the ccd file.
> 
> Trac: #845
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: postpone p2mp non-NCP key generation, such that setting cipher in
>     a ccd file for a non-NCP client actually works.
> 
>  src/openvpn/multi.c   | 14 ++++++++++++++
>  src/openvpn/options.c |  2 +-
>  src/openvpn/options.h |  2 +-
>  src/openvpn/ssl.c     |  9 ++++-----
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 56009b7..4c81e9a 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2086,6 +2086,20 @@ script_failed:
>              mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
>          }
>  
> +        /* Generate tunnel keys, unless IV_NCP >= 2 is negotiated. The first key
> +         * generation is then postponed until after the pull/push, so we can
> +         * process pushed cipher directives.
> +         */
> +        struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
> +        struct key_state *ks = &session->key[KS_PRIMARY];
> +        if (!session->opt->ncp_enabled && ks->authenticated
> +            && !tls_session_update_crypto_params(session, &mi->context.options,
> +                                                 &mi->context.c2.frame))
> +        {
> +            msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
> +            cc_succeeded = false;
> +        }
> +
>          /* set flag so we don't get called again */
>          mi->connection_established_flag = true;
>  
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index dde1f48..0e6b393 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7536,7 +7536,7 @@ add_option(struct options *options,
>      }
>      else if (streq(p[0], "cipher") && p[1] && !p[2])
>      {
> -        VERIFY_PERMISSION(OPT_P_NCP);
> +        VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>          options->ciphername = p[1];
>      }
>      else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index a14f2ab..f4f0226 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -628,7 +628,7 @@ struct options
>  #define OPT_P_MTU             (1<<14) /* TODO */
>  #define OPT_P_NICE            (1<<15)
>  #define OPT_P_PUSH            (1<<16)
> -#define OPT_P_INSTANCE        (1<<17)
> +#define OPT_P_INSTANCE        (1<<17) /**< Allow usage in ccd file */
>  #define OPT_P_CONFIG          (1<<18)
>  #define OPT_P_EXPLICIT_NOTIFY (1<<19)
>  #define OPT_P_ECHO            (1<<20)
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 8c724cb..1479c77 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2401,12 +2401,11 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
>      }
>  
>      /* Generate tunnel keys if we're a TLS server.
> -     * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
> -     * generation is postponed until after the pull/push, so we can process pushed
> -     * cipher directives.
> +     * If we're a p2mp server, the first key generation is postponed so we can
> +     * switch cipher during the connection setup phase.
>       */
> -    if (session->opt->server && !(session->opt->ncp_enabled
> -                                  && session->opt->mode == MODE_SERVER && ks->key_id <= 0))
> +    if (session->opt->server
> +        && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
>      {
>          if (ks->authenticated)
>          {
> 

This patch seems to work for the reporter from #845:
https://community.openvpn.net/openvpn/ticket/845#comment:5

-Steffan

(Yes, this is a shameless bump to trick people into reviewing this patch
;-) )

