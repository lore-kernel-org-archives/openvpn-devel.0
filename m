MIME-Version: 1.0
In-Reply-To: <20170713033848.11902-1-a@...2181...>
References: <20170713033848.11902-1-a@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 13 Jul 2017 11:02:11 +0500
Message-ID: <CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
Content-Type: multipart/alternative; boundary="001a11442fce787e9805542cacf9"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, ValdikSS <valdikss@...277...>

--001a11442fce787e9805542cacf9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should we add --disable-multi to some travis-ci build ?

13 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 8:41 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Antonio Quartulli" <a@...2181...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> Due to the introduction of the options.pull attribute and the
> ncp logic, various parts of the code try to access members
> that are not available when --disable-multi is selected.
>
> Avoid such issue by placing several "#if P2MP" around the
> faulty code.
>
> Introduced-by: 598e03f0e7bc ("Always push basic set of peer info values to
> server.")
> Reported-by: ValdikSS <valdikss@...277...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/init.c    | 23 ++++++++++++++++++++++-
>  src/openvpn/options.c |  4 +++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index a54307ad..1105f081 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2150,6 +2150,7 @@ do_deferred_options(struct context *c, const
> unsigned int found)
>      }
>
>      /* process (potentially pushed) crypto options */
> +#if P2MP
>      if (c->options.pull)
>      {
>          struct tls_session *session =3D &c->c2.tls_multi->session[TM_
> ACTIVE];
> @@ -2169,6 +2170,7 @@ do_deferred_options(struct context *c, const
> unsigned int found)
>              return false;
>          }
>      }
> +#endif
>  #endif /* ifdef ENABLE_CRYPTO */
>      return true;
>  }
> @@ -2498,9 +2500,11 @@ do_init_crypto_tls_c1(struct context *c)
>                                 options->tls_crypt_inline,
> options->tls_server);
>          }
>
> +#if P2MP
>          c->c1.ciphername =3D options->ciphername;
>          c->c1.authname =3D options->authname;
>          c->c1.keysize =3D options->keysize;
> +#endif
>
>  #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code
> will break restarts */
>          if (options->priv_key_file_inline)
> @@ -2514,10 +2518,12 @@ do_init_crypto_tls_c1(struct context *c)
>      {
>          msg(D_INIT_MEDIUM, "Re-using SSL/TLS context");
>
> +#if P2MP
>          /* Restore pre-NCP cipher options */
>          c->options.ciphername =3D c->c1.ciphername;
>          c->options.authname =3D c->c1.authname;
>          c->options.keysize =3D c->c1.keysize;
> +#endif
>      }
>  }
>
> @@ -2549,6 +2555,7 @@ do_init_crypto_tls(struct context *c, const unsigned
> int flags)
>      /* In short form, unique datagram identifier is 32 bits, in long form
> 64 bits */
>      packet_id_long_form =3D cipher_kt_mode_ofb_cfb(c->c1.
> ks.key_type.cipher);
>
> +#if P2MP
>      /* Compute MTU parameters (postpone if we push/pull options) */
>      if (c->options.pull || c->options.mode =3D=3D MODE_SERVER)
>      {
> @@ -2556,6 +2563,7 @@ do_init_crypto_tls(struct context *c, const unsigned
> int flags)
>          frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());
>      }
>      else
> +#endif
>      {
>          crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
>                                         options->replay,
> packet_id_long_form);
> @@ -2584,8 +2592,10 @@ do_init_crypto_tls(struct context *c, const
> unsigned int flags)
>      to.replay_window =3D options->replay_window;
>      to.replay_time =3D options->replay_time;
>      to.tcp_mode =3D link_socket_proto_connection_
> oriented(options->ce.proto);
> +#if P2MP
>      to.config_ciphername =3D c->c1.ciphername;
>      to.config_authname =3D c->c1.authname;
> +#endif
>      to.ncp_enabled =3D options->ncp_enabled;
>      to.transition_window =3D options->transition_window;
>      to.handshake_window =3D options->handshake_window;
> @@ -2595,6 +2605,7 @@ do_init_crypto_tls(struct context *c, const unsigned
> int flags)
>      to.renegotiate_seconds =3D options->renegotiate_seconds;
>      to.single_session =3D options->single_session;
>      to.mode =3D options->mode;
> +#if P2MP
>      to.pull =3D options->pull;
>  #ifdef ENABLE_PUSH_PEER_INFO
>      if (options->push_peer_info)        /* all there is */
> @@ -2610,6 +2621,7 @@ do_init_crypto_tls(struct context *c, const unsigned
> int flags)
>          to.push_peer_info_detail =3D 0;
>      }
>  #endif
> +#endif
>
>      /* should we not xmit any packets until we get an initial
>       * response from client? */
> @@ -3698,7 +3710,14 @@ management_callback_network_change(void *arg, bool
> samenetwork)
>      }
>
>      socketfd =3D c->c2.link_socket->sd;
> -    if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
> +
> +    bool pull =3D false;
> +
> +#if P2MP
> +    pull =3D c->options.pull;
> +#endif
> +
> +    if (!pull || c->c2.tls_multi->use_peer_id || samenetwork)
>      {
>          return socketfd;
>      }
> @@ -4260,11 +4279,13 @@ inherit_context_child(struct context *dest,
>      dest->c1.ks.ssl_ctx =3D src->c1.ks.ssl_ctx;
>      dest->c1.ks.tls_wrap_key =3D src->c1.ks.tls_wrap_key;
>      dest->c1.ks.tls_auth_key_type =3D src->c1.ks.tls_auth_key_type;
> +#if P2MP
>      /* inherit pre-NCP ciphers */
>      dest->c1.ciphername =3D src->c1.ciphername;
>      dest->c1.authname =3D src->c1.authname;
>      dest->c1.keysize =3D src->c1.keysize;
>  #endif
> +#endif
>
>      /* options */
>      dest->options =3D src->options;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 505c5b2e..9f1eb3ff 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3006,6 +3006,7 @@ options_postprocess_mutate(struct options *o)
>          }
>      }
>
> +#if P2MP
>      /* cipher negotiation (NCP) currently assumes --pull or --mode server
> */
>      if (o->ncp_enabled
>          && !(o->pull || o->mode =3D=3D MODE_SERVER) )
> @@ -3015,6 +3016,7 @@ options_postprocess_mutate(struct options *o)
>          o->ncp_enabled =3D false;
>      }
>  #endif
> +#endif
>
>  #if ENABLE_MANAGEMENT
>      if (o->http_proxy_override)
> @@ -3442,7 +3444,7 @@ static size_t
>  calc_options_string_link_mtu(const struct options *o, const struct frame
> *frame)
>  {
>      size_t link_mtu =3D EXPANDED_SIZE(frame);
> -#ifdef ENABLE_CRYPTO
> +#if defined(ENABLE_CRYPTO) && P2MP
>      if (o->pull || o->mode =3D=3D MODE_SERVER)
>      {
>          struct frame fake_frame =3D *frame;
> --
> 2.13.2
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11442fce787e9805542cacf9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Should we add --disable-multi to some travis-ci build ?</=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">13 =D0=B8=D1=
=8E=D0=BB. 2017 =D0=B3. 8:41 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Antonio Quartulli&quot; &lt;a@...2181...&=
gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Due to the introduction of the options.pull att=
ribute and the<br>
ncp logic, various parts of the code try to access members<br>
that are not available when --disable-multi is selected.<br>
<br>
Avoid such issue by placing several &quot;#if P2MP&quot; around the<br>
faulty code.<br>
<br>
Introduced-by: 598e03f0e7bc (&quot;Always push basic set of peer info value=
s to server.&quot;)<br>
Reported-by: ValdikSS &lt;<a href=3D"mailto:valdikss@...277...">valdikss@...1186...=
.277...</a>&gt;<br>
Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>
---<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 | 23 ++++++++++++++++++++++-<br>
=C2=A0src/openvpn/options.c |=C2=A0 4 +++-<br>
=C2=A02 files changed, 25 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index a54307ad..1105f081 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -2150,6 +2150,7 @@ do_deferred_options(struct context *c, const unsigned=
 int found)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* process (potentially pushed) crypto options */<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0if (c-&gt;options.pull)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tls_session *session =3D &amp;c-&g=
t;c2.tls_multi-&gt;session[TM_<wbr>ACTIVE];<br>
@@ -2169,6 +2170,7 @@ do_deferred_options(struct context *c, const unsigned=
 int found)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#endif<br>
=C2=A0#endif /* ifdef ENABLE_CRYPTO */<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -2498,9 +2500,11 @@ do_init_crypto_tls_c1(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-&gt;tls_crypt_inline, option=
s-&gt;tls_server);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.ciphername =3D options-&gt;ciphe=
rname;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.authname =3D options-&gt;authnam=
e;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c1.keysize =3D options-&gt;keysize;=
<br>
+#endif<br>
<br>
=C2=A0#if 0 /* was: #if ENABLE_INLINE_FILES --=C2=A0 Note that enabling thi=
s code will break restarts */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;priv_key_file_<wbr>inline=
)<br>
@@ -2514,10 +2518,12 @@ do_init_crypto_tls_c1(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_INIT_MEDIUM, &quot;Re-using SSL/TLS=
 context&quot;);<br>
