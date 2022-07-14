MIME-Version: 1.0
References: <20220707035151.25469-1-selva.nair@...277...>
In-Reply-To: <20220707035151.25469-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 14 Jul 2022 10:52:51 -0400
Message-ID: <CAKuzo_gR7QZUHQaHO-CrL+x+B4hFv=rtGt0_pp2EEuxhA_wB-Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000463a1b05e3c50fe8"
Subject: Re: [Openvpn-devel] [PATCH] Fix crash in xkey-provider in msvc
 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000463a1b05e3c50fe8
Content-Type: text/plain; charset="UTF-8"

Hi,

Any thoughts on this? Apart from the broken msvc builds that led to this,
looks like the right thing to do, isn't it?

Selva

On Wed, Jul 6, 2022 at 11:52 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> The function signature for xkey_load_generic_key had
> function pointers defined as function types that seems
> to work in gcc but not in msvc.
>
> Fix it by changing the function signatures to what was
> intended.
> Also revert part of commit 627d1a3d28638... as that work-
> around should be no longer required.
>
> Reported by: Lev Stipakov https://github.com/lstipakov
>
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/xkey_common.h | 2 +-
>  src/openvpn/xkey_helper.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
> index e0e5ed5b..6d6a1e2c 100644
> --- a/src/openvpn/xkey_common.h
> +++ b/src/openvpn/xkey_common.h
> @@ -152,7 +152,7 @@ xkey_digest(const unsigned char *src, size_t srclen,
> unsigned char *buf,
>   */
>  EVP_PKEY *
>  xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY
> *pubkey,
> -                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn
> free_op);
> +                      XKEY_EXTERNAL_SIGN_fn *sign_op,
> XKEY_PRIVKEY_FREE_fn *free_op);
>
>  extern OSSL_LIB_CTX *tls_libctx; /* Global */
>
> diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
> index 14f074ae..73235fd6 100644
> --- a/src/openvpn/xkey_helper.c
> +++ b/src/openvpn/xkey_helper.c
> @@ -115,7 +115,7 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx,
> EVP_PKEY *pubkey)
>   */
>  EVP_PKEY *
>  xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY
> *pubkey,
> -                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn
> free_op)
> +                      XKEY_EXTERNAL_SIGN_fn *sign_op,
> XKEY_PRIVKEY_FREE_fn *free_op)
>  {
>      EVP_PKEY *pkey = NULL;
>      const char *origin = "external";
> @@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void
> *handle, EVP_PKEY *pubkey,
>          {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
>          {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
>          {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
> -        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void
> *), 0},
> -        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void
> *), 0},
> +        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op,
> sizeof(sign_op), 0},
> +        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op,
> sizeof(free_op), 0},
>          {NULL, 0, NULL, 0, 0}
>      };
>      msg(M_INFO, "%s: handle = %p sign_op = %p free_op = %p ",
> __FUNCTION__,
> --
> 2.30.2
>
>

--000000000000463a1b05e3c50fe8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>Any thoughts on this? Apart f=
rom the broken msvc builds that led to this, looks like the right thing to =
do, isn&#39;t it?<div><br></div><div>Selva</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 6, 2022 at 11:5=
2 PM &lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">se=
lva.nair@...277...</a>&gt;<br>
<br>
The function signature for xkey_load_generic_key had<br>
function pointers defined as function types that seems<br>
to work in gcc but not in msvc.<br>
<br>
Fix it by changing the function signatures to what was<br>
intended.<br>
Also revert part of commit 627d1a3d28638... as that work-<br>
around should be no longer required.<br>
<br>
Reported by: Lev Stipakov <a href=3D"https://github.com/lstipakov" rel=3D"n=
oreferrer" target=3D"_blank">https://github.com/lstipakov</a><br>
<br>
Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." targe=
t=3D"_blank">selva.nair@...277...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/xkey_common.h | 2 +-<br>
=C2=A0src/openvpn/xkey_helper.c | 6 +++---<br>
=C2=A02 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h<br>
index e0e5ed5b..6d6a1e2c 100644<br>
--- a/src/openvpn/xkey_common.h<br>
+++ b/src/openvpn/xkey_common.h<br>
@@ -152,7 +152,7 @@ xkey_digest(const unsigned char *src, size_t srclen, un=
signed char *buf,<br>
=C2=A0 */<br>
=C2=A0EVP_PKEY *<br>
=C2=A0xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *p=
ubkey,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op);<br>
<br>
=C2=A0extern OSSL_LIB_CTX *tls_libctx; /* Global */<br>
<br>
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c<br>
index 14f074ae..73235fd6 100644<br>
--- a/src/openvpn/xkey_helper.c<br>
+++ b/src/openvpn/xkey_helper.c<br>
@@ -115,7 +115,7 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY=
 *pubkey)<br>
=C2=A0 */<br>
=C2=A0EVP_PKEY *<br>
=C2=A0xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *p=
ubkey,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0EVP_PKEY *pkey =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *origin =3D &quot;external&quot;;<br>
@@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handl=
e, EVP_PKEY *pubkey,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;xkey-origin&quot;, OSSL_PARAM_UTF8=
_STRING, (char *) origin, 0, 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;pubkey&quot;, OSSL_PARAM_OCTET_STR=
ING, &amp;pubkey, sizeof(pubkey), 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;handle&quot;, OSSL_PARAM_OCTET_PTR=
, &amp;handle, sizeof(handle), 0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;sign_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;sign_op, sizeof(void *), 0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;free_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;free_op, sizeof(void *), 0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;sign_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;sign_op, sizeof(sign_op), 0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;free_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;free_op, sizeof(free_op), 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{NULL, 0, NULL, 0, 0}<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0msg(M_INFO, &quot;%s: handle =3D %p sign_op =3D %p free=
_op =3D %p &quot;, __FUNCTION__,<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div>

--000000000000463a1b05e3c50fe8--

