MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211029111109.2003101-1-arne@...1227...>
 <20211029111109.2003101-2-arne@...1227...>
 <CAKuzo_iuDVkQb+kbPM1_DNT=hMtgJr9tRyidqp9M1DL9ckYuXQ@...278...>
In-Reply-To: <CAKuzo_iuDVkQb+kbPM1_DNT=hMtgJr9tRyidqp9M1DL9ckYuXQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 30 Oct 2021 15:02:46 -0400
Message-ID: <CAKuzo_j9nmQ6+UXDmQj=0Pu4gCFW3cMpmKJM96NPhQE8iXG-UQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000df5b6e05cf969707"
Subject: [Openvpn-devel] Fwd: [PATCH v4] [OSSL 3.0] Use
 EVP_PKEY_get_group_name to query group name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000df5b6e05cf969707
Content-Type: text/plain; charset="UTF-8"

Somehow I managed to mess-up the reply address with this one. No wonder it
failed to show up in patchwork.
Sending again to the list

---------- Forwarded message ---------
From: Selva Nair <selva.nair@...277...>
Date: Fri, Oct 29, 2021 at 12:06 PM
Subject: Re: [Openvpn-devel] [PATCH v4] [OSSL 3.0] Use
EVP_PKEY_get_group_name to query group name


Hi,

On Fri, Oct 29, 2021 at 8:20 AM Arne Schwabe <arne@...1227...> wrote:

> EC_Key methods are deprecated in OpenSSL 3.0. Use
> EVP_PKEY_get_group_name instead to query the EC group name from an
> EVP_PKEY and add a compatibility function for older OpenSSL versions.
>
> Patch v4: adjust compatibility function and remove accidently included
> fragment
>           of unrelated patch.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/openssl_compat.h | 36 ++++++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    | 14 ++++++++------
>  2 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ce8e2b360..3951d9aca 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -718,4 +718,40 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long
> tls_ver_max)
>      return 1;
>  }
>  #endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L &&
> !defined(ENABLE_CRYPTO_WOLFSSL) */
> +
> +/* Functionality missing in 1.1.1 */
> +#if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC)
> +
> +/* Note that this is not a perfect emulation of the new function but
> + * is good enough for our case of printing certificate details during
> + * handshake */
> +static inline
> +int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
> +                            size_t *gname_len)
> +{
> +    const EC_KEY* ec = EVP_PKEY_get0_EC_KEY(pkey);
> +    if (ec == NULL)
> +    {
> +        return 0;
> +    }
> +    const EC_GROUP* group = EC_KEY_get0_group(ec);
> +    int nid = EC_GROUP_get_curve_name(group);
> +
> +    if (nid == 0)
> +    {
> +        return 0;
> +    }
> +    const char *curve = OBJ_nid2sn(nid);
> +    if (!curve)
> +    {
> +        curve = "(error fetching curve name)";
> +    }
> +
> +    strncpynt(gname, curve, gname_sz);
> +
> +    /* strncpynt ensures null termination so just strlen is fine here */
> +    *gname_len = strlen(curve);
> +    return 1;
> +}
> +#endif
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 6f2d6d57a..25ff50375 100644
> --- a/src/openvpn/ssl_openssl.c
> +++ b/src/openvpn/ssl_openssl.c
> @@ -2053,13 +2053,15 @@ print_cert_details(X509 *cert, char *buf, size_t
> buflen)
>      int typeid = EVP_PKEY_id(pkey);
>
>  #ifndef OPENSSL_NO_EC
> -    if (typeid == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
> +    char groupname[256];
> +    if (typeid == EVP_PKEY_EC)
>      {
> -        const EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> -        const EC_GROUP *group = EC_KEY_get0_group(ec);
> -
> -        int nid = EC_GROUP_get_curve_name(group);
> -        if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
> +        size_t len;
> +        if(EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname),
> &len))
> +        {
> +           curve = groupname;
> +        }
> +        else
>          {
>              curve = "(error getting curve name)";
>          }
>

Acked-by: Selva Nair <selva.nair@...277...>

--000000000000df5b6e05cf969707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Somehow I managed to mess-up the reply address with th=
is one. No wonder it failed to=C2=A0show up in patchwork.<div>Sending again=
 to the list</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">---------- Forwarded message ---------<br>From: <strong cl=
