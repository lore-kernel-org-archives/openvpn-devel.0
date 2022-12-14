MIME-Version: 1.0
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <20221211200108.1402-1-marc.becker@...2704...>
In-Reply-To: <20221211200108.1402-1-marc.becker@...2704...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 10:48:40 -0500
Message-ID: <CAKuzo_j2z7uh+r3xkseApXW74NNYh-tiMv7dAVLmy2+D5y6K8A@...278...>
Content-Type: multipart/alternative; boundary="00000000000099cc7d05efcbac41"
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] special handling for PKCS11
 providers on win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marc Becker <marc.becker@...2704...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000099cc7d05efcbac41
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Dec 11, 2022 at 3:01 PM Marc Becker via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

> Change win32 dynamic loader behavior when supplying an absolute path.
> The DLL location is considered/preferred to resolve dependencies.
> Support in pkcs11-helper for loader flag is detected at compile time.
>
> 3rd party DLLs and additional dependencies do no longer need to be moved
> to the OpenVPN directory or require changes to %PATH% configuration.
>
> Signed-off-by: Marc Becker <marc.becker@...2704...>
> ---
>  src/openvpn/pkcs11.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index b74ac8f4..aa027337 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -420,6 +420,13 @@ pkcs11_addProvider(
>          {
>              rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_is_private,
> sizeof(cert_is_private));
>          }
> +#if defined(WIN32) && defined(PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS)
> +        if (rv == CKR_OK && platform_absolute_pathname(provider))
> +        {
> +            unsigned loader_flags = LOAD_LIBRARY_SEARCH_DEFAULT_DIRS |
> LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR;
> +            rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS, &loader_flags,
> sizeof(loader_flags));
> +        }
> +#endif
>
>          if (rv != CKR_OK || (rv = pkcs11h_initializeProvider(provider))
> != CKR_OK)
>          {
>

This requires a proposed change to pkcs11-helper which I believe will be
merged upstream -- Alon has closed the PR with a positive remark which
usually means change accepted, but not sure when it will land in the repo.
So, I have only stared at the code and it looks good to me: doesn't break
current builds and should add provider path to dll search path on Windows
when upstream gets updated (or if/when we locally patch pkcs11-helper)

Acked-by: Selva Nair <selva.nair@...277...>

--00000000000099cc7d05efcbac41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 11, 2022 at 3:01 PM Marc B=
ecker via Openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@...1768...=
ge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Change win32 d=
ynamic loader behavior when supplying an absolute path.<br>
The DLL location is considered/preferred to resolve dependencies.<br>
Support in pkcs11-helper for loader flag is detected at compile time.<br>
<br>
3rd party DLLs and additional dependencies do no longer need to be moved<br>
to the OpenVPN directory or require changes to %PATH% configuration.<br>
<br>
Signed-off-by: Marc Becker &lt;<a href=3D"mailto:marc.becker@...2704..." ta=
rget=3D"_blank">marc.becker@...2704...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/pkcs11.c | 7 +++++++<br>
=C2=A01 file changed, 7 insertions(+)<br>
<br>
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c<br>
index b74ac8f4..aa027337 100644<br>
--- a/src/openvpn/pkcs11.c<br>
+++ b/src/openvpn/pkcs11.c<br>
@@ -420,6 +420,13 @@ pkcs11_addProvider(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rv =3D pkcs11h_setProviderP=
roperty(provider, PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &amp;cert_is_p=
rivate, sizeof(cert_is_private));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#if defined(WIN32) &amp;&amp; defined(PKCS11H_PROVIDER_PROPERTY_LOADER_FLA=
GS)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rv =3D=3D CKR_OK &amp;&amp; platform_absol=
ute_pathname(provider))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned loader_flags =3D LOAD_L=
IBRARY_SEARCH_DEFAULT_DIRS | LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rv =3D pkcs11h_setProviderProper=
ty(provider, PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS, &amp;loader_flags, siz=
eof(loader_flags));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rv !=3D CKR_OK || (rv =3D pkcs11h_ini=
tializeProvider(provider)) !=3D CKR_OK)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br></blockquote><div><br></div><div>Thi=
s requires a proposed change to pkcs11-helper which I believe will be merge=
d upstream -- Alon has closed the PR with a positive remark which usually m=
eans change accepted, but not sure when it will land in the repo. So, I hav=
e only stared at the code and it looks good to me: doesn&#39;t break curren=
t builds and should add provider path to dll search path on Windows when up=
stream gets updated (or if/when we locally patch pkcs11-helper)</div><div><=
br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...1354...=
.." target=3D"_blank">selva.nair@...277...</a>&gt;=C2=A0</div></div></div>

--00000000000099cc7d05efcbac41--

