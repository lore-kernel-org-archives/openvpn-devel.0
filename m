MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-9-arne@...1227...>
In-Reply-To: <20211019183127.614175-9-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 21 Oct 2021 13:52:54 -0400
Message-ID: <CAKuzo_hd3s+T4u19A+_76hb2LuYnuiFAbWtBuXnnxwpcrsemgg@...278...>
Content-Type: multipart/alternative; boundary="0000000000005d9c9a05cee091a9"
Subject: Re: [Openvpn-devel] [PATCH v3 08/21] [OSSL 3.0] Use
 EVP_PKEY_get_group_name to query group name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000005d9c9a05cee091a9
Content-Type: text/plain; charset="UTF-8"

Hi,

I had looked at v1 of this so easy:

On Tue, Oct 19, 2021 at 2:31 PM Arne Schwabe <arne@...1227...> wrote:

> EC_Key methods are deprecated in OpenSSL 3.0. Use
> EVP_PKEY_get_group_name instead to query the EC group name from an
> EVP_PKEY and add a compatibility function for older OpenSSL versions.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/openssl_compat.h | 42 ++++++++++++++++++++++++++++++++++++
>  src/openvpn/ssl_openssl.c    | 14 ++++++------
>  2 files changed, 50 insertions(+), 6 deletions(-)
>
> diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
> index ce8e2b360..dda47d76c 100644
> --- a/src/openvpn/openssl_compat.h
> +++ b/src/openvpn/openssl_compat.h
> @@ -718,4 +718,46 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long
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
>

I would have preferred a  curve !=NULL check here. Though very unlikely to
happen, we do not want a segfault in strncpy.

+
> +    strncpynt(gname, curve, gname_sz);
> +    *gname_len = min_int(strlen(curve), gname_sz);
>

gname_sz - 1 ?

That said, our strncpynt ensures that strlen(curve) will be less than
gname_sz, so this could be just strlen(curve) or left as is.


> +    return 1;
> +}
> +#endif
> +
> +/** Mimics SSL_CTX_new_ex for OpenSSL < 3 */
> +#if OPENSSL_VERSION_NUMBER < 0x30000000L
> +static inline SSL_CTX *
> +SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)
>

This looks like a spill-over from one of my xkey patches --- "git commit
-p" malfunction?

Unless the "unused functions police" objects, we can keep it.

+{
> +    (void) libctx;
> +    (void) propq;
> +    return SSL_CTX_new(method);
> +}
> +#endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
> +
>  #endif /* OPENSSL_COMPAT_H_ */
> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
> index 92d8d0eeb..8ec96e66c 100644
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
>
Looks good otherwise and works as expected.

Selva

--0000000000005d9c9a05cee091a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>I had looked at v1=
 of this so easy:</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Tue, Oct 19, 2021 at 2:31 PM Arne Schwabe &lt;<a =
href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">EC_Key met=
hods are deprecated in OpenSSL 3.0. Use<br>
EVP_PKEY_get_group_name instead to query the EC group name from an<br>
EVP_PKEY and add a compatibility function for older OpenSSL versions.<br>
<br>
Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=
=3D"_blank">arne@...1227...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/openssl_compat.h | 42 +++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0src/openvpn/ssl_openssl.c=C2=A0 =C2=A0 | 14 ++++++------<br>
=C2=A02 files changed, 50 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h<br>
index ce8e2b360..dda47d76c 100644<br>
--- a/src/openvpn/openssl_compat.h<br>
+++ b/src/openvpn/openssl_compat.h<br>
@@ -718,4 +718,46 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_v=
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
+=C2=A0 =C2=A0 const char *curve =3D OBJ_nid2sn(nid);<br></blockquote><div>=
<br></div><div>I would have preferred a=C2=A0 curve !=3DNULL check here. Th=
ough very unlikely to happen, we do not want a segfault in strncpy.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 strncpynt(gname, curve, gname_sz);<br>
+=C2=A0 =C2=A0 *gname_len =3D min_int(strlen(curve), gname_sz);<br></blockq=
uote><div><br></div><div>gname_sz - 1 ?</div><div><br></div><div>That said,=
 our strncpynt ensures that strlen(curve) will be less than gname_sz, so th=
is could be just strlen(curve) or left as is.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 return 1;<br>
+}<br>
+#endif<br>
+<br>
+/** Mimics SSL_CTX_new_ex for OpenSSL &lt; 3 */<br>
+#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L<br>
+static inline SSL_CTX *<br>
+SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)<=
br></blockquote><div><br></div><div>This looks like a spill-over from one o=
f my xkey patches --- &quot;git commit -p&quot; malfunction?=C2=A0</div><di=
v><br></div><div>Unless the &quot;unused functions police&quot; objects, we=
 can keep it.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+{<br>
+=C2=A0 =C2=A0 (void) libctx;<br>
+=C2=A0 =C2=A0 (void) propq;<br>
+=C2=A0 =C2=A0 return SSL_CTX_new(method);<br>
+}<br>
+#endif /* OPENSSL_VERSION_NUMBER &lt; 0x30000000L */<br>
+<br>
=C2=A0#endif /* OPENSSL_COMPAT_H_ */<br>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c<br>
index 92d8d0eeb..8ec96e66c 100644<br>
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
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br><br></blockquote><div><br></div><div=
>Looks good otherwise and works as expected.</div><div><br></div><div>Selva=
</div></div></div>

--0000000000005d9c9a05cee091a9--

