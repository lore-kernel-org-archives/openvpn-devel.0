Message-ID: <571937C6.5000102@...1147...>
Date: Thu, 21 Apr 2016 22:27:50 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1461270286-3549-1-git-send-email-janjust@...1147...>
In-Reply-To: <1461270286-3549-1-git-send-email-janjust@...1147...>
Subject: Re: [Openvpn-devel] Add support for pushable encryption.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,


I hope I got my git skills right this time ;)

there are a few notes about this patch:

- I've tested it on Linux only
- it works when pushing both --cipher andi/or --auth
- works by re-doing part of the encryption setup (you'll see some 
messages fly by twice )
- pushing an HMAC (e.g. push "auth SHA256"") does **not** work in 
combination with --tls-auth: when tls-auth is used all incoming packets 
are signed using the "original" HMAC cipher and you won't even get to 
the "push" stage to get the correct cipher.

share and enjoy,

JJK

On 21/04/16 22:24, Jan Just Keijser wrote:
> ---
>   src/openvpn/init.c | 128 +++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 91 insertions(+), 37 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 2beec72..d21a862 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -60,6 +60,13 @@ static struct context *static_context; /* GLOBAL */
>   #define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
>   
>   static void do_init_first_time (struct context *c);
> +static void do_init_buffers(struct context *c);
> +static void do_init_tls_multi(struct context *c, const unsigned int flags, bool packet_id_long_format);
> +static void do_init_frame(struct context *c);
> +static void do_init_frame_tls(struct context *c);
> +static void do_compute_occ_strings(struct context *c);
> +
> +
>   
>   void
>   context_clear (struct context *c)
> @@ -1795,6 +1802,7 @@ pull_permission_mask (const struct context *c)
>       | OPT_P_SHAPER
>       | OPT_P_TIMER
>       | OPT_P_COMP
> +    | OPT_P_CRYPTO
>       | OPT_P_PERSIST
>       | OPT_P_MESSAGES
>       | OPT_P_EXPLICIT_NOTIFY
> @@ -1879,6 +1887,44 @@ do_deferred_options (struct context *c, const unsigned int found)
>       msg (D_PUSH, "OPTIONS IMPORT: environment modified");
>   
>   #ifdef ENABLE_CRYPTO
> +  if (found & OPT_P_CRYPTO)
> +    {
> +      const struct options *options = &c->options;
> +      struct key_type *kt = &c->c1.ks.key_type;
> +      /* Save the old crypto length so that we recalculate the extra frame/mtu parameters c*/
> +      unsigned int old_crypto_length = kt->cipher_length + kt->hmac_length;
> +
> +      msg (D_PUSH, "OPTIONS IMPORT: crypto options modified");
> +
> +      /* Update cipher & hash algorithms */
> +      init_key_type (kt, options->ciphername,
> +                      options->ciphername_defined, options->authname,
> +                      options->authname_defined, options->keysize, true, true);
> +
> +      /* Sanity check on IV, sequence number, and cipher mode options */
> +      check_replay_iv_consistency (kt, options->replay, options->use_iv);
> +
> +      /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
> +      bool packet_id_long_form = cipher_kt_mode_ofb_cfb (kt->cipher);
> +
> +      do_init_tls_multi(c, CF_INIT_TLS_MULTI, packet_id_long_form);
> +
> +      /* Recalculate MTU parameters */
> +      frame_add_to_extra_frame(&c->c2.frame, kt->cipher_length + kt->hmac_length - old_crypto_length);
> +      frame_add_to_link_mtu(&c->c2.frame, kt->cipher_length + kt->hmac_length - old_crypto_length);
> +
> +      do_init_frame_tls(c);
> +
> +      frame_print(&c->c2.frame, M_WARN, "New data channel");
> +      frame_print(&c->c2.tls_multi->opt.frame, M_WARN, "New control channel");
> +
> +      /* Reallocate the context buffers to adjust for the new frame size */
> +      free_context_buffers (c->c2.buffers);
> +      do_init_buffers(c);
> +
> +      do_compute_occ_strings(c);
> +    }
> +
>     if (found & OPT_P_PEER_ID)
>       {
>         msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
> @@ -2222,39 +2268,10 @@ do_init_crypto_tls_c1 (struct context *c)
>   }
>   
>   static void
> -do_init_crypto_tls (struct context *c, const unsigned int flags)
> +do_init_tls_multi(struct context *c, const unsigned int flags, bool packet_id_long_form)
>   {
>     const struct options *options = &c->options;
>     struct tls_options to;
> -  bool packet_id_long_form;
> -
> -  ASSERT (options->tls_server || options->tls_client);
> -  ASSERT (!options->test_crypto);
> -
> -  init_crypto_pre (c, flags);
> -
> -  /* Make sure we are either a TLS client or server but not both */
> -  ASSERT (options->tls_server == !options->tls_client);
> -
> -  /* initialize persistent component */
> -  do_init_crypto_tls_c1 (c);
> -  if (IS_SIG (c))
> -    return;
> -
> -  /* Sanity check on IV, sequence number, and cipher mode options */
> -  check_replay_iv_consistency (&c->c1.ks.key_type, options->replay,
> -			       options->use_iv);
> -
> -  /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
> -  packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
> -
> -  /* Compute MTU parameters */
> -  crypto_adjust_frame_parameters (&c->c2.frame,
> -				  &c->c1.ks.key_type,
> -				  options->ciphername_defined,
> -				  options->use_iv,
> -				  options->replay, packet_id_long_form);
> -  tls_adjust_frame_parameters (&c->c2.frame);
>   
>     /* Set all command-line TLS-related options */
>     CLEAR (to);
> @@ -2279,11 +2296,11 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
>     to.renegotiate_seconds = options->renegotiate_seconds;
>     to.single_session = options->single_session;
>   #ifdef ENABLE_PUSH_PEER_INFO
> -  if (options->push_peer_info)		/* all there is */
> +  if (options->push_peer_info)      /* all there is */
>       to.push_peer_info_detail = 2;
> -  else if (options->pull)		/* pull clients send some details */
> +  else if (options->pull)       /* pull clients send some details */
>       to.push_peer_info_detail = 1;
> -  else					/* default: no peer-info at all */
> +  else                  /* default: no peer-info at all */
>       to.push_peer_info_detail = 0;
>   #endif
>   
> @@ -2342,10 +2359,6 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
>   #endif
>   #endif
>   
> -#ifdef USE_COMP
> -  to.comp_options = options->comp;
> -#endif
> -
>   #if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >= 0x10001000
>     if (options->keying_material_exporter_label)
>       {
> @@ -2387,6 +2400,47 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
>       c->c2.tls_auth_standalone = tls_auth_standalone_init (&to, &c->c2.gc);
>   }
>   
> +
> +
> +static void
> +do_init_crypto_tls (struct context *c, const unsigned int flags)
> +{
> +  const struct options *options = &c->options;
> +  struct tls_options to;
> +  bool packet_id_long_form;
> +
> +  ASSERT (options->tls_server || options->tls_client);
> +  ASSERT (!options->test_crypto);
> +
> +  init_crypto_pre (c, flags);
> +
> +  /* Make sure we are either a TLS client or server but not both */
> +  ASSERT (options->tls_server == !options->tls_client);
> +
> +  /* initialize persistent component */
> +  do_init_crypto_tls_c1 (c);
> +  if (IS_SIG (c))
> +    return;
> +
> +  /* Sanity check on IV, sequence number, and cipher mode options */
> +  check_replay_iv_consistency (&c->c1.ks.key_type, options->replay,
> +			       options->use_iv);
> +
> +  /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
> +  packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
> +
> +  /* Compute MTU parameters */
> +  crypto_adjust_frame_parameters (&c->c2.frame,
> +				  &c->c1.ks.key_type,
> +				  options->ciphername_defined,
> +				  options->use_iv,
> +				  options->replay, packet_id_long_form);
> +  tls_adjust_frame_parameters (&c->c2.frame);
> +
> +  do_init_tls_multi(c, flags, packet_id_long_form);
> +}
> +
> +
>   static void
>   do_init_finalize_tls_frame (struct context *c)
>   {


