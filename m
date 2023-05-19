MIME-Version: 1.0
References: <20230517110230.2234266-1-arne@...1227...>
 <20230517110230.2234266-2-arne@...1227...>
In-Reply-To: <20230517110230.2234266-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 May 2023 09:45:11 -0400
Message-ID: <CAKuzo_jQ6nCjWr-jCEUTvZKJC=XSdNrGx=jK+vguLuVd4eRkLA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003ba36505fc0c22da"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix CR_RESPONSE mangaement message
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

--0000000000003ba36505fc0c22da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While this bugfix should be merged, I'm a conflicted about the way these
two patches are split up. It just makes reviewing harder than it should be.
They actually form two independent changes but with one half intersecting
with the other for no reason.

On Wed, May 17, 2023 at 7:03=E2=80=AFAM Arne Schwabe <arne@...1227...> wrot=
e:

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

     verify_crresponse_plugin(c->c2.tls_multi, m);
>

I think, this patch could end here the bugfix is complete without the need
for 1/2.

The rest of the patch depends on 1/2, but is not required for the above. It
could be combined with 1/2 and submitted as a follow up refactoring patch.


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
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 4c78c2b2c..567f55ea3 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1279,6 +1279,11 @@ tls_authenticate_key(struct tls_multi *multi, const
> unsigned int mda_key_id, con
>          {
>              ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
>          }
> +        else
> +        {
> +            msg(D_TLS_DEBUG_LOW, "%s: no key state found for management
> key id "
> +                "%d", __func__, mda_key_id);
> +        }
>      }
>      return (bool) ks;
>  }


 Selva

--0000000000003ba36505fc0c22da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>While this bugfix should be m=
erged, I&#39;m a conflicted about the way these two patches are split up. I=
t just makes reviewing harder than it should be. They actually form two ind=
ependent changes but with one half intersecting with the other for no reaso=
n.<div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, May 17, 2023 at 7:03=E2=80=AFAM Arne Schwabe &lt;<a href=3D"mailto=
:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">the management interface expects the manag=
ement key id instead<br>
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
=C2=A0#if ENABLE_PLUGIN=C2=A0</blockquote><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0verify_crresponse_plugin(c-&gt;c2.tls_multi, m);<br></b=
lockquote><div><br></div><div>I think, this patch could end here the bugfix=
 is complete without the need for 1/2.=C2=A0</div><div><br></div><div>The r=
est of the patch depends on 1/2, but is not required for the above. It coul=
d be combined with 1/2 and submitted as a follow up refactoring patch.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c<br>
index 4c78c2b2c..567f55ea3 100644<br>
--- a/src/openvpn/ssl_verify.c<br>
+++ b/src/openvpn/ssl_verify.c<br>
@@ -1279,6 +1279,11 @@ tls_authenticate_key(struct tls_multi *multi, const =
unsigned int mda_key_id, con<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ks-&gt;mda_status =3D auth =
? ACF_SUCCEEDED : ACF_FAILED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TLS_DEBUG_LOW, &quot;%s: n=
o key state found for management key id &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%d&quot;, __=
func__, mda_key_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return (bool) ks;<br>
=C2=A0}</blockquote><div><br></div><div>=C2=A0Selva</div></div></div></div>

--0000000000003ba36505fc0c22da--