<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Restore pre-NCP cipher options */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.ciphername =3D c-&gt;c1.cip=
hername;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.authname =3D c-&gt;c1.authn=
ame;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;options.keysize =3D c-&gt;c1.keysiz=
e;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -2549,6 +2555,7 @@ do_init_crypto_tls(struct context *c, const unsigned =
int flags)<br>
=C2=A0 =C2=A0 =C2=A0/* In short form, unique datagram identifier is 32 bits=
, in long form 64 bits */<br>
=C2=A0 =C2=A0 =C2=A0packet_id_long_form =3D cipher_kt_mode_ofb_cfb(c-&gt;c1=
.<wbr>ks.key_type.cipher);<br>
<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0/* Compute MTU parameters (postpone if we push/pull opt=
ions) */<br>
=C2=A0 =C2=A0 =C2=A0if (c-&gt;options.pull || c-&gt;options.mode =3D=3D MOD=
E_SERVER)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -2556,6 +2563,7 @@ do_init_crypto_tls(struct context *c, const unsigned =
int flags)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0frame_add_to_extra_frame(&amp;c-&gt;<wbr>=
c2.frame, crypto_max_overhead());<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_adjust_frame_<wbr>parameters(&amp;=
c-&gt;c2.frame, &amp;c-&gt;c1.ks.key_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 options-=
&gt;replay, packet_id_long_form);<br>
@@ -2584,8 +2592,10 @@ do_init_crypto_tls(struct context *c, const unsigned=
 int flags)<br>
