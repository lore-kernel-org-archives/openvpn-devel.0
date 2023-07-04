MIME-Version: 1.0
References: <20230517110230.2234266-1-arne@...1227...>
 <20230522101138.2842378-1-arne@...1227...>
 <20230522101138.2842378-2-arne@...1227...>
In-Reply-To: <20230522101138.2842378-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 4 Jul 2023 11:15:58 -0400
Message-ID: <CAKuzo_gsqkNx2=TWTCuxNs42pmW8GvobqBqhhid42sx=fEmX9w@...278...>
Content-Type: multipart/alternative; boundary="00000000000091db1b05ffaac352"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Fix CR_RESPONSE mangaement
 message using wrong key_id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000091db1b05ffaac352
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems I missed to send this ACK to the list.. Here it is.

On Mon, May 22, 2023 at 6:12=E2=80=AFAM Arne Schwabe <arne@...1227...> wrot=
e:

> the management interface expects the management key id instead
> of the openvpn key id. In the past they often were the same for low ids
> which hid the bug quite well.
>
> Also do not pick uninitialised keystates (management key_id is not valid
> in these).
>
> Patch v2: do not add logging
>
> Change-Id: If9fa1165a0e886b570b3738546ed810a32367cbe
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/push.c       | 4 ++--
>  src/openvpn/ssl_common.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 8e9627199..8f0a534ac 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -267,9 +267,9 @@ receive_cr_response(struct context *c, const struct
> buffer *buffer)
>      struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACTIVE];
>      struct man_def_auth_context *mda =3D session->opt->mda_context;
>      struct env_set *es =3D session->opt->es;
> -    int key_id =3D get_primary_key(c->c2.tls_multi)->key_id;
> +    unsigned int mda_key_id =3D
> get_primary_key(c->c2.tls_multi)->mda_key_id;
>
> -    management_notify_client_cr_response(key_id, mda, es, m);
> +    management_notify_client_cr_response(mda_key_id, mda, es, m);
>  #endif
>  #if ENABLE_PLUGIN
>      verify_crresponse_plugin(c->c2.tls_multi, m);
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index ebfd25432..be0f18746 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -733,7 +733,7 @@ get_key_by_management_key_id(struct tls_multi *multi,
> unsigned int mda_key_id)
>      for (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
>      {
>          struct key_state *ks =3D get_key_scan(multi, i);
> -        if (ks->mda_key_id =3D=3D mda_key_id)
> +        if (ks->mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
>          {
>              return ks;
>          }
> --
> 2.39.2 (Apple Git-143)
>
>

Acked-by Selva Nair <selva.nair@...277...>

--00000000000091db1b05ffaac352
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It seems I missed to send this ACK to the list.. Here=
 it is.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, May 22, 2023 at 6:12=E2=80=AFAM Arne Schwabe &lt;<a href=3D"=
mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">the management int=
erface expects the management key id instead<br>
of the openvpn key id. In the past they often were the same for low ids<br>
which hid the bug quite well.<br>
<br>
Also do not pick uninitialised keystates (management key_id is not valid<br>
in these).<br>
<br>
Patch v2: do not add logging<br>
<br>
Change-Id: If9fa1165a0e886b570b3738546ed810a32367cbe<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/push.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0src/openvpn/ssl_common.h | 2 +-<br>
=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/push.c b/src/openvpn/push.c<br>
index 8e9627199..8f0a534ac 100644<br>
--- a/src/openvpn/push.c<br>
+++ b/src/openvpn/push.c<br>
@@ -267,9 +267,9 @@ receive_cr_response(struct context *c, const struct buf=
fer *buffer)<br>
=C2=A0 =C2=A0 =C2=A0struct tls_session *session =3D &amp;c-&gt;c2.tls_multi=
-&gt;session[TM_ACTIVE];<br>
=C2=A0 =C2=A0 =C2=A0struct man_def_auth_context *mda =3D session-&gt;opt-&g=
t;mda_context;<br>
=C2=A0 =C2=A0 =C2=A0struct env_set *es =3D session-&gt;opt-&gt;es;<br>
-=C2=A0 =C2=A0 int key_id =3D get_primary_key(c-&gt;c2.tls_multi)-&gt;key_i=
d;<br>
+=C2=A0 =C2=A0 unsigned int mda_key_id =3D get_primary_key(c-&gt;c2.tls_mul=
ti)-&gt;mda_key_id;<br>
<br>
-=C2=A0 =C2=A0 management_notify_client_cr_response(key_id, mda, es, m);<br>
+=C2=A0 =C2=A0 management_notify_client_cr_response(mda_key_id, mda, es, m)=
;<br>
=C2=A0#endif<br>
=C2=A0#if ENABLE_PLUGIN<br>
=C2=A0 =C2=A0 =C2=A0verify_crresponse_plugin(c-&gt;c2.tls_multi, m);<br>
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h<br>
index ebfd25432..be0f18746 100644<br>
--- a/src/openvpn/ssl_common.h<br>
+++ b/src/openvpn/ssl_common.h<br>
@@ -733,7 +733,7 @@ get_key_by_management_key_id(struct tls_multi *multi, u=
nsigned int mda_key_id)<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct key_state *ks =3D get_key_scan(mul=
ti, i);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ks-&gt;mda_key_id =3D=3D mda_key_id)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ks-&gt;mda_key_id =3D=3D mda_key_id &amp;&=
amp; ks-&gt;state &gt; S_UNDEF)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ks;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.39.2 (Apple Git-143)<br>
<br></blockquote><div><br></div><div><br></div><div>Acked-by Selva Nair &lt=
;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1664...=
7...</a>&gt;</div></div></div>

--00000000000091db1b05ffaac352--

