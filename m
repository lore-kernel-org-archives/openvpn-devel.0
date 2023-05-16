MIME-Version: 1.0
References: <20230516163401.2101274-1-arne@...1227...>
In-Reply-To: <20230516163401.2101274-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 May 2023 14:30:03 -0400
Message-ID: <CAKuzo_ivUz1CEiqRPENFYo1gOwHs=JxNp2yVOpH7D_-K-Ut4iA@...278...>
Content-Type: multipart/alternative; boundary="000000000000704e0c05fbd3c39f"
Subject: Re: [Openvpn-devel] [PATCH] Fix CR_RESPONSE mangaement message
 using wrong key_id
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

--000000000000704e0c05fbd3c39f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is this dependent on some patch not yet merged? See missing context below.

On Tue, May 16, 2023 at 12:36=E2=80=AFPM Arne Schwabe <arne@...1227...> wro=
te:

> the management interface expects the management key id instead
> of the openvpn key id. In the past they often were the same for low ids
> which hid the bug quite well.
>
> Also do not pick uninitialised keystates (management key_id is not valid
> in these) and provide better logging when a key state is not found.
>
> Change-Id: If9fa1165a0e886b570b3738546ed810a32367cbe
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/push.c       | 4 ++--
>  src/openvpn/ssl_common.h | 2 +-
>  src/openvpn/ssl_verify.c | 5 +++++
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 54e53f6aa..99abe5440 100644
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
>

ssl_common.h in master (and 2.6) has only 725 lines and no function by that
name. Am I missing something?

Selva

--000000000000704e0c05fbd3c39f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>Is this dependent on some pat=
ch not yet merged? See missing context below.<div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 16, 2023 at 12:36=
=E2=80=AFPM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_=
blank">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">the management interface expects the management key i=
d instead<br>
of the openvpn key id. In the past they often were the same for low ids<br>
which hid the bug quite well.<br>
<br>
Also do not pick uninitialised keystates (management key_id is not valid<br>
in these) and provide better logging when a key state is not found.<br>
<br>
Change-Id: If9fa1165a0e886b570b3738546ed810a32367cbe<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/push.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0src/openvpn/ssl_common.h | 2 +-<br>
=C2=A0src/openvpn/ssl_verify.c | 5 +++++<br>
=C2=A03 files changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/push.c b/src/openvpn/push.c<br>
index 54e53f6aa..99abe5440 100644<br>
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
nsigned int mda_key_id)<br></blockquote><div><br></div><div>ssl_common.h in=
 master (and 2.6) has only 725 lines and no function by that name. Am I mis=
sing something?</div><div><br></div><div>Selva=C2=A0</div></div></div></div>

--000000000000704e0c05fbd3c39f--