=C2=A0 =C2=A0 =C2=A0to.replay_window =3D options-&gt;replay_window;<br>
=C2=A0 =C2=A0 =C2=A0to.replay_time =3D options-&gt;replay_time;<br>
=C2=A0 =C2=A0 =C2=A0to.tcp_mode =3D link_socket_proto_connection_<wbr>orien=
ted(options-&gt;ce.proto);<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0to.config_ciphername =3D c-&gt;c1.ciphername;<br>
=C2=A0 =C2=A0 =C2=A0to.config_authname =3D c-&gt;c1.authname;<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0to.ncp_enabled =3D options-&gt;ncp_enabled;<br>
=C2=A0 =C2=A0 =C2=A0to.transition_window =3D options-&gt;transition_window;=
<br>
=C2=A0 =C2=A0 =C2=A0to.handshake_window =3D options-&gt;handshake_window;<b=
r>
@@ -2595,6 +2605,7 @@ do_init_crypto_tls(struct context *c, const unsigned =
int flags)<br>
=C2=A0 =C2=A0 =C2=A0to.renegotiate_seconds =3D options-&gt;renegotiate_seco=
nds;<br>
=C2=A0 =C2=A0 =C2=A0to.single_session =3D options-&gt;single_session;<br>
=C2=A0 =C2=A0 =C2=A0to.mode =3D options-&gt;mode;<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0to.pull =3D options-&gt;pull;<br>
=C2=A0#ifdef ENABLE_PUSH_PEER_INFO<br>
=C2=A0 =C2=A0 =C2=A0if (options-&gt;push_peer_info)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* all there is */<br>
@@ -2610,6 +2621,7 @@ do_init_crypto_tls(struct context *c, const unsigned =
int flags)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to.push_peer_info_detail =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* should we not xmit any packets until we get an initi=
al<br>
=C2=A0 =C2=A0 =C2=A0 * response from client? */<br>
@@ -3698,7 +3710,14 @@ management_callback_network_<wbr>change(void *arg, b=
ool samenetwork)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0socketfd =3D c-&gt;c2.link_socket-&gt;sd;<br>
-=C2=A0 =C2=A0 if (!c-&gt;options.pull || c-&gt;c2.tls_multi-&gt;use_peer_i=
d || samenetwork)<br>
+<br>
+=C2=A0 =C2=A0 bool pull =3D false;<br>
+<br>
+#if P2MP<br>
+=C2=A0 =C2=A0 pull =3D c-&gt;options.pull;<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 if (!pull || c-&gt;c2.tls_multi-&gt;use_peer_id || samenetwo=
rk)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return socketfd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -4260,11 +4279,13 @@ inherit_context_child(struct context *dest,<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.ks.ssl_ctx =3D src-&gt;c1.ks.ssl_ctx;<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.ks.tls_wrap_key =3D src-&gt;c1.ks.tls_wrap_=
key;<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.ks.tls_auth_key_type =3D src-&gt;c1.ks.tls_=
auth_key_type;<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0/* inherit pre-NCP ciphers */<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.ciphername =3D src-&gt;c1.ciphername;<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.authname =3D src-&gt;c1.authname;<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;c1.keysize =3D src-&gt;c1.keysize;<br>
=C2=A0#endif<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* options */<br>
=C2=A0 =C2=A0 =C2=A0dest-&gt;options =3D src-&gt;options;<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 505c5b2e..9f1eb3ff 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -3006,6 +3006,7 @@ options_postprocess_mutate(<wbr>struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#if P2MP<br>
=C2=A0 =C2=A0 =C2=A0/* cipher negotiation (NCP) currently assumes --pull or=
 --mode server */<br>
=C2=A0 =C2=A0 =C2=A0if (o-&gt;ncp_enabled<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; !(o-&gt;pull || o-&gt;mode =3D=
=3D MODE_SERVER) )<br>
@@ -3015,6 +3016,7 @@ options_postprocess_mutate(<wbr>struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;ncp_enabled =3D false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
+#endif<br>
<br>
=C2=A0#if ENABLE_MANAGEMENT<br>
=C2=A0 =C2=A0 =C2=A0if (o-&gt;http_proxy_override)<br>
@@ -3442,7 +3444,7 @@ static size_t<br>
=C2=A0calc_options_string_link_mtu(<wbr>const struct options *o, const stru=
ct frame *frame)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t link_mtu =3D EXPANDED_SIZE(frame);<br>
-#ifdef ENABLE_CRYPTO<br>
+#if defined(ENABLE_CRYPTO) &amp;&amp; P2MP<br>
=C2=A0 =C2=A0 =C2=A0if (o-&gt;pull || o-&gt;mode =3D=3D MODE_SERVER)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct frame fake_frame =3D *frame;<br>
--<br>
2.13.2<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div></div>

--001a11442fce787e9805542cacf9--

