MIME-Version: 1.0
References: <20230110131947.59552-1-frank@...2641...>
In-Reply-To: <20230110131947.59552-1-frank@...2641...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Jan 2023 12:47:17 -0500
Message-ID: <CAKuzo_gG54vnnn125kr4iMseOw_kCfFdgAhCm9DxBeZv1s-4NA@...278...>
Content-Type: multipart/alternative; boundary="00000000000082298705f1ec7aa9"
Subject: Re: [Openvpn-devel] [PATCH] xkey_pkcs11h_sign: fix dangling pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000082298705f1ec7aa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 10, 2023 at 8:21 AM Frank Lichtenheld <frank@...2641...>
wrote:

> Warning by GCC 12:
> pkcs11_openssl.c:237:22: warning:
> dangling pointer =E2=80=98tbs=E2=80=99 to =E2=80=98enc=E2=80=99 may be us=
ed [-Wdangling-pointer=3D]
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  src/openvpn/pkcs11_openssl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
> index 60bc1c47..ecf37ba0 100644
> --- a/src/openvpn/pkcs11_openssl.c
> +++ b/src/openvpn/pkcs11_openssl.c
> @@ -169,6 +169,9 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
>      unsigned char buf[EVP_MAX_MD_SIZE];
>      size_t buflen;
>
> +    unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for
> DigestInfo header */
> +    size_t enc_len =3D sizeof(enc);
> +
>      if (!strcmp(sigalg.op, "DigestSign"))
>      {
>          msg(D_XKEY, "xkey_pkcs11h_sign: computing digest");
> @@ -214,9 +217,6 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
>          {
>              /* CMA_RSA_PKCS needs pkcs1 encoded digest */
>
> -            unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough
> for DigestInfo header */
> -            size_t enc_len =3D sizeof(enc);
> -
>              if (!encode_pkcs1(enc, &enc_len, sigalg.mdname, tbs, tbslen))
>              {
>                  return 0;
>

I can't believe I wrote that nonsense in the first place. Fortunately
similar code in xkey_management_sign() is okay. Hard to catch in tests as
the pointer may still point to the right data after going out of scope
(dangling).

Acked-by: Selva Nair <selva.nair@...277...>

Selva

--00000000000082298705f1ec7aa9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Jan 10, 2023 at 8:21 AM Frank Lichtenheld =
&lt;<a href=3D"mailto:frank@...2641...">frank@...2641...</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Warning by GCC 12:<=
br>
pkcs11_openssl.c:237:22: warning:<br>
dangling pointer =E2=80=98tbs=E2=80=99 to =E2=80=98enc=E2=80=99 may be used=
 [-Wdangling-pointer=3D]<br>
<br>
Signed-off-by: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." ta=
rget=3D"_blank">frank@...2641...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/pkcs11_openssl.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c<br>
index 60bc1c47..ecf37ba0 100644<br>
--- a/src/openvpn/pkcs11_openssl.c<br>
+++ b/src/openvpn/pkcs11_openssl.c<br>
@@ -169,6 +169,9 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,<br>
=C2=A0 =C2=A0 =C2=A0unsigned char buf[EVP_MAX_MD_SIZE];<br>
=C2=A0 =C2=A0 =C2=A0size_t buflen;<br>
<br>
+=C2=A0 =C2=A0 unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough =
for DigestInfo header */<br>
+=C2=A0 =C2=A0 size_t enc_len =3D sizeof(enc);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!strcmp(sigalg.op, &quot;DigestSign&quot;))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_XKEY, &quot;xkey_pkcs11h_sign: comp=
uting digest&quot;);<br>
@@ -214,9 +217,6 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CMA_RSA_PKCS needs pkcs1=
 encoded digest */<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char enc[EVP_MAX_MD_SIZ=
E + 32]; /* 32 bytes enough for DigestInfo header */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t enc_len =3D sizeof(enc);<=
br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!encode_pkcs1(enc, &amp=
;enc_len, sigalg.mdname, tbs, tbslen))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>=
</blockquote><div><br></div><div>I can&#39;t=C2=A0believe I wrote that nons=
ense in the first place. Fortunately similar code in xkey_management_sign()=
 is okay. Hard to catch in tests as the pointer may still point to the righ=
t data after going out of scope (dangling).</div><div><br></div><div>Acked-=
by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...1664...=
7...</a>&gt;</div><div><br></div><div>Selva</div></div></div>

--00000000000082298705f1ec7aa9--