ass=3D"gmail_sendername" dir=3D"auto">Selva Nair</strong> <span dir=3D"auto=
">&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt;<=
/span><br>Date: Fri, Oct 29, 2021 at 12:06 PM<br>Subject: Re: [Openvpn-deve=
l] [PATCH v4] [OSSL 3.0] Use EVP_PKEY_get_group_name to query group name<br=
></div><br><br><div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 29, 2021 at 8:20 AM Arn=
e Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...493...=
1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">EC_Key methods are deprecated in OpenSSL 3.0. Use<br>
EVP_PKEY_get_group_name instead to query the EC group name from an<br>
EVP_PKEY and add a compatibility function for older OpenSSL versions.<br>
<br>
Patch v4: adjust compatibility function and remove accidently included frag=
ment<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of unrelated patch.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/openssl_compat.h | 36 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 | 14 ++++++++------<br>
=C2=A02 files changed, 44 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h<br>
index ce8e2b360..3951d9aca 100644<br>
--- a/src/openvpn/openssl_compat.h<br>
+++ b/src/openvpn/openssl_compat.h<br>
@@ -718,4 +718,40 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_v=
er_max)<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
=C2=A0#endif /* if OPENSSL_VERSION_NUMBER &lt; 0x10100000L &amp;&amp; !defi=
ned(ENABLE_CRYPTO_WOLFSSL) */<br>
+<br>
+/* Functionality missing in 1.1.1 */<br>
+#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(OPENSSL_NO=
_EC)<br>
+<br>
+/* Note that this is not a perfect emulation of the new function but<br>
+ * is good enough for our case of printing certificate details during<br>
+ * handshake */<br>
+static inline<br>
+int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 size_t *gname_len)<br>
+{<br>
+=C2=A0 =C2=A0 const EC_KEY* ec =3D EVP_PKEY_get0_EC_KEY(pkey);<br>
+=C2=A0 =C2=A0 if (ec =3D=3D NULL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 const EC_GROUP* group =3D EC_KEY_get0_group(ec);<br>
+=C2=A0 =C2=A0 int nid =3D EC_GROUP_get_curve_name(group);<br>
+<br>
+=C2=A0 =C2=A0 if (nid =3D=3D 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 const char *curve =3D OBJ_nid2sn(nid);<br>
+=C2=A0 =C2=A0 if (!curve)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 curve =3D &quot;(error fetching curve name)&qu=
ot;;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 strncpynt(gname, curve, gname_sz);<br>
+<br>
+=C2=A0 =C2=A0 /* strncpynt ensures null termination so just strlen is fine=
 here */<br>
+=C2=A0 =C2=A0 *gname_len =3D strlen(curve);<br>
+=C2=A0 =C2=A0 return 1;<br>
+}<br>
+#endif<br>
=C2=A0#endif /* OPENSSL_COMPAT_H_ */<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 6f2d6d57a..25ff50375 100644<br>
--- a/src/openvpn/ssl_openssl.c<br>
+++ b/src/openvpn/ssl_openssl.c<br>
@@ -2053,13 +2053,15 @@ print_cert_details(X509 *cert, char *buf, size_t bu=
flen)<br>
=C2=A0 =C2=A0 =C2=A0int typeid =3D EVP_PKEY_id(pkey);<br>
<br>
=C2=A0#ifndef OPENSSL_NO_EC<br>
-=C2=A0 =C2=A0 if (typeid =3D=3D EVP_PKEY_EC &amp;&amp; EVP_PKEY_get0_EC_KE=
Y(pkey) !=3D NULL)<br>
+=C2=A0 =C2=A0 char groupname[256];<br>
+=C2=A0 =C2=A0 if (typeid =3D=3D EVP_PKEY_EC)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const EC_KEY *ec =3D EVP_PKEY_get0_EC_KEY(pkey=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 const EC_GROUP *group =3D EC_KEY_get0_group(ec=
);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int nid =3D EC_GROUP_get_curve_name(group);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nid =3D=3D 0 || (curve =3D OBJ_nid2sn(nid)=
) =3D=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(EVP_PKEY_get_group_name(pkey, groupname, si=
zeof(groupname), &amp;len))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curve =3D groupname;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curve =3D &quot;(error gett=
ing curve name)&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br></blockquote><div><br></div><div>Ack=
ed-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_bl=
ank">selva.nair@...277...</a>&gt;=C2=A0</div></div></div>
</div></div></div>

--000000000000df5b6e05cf969707--

