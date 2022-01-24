MIME-Version: 1.0
References: <20220121052259.508-1-lstipakov@...277...>
 <20220121052259.508-2-lstipakov@...277...>
In-Reply-To: <20220121052259.508-2-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 Jan 2022 16:41:41 -0500
Message-ID: <CAKuzo_hVuU2yZHpmaaGO3+2C=Z6MLaJLcydQfw3x+RD+G9d5BA@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a8d9205d65ad6d1"
Subject: Re: [Openvpn-devel] [PATCH 1/2] xkey: fix msvc build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000008a8d9205d65ad6d1
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 24, 2022 at 2:22 PM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
>  - use sizeof(void *) since msvc doesn't support sizeof of function ptr
>

This is not just an msvc problem, but signals a bigger issue it seems. In
retrospect, passing function pointers  pickled this was probably a bad
design decision on my part though we are forced by OpenSSL 3's design of
using OSSL_PARAMs to pass data to providers.

For now, The proposed fix (i.e., to use void*) looks okay to me especially
since its handled like a normal pointer during key import. But we may have
to find a better way for passing these function pointers if this comes back
to bite us.


>
>  - use XKEY_PROV_PROPS macro instead of props since msvc
>   requires constant expression in aggregate initializers
>

Makes sense.


> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/xkey_helper.c   |  4 ++--
>  src/openvpn/xkey_provider.c | 13 +++++--------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
> index c667f7be..50231335 100644
> --- a/src/openvpn/xkey_helper.c
> +++ b/src/openvpn/xkey_helper.c
> @@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void
> *handle, EVP_PKEY *pubkey,
>          {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
>          {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
>          {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
> -        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op,
> sizeof(sign_op), 0},
> -        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op,
> sizeof(free_op), 0},
> +        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void
> *), 0},
> +        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void
> *), 0},
>          {NULL, 0, NULL, 0, 0}};
>
>      /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from
> pubkey */
> diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
> index c2d560c5..115b9931 100644
> --- a/src/openvpn/xkey_provider.c
> +++ b/src/openvpn/xkey_provider.c
> @@ -44,9 +44,6 @@
>  #include <openssl/evp.h>
>  #include <openssl/err.h>
>
> -/* propq set all on all ops we implement */
> -static const char *const props = XKEY_PROV_PROPS;
> -
>  /* A descriptive name */
>  static const char *provname = "OpenVPN External Key Provider";
>
> @@ -592,9 +589,9 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] = {
>  };
>
>  const OSSL_ALGORITHM keymgmts[] = {
> -    {"RSA:rsaEncryption", props, rsa_keymgmt_functions, "OpenVPN xkey RSA
> Key Manager"},
> -    {"RSA-PSS:RSASSA-PSS", props, rsa_keymgmt_functions, "OpenVPN xkey
> RSA-PSS Key Manager"},
> -    {"EC:id-ecPublicKey", props, ec_keymgmt_functions, "OpenVPN xkey EC
> Key Manager"},
> +    {"RSA:rsaEncryption", XKEY_PROV_PROPS, rsa_keymgmt_functions,
> "OpenVPN xkey RSA Key Manager"},
> +    {"RSA-PSS:RSASSA-PSS", XKEY_PROV_PROPS, rsa_keymgmt_functions,
> "OpenVPN xkey RSA-PSS Key Manager"},
> +    {"EC:id-ecPublicKey", XKEY_PROV_PROPS, ec_keymgmt_functions, "OpenVPN
> xkey EC Key Manager"},
>      {NULL, NULL, NULL, NULL}
>  };
>
> @@ -1074,8 +1071,8 @@ static const OSSL_DISPATCH signature_functions[] = {
>  };
>
>  const OSSL_ALGORITHM signatures[] = {
> -    {"RSA:rsaEncryption", props, signature_functions, "OpenVPN xkey RSA
> Signature"},
> -    {"ECDSA", props, signature_functions, "OpenVPN xkey ECDSA Signature"},
> +    {"RSA:rsaEncryption", XKEY_PROV_PROPS, signature_functions, "OpenVPN
> xkey RSA Signature"},
> +    {"ECDSA", XKEY_PROV_PROPS, signature_functions, "OpenVPN xkey ECDSA
> Signature"},
>      {NULL, NULL, NULL, NULL}
>  };


Acked-by: Selva Nair <selva.nair@...277...>

--0000000000008a8d9205d65ad6d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 24, 2022 at 2:22 PM Lev S=
tipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipa=
kov@...277...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=
=3D"_blank">lev@...515...</a>&gt;<br>
<br>
=C2=A0- use sizeof(void *) since msvc doesn&#39;t support sizeof of functio=
n ptr<br></blockquote><div><br></div><div>This is not just an msvc problem,=
 but signals a bigger issue it seems. In retrospect, passing function point=
ers=C2=A0 pickled this was probably a bad design decision on my part though=
 we are forced by OpenSSL 3&#39;s design of using OSSL_PARAMs to pass data =
to providers.</div><div><br></div><div>For now, The proposed fix (i.e., to =
use void*) looks okay to me especially since its=C2=A0handled like a normal=
 pointer=C2=A0during key import. But we may have to find a better way for p=
assing these function pointers if this comes back to bite us.<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0- use XKEY_PROV_PROPS macro instead of props since msvc<br>
=C2=A0 requires constant expression in aggregate initializers<br></blockquo=
te><div><br></div><div>Makes sense.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/xkey_helper.c=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0src/openvpn/xkey_provider.c | 13 +++++--------<br>
=C2=A02 files changed, 7 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c<br>
index c667f7be..50231335 100644<br>
--- a/src/openvpn/xkey_helper.c<br>
+++ b/src/openvpn/xkey_helper.c<br>
@@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handl=
e, EVP_PKEY *pubkey,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;xkey-origin&quot;, OSSL_PARAM_UTF8=
_STRING, (char *) origin, 0, 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;pubkey&quot;, OSSL_PARAM_OCTET_STR=
ING, &amp;pubkey, sizeof(pubkey), 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;handle&quot;, OSSL_PARAM_OCTET_PTR=
, &amp;handle, sizeof(handle), 0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;sign_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;sign_op, sizeof(sign_op), 0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;free_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;free_op, sizeof(free_op), 0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;sign_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;sign_op, sizeof(void *), 0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {&quot;free_op&quot;, OSSL_PARAM_OCTET_PTR, (v=
oid **) &amp;free_op, sizeof(void *), 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{NULL, 0, NULL, 0, 0}};<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Do not use EVP_PKEY_new_from_pkey as that will take =
keymgmt from pubkey */<br>
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c<br>
index c2d560c5..115b9931 100644<br>
--- a/src/openvpn/xkey_provider.c<br>
+++ b/src/openvpn/xkey_provider.c<br>
@@ -44,9 +44,6 @@<br>
=C2=A0#include &lt;openssl/evp.h&gt;<br>
=C2=A0#include &lt;openssl/err.h&gt;<br>
<br>
-/* propq set all on all ops we implement */<br>
-static const char *const props =3D XKEY_PROV_PROPS;<br>
-<br>
=C2=A0/* A descriptive name */<br>
=C2=A0static const char *provname =3D &quot;OpenVPN External Key Provider&q=
uot;;<br>
<br>
@@ -592,9 +589,9 @@ static const OSSL_DISPATCH ec_keymgmt_functions[] =3D {=
<br>
=C2=A0};<br>
<br>
=C2=A0const OSSL_ALGORITHM keymgmts[] =3D {<br>
-=C2=A0 =C2=A0 {&quot;RSA:rsaEncryption&quot;, props, rsa_keymgmt_functions=
, &quot;OpenVPN xkey RSA Key Manager&quot;},<br>
-=C2=A0 =C2=A0 {&quot;RSA-PSS:RSASSA-PSS&quot;, props, rsa_keymgmt_function=
s, &quot;OpenVPN xkey RSA-PSS Key Manager&quot;},<br>
-=C2=A0 =C2=A0 {&quot;EC:id-ecPublicKey&quot;, props, ec_keymgmt_functions,=
 &quot;OpenVPN xkey EC Key Manager&quot;},<br>
+=C2=A0 =C2=A0 {&quot;RSA:rsaEncryption&quot;, XKEY_PROV_PROPS, rsa_keymgmt=
_functions, &quot;OpenVPN xkey RSA Key Manager&quot;},<br>
+=C2=A0 =C2=A0 {&quot;RSA-PSS:RSASSA-PSS&quot;, XKEY_PROV_PROPS, rsa_keymgm=
t_functions, &quot;OpenVPN xkey RSA-PSS Key Manager&quot;},<br>
+=C2=A0 =C2=A0 {&quot;EC:id-ecPublicKey&quot;, XKEY_PROV_PROPS, ec_keymgmt_=
functions, &quot;OpenVPN xkey EC Key Manager&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{NULL, NULL, NULL, NULL}<br>
=C2=A0};<br>
<br>
@@ -1074,8 +1071,8 @@ static const OSSL_DISPATCH signature_functions[] =3D =
{<br>
=C2=A0};<br>
<br>
=C2=A0const OSSL_ALGORITHM signatures[] =3D {<br>
-=C2=A0 =C2=A0 {&quot;RSA:rsaEncryption&quot;, props, signature_functions, =
&quot;OpenVPN xkey RSA Signature&quot;},<br>
-=C2=A0 =C2=A0 {&quot;ECDSA&quot;, props, signature_functions, &quot;OpenVP=
N xkey ECDSA Signature&quot;},<br>
+=C2=A0 =C2=A0 {&quot;RSA:rsaEncryption&quot;, XKEY_PROV_PROPS, signature_f=
unctions, &quot;OpenVPN xkey RSA Signature&quot;},<br>
+=C2=A0 =C2=A0 {&quot;ECDSA&quot;, XKEY_PROV_PROPS, signature_functions, &q=
uot;OpenVPN xkey ECDSA Signature&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{NULL, NULL, NULL, NULL}<br>
=C2=A0};=C2=A0</blockquote><div>=C2=A0</div><div>Acked-by: Selva Nair &lt;<=
a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1354...=
..</a>&gt;</div></div></div>

--0000000000008a8d9205d65ad6d1--

