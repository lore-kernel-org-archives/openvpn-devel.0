References: <20200416113930.15192-1-arne@...1227...>
 <20200416113930.15192-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0588bf73-7553-773c-536f-34e61a7153db@...2181...>
Date: Fri, 17 Apr 2020 16:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <20200416113930.15192-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Minor style change to improve
 code style
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/04/2020 13:39, Arne Schwabe wrote:
> These are small manual changes that are done to improve the code
> style and also make the result of uncrustify better without mixing
> manual changes/automatic changes into a single commit.
> 
> - Make prototype and function identical for gc_addspecial. Also fixes
>   uncrustify misparsing the embedded function pointer decleration
> - Disallow uncrustify to reformat link_socket_init_phase1, which it
>   messes up
> - Format the the parameters of a call of  mbedtls_ssl_tls_prf to
>   be more inline with the rest of our function calls with multiple
>   arguments
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

[CUT]

> -
> +/* *INDENT-OFF* uncrustify misparses this function declarion because of
> + * embedded #if/#endif tell it to skip this section */
>  void
>  link_socket_init_phase1(struct link_socket *sock,
>                          const char *local_host,
> @@ -327,6 +328,7 @@ link_socket_init_phase1(struct link_socket *sock,
>                          int mark,
>                          struct event_timeout *server_poll_timeout,
>                          unsigned int sockflags);
> +/* Reenable uncrustify *INDENT-ON* */

I hate the idea that we have to live with these markers in the code, but
it seems the most reasonable option for now.

Later on we should better refactor this function, because if it's
confusing for the parser...it means it's confusing -period-

>  
>  void link_socket_init_phase2(struct link_socket *sock,
>                               const struct frame *frame,
> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> index 4f194ad7..d585111b 100644
> --- a/src/openvpn/ssl_mbedtls.c
> +++ b/src/openvpn/ssl_mbedtls.c
> @@ -209,10 +209,10 @@ int mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
>      memcpy(client_server_random + 32, server_random, 32);
>  
>      const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
> -    int ret = mbedtls_ssl_tls_prf(
> -            tls_prf_type, ms, ms_len, session->opt->ekm_label,
> -            client_server_random, sizeof(client_server_random),
> -            ks_ssl->exported_key_material, session->opt->ekm_size);
> +    int ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
> +                                  session->opt->ekm_label, client_server_random,
> +                                  sizeof(client_server_random), ks_ssl->exported_key_material,
> +                                  session->opt->ekm_size);
>  
>      if (!mbed_ok(ret))
>      {
> 


Other than that it looks good!

Acked-by: Antonio Quartulli <antonio@...515...>

(I am no sure this can be merged without 1/3 applied, but I am acking
anyway)

Regards,

-- 
Antonio Quartulli

