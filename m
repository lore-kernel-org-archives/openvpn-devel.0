MIME-Version: 1.0
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <20221211191403.805-1-marc.becker@...2704...>
In-Reply-To: <20221211191403.805-1-marc.becker@...2704...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 10:35:07 -0500
Message-ID: <CAKuzo_g7SV72PR8xCRib+PPJnqELyoRYkiOjgMbmh5ic52U6NQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000002616ec05efcb7cb2"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] use new pkcs11-helper interface
 to add providers
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

--0000000000002616ec05efcb7cb2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Dec 11, 2022 at 2:14 PM Marc Becker via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

> The new interface in  pkcs11-helper 1.28 allows decoupling of provider
> registration and initialization.
> This allows modifying more (and future) properties apart from the
> 6 fixed ones supported as arguments to pkcs11h_addProvider().
>
> With the new interface it is easier to see (from a code perspective)
> which option is set to which value.
> It's also not necessary to supply values for built-in defaults:
> - slot_event_method=PKCS11H_SLOTEVENT_METHOD_AUTO
> - slot_poll_interval=0
>
> Signed-off-by: Marc Becker <marc.becker@...2704...>
> ---
> v2: improved code and description, no (essentially) duplicated log output
> ---
>  src/openvpn/pkcs11.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
> index fbc4c472..b74ac8f4 100644
> --- a/src/openvpn/pkcs11.c
> +++ b/src/openvpn/pkcs11.c
> @@ -396,6 +396,38 @@ pkcs11_addProvider(
>          provider
>          );
>
> +#if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0))
> +    if ((rv = pkcs11h_registerProvider(provider)) != CKR_OK)
> +    {
> +        msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'",
> provider, rv, pkcs11h_getMessage(rv));
> +    }
> +    else
> +    {
> +        PKCS11H_BOOL allow_protected_auth = protected_auth;
> +        PKCS11H_BOOL cert_is_private = cert_private;
> +
> +        rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_LOCATION, provider, strlen(provider) + 1);
> +
> +        if (rv == CKR_OK)
> +        {
> +            rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &allow_protected_auth,
> sizeof(allow_protected_auth));
> +        }
> +        if (rv == CKR_OK)
> +        {
> +            rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE, &private_mode,
> sizeof(private_mode));
> +        }
> +        if (rv == CKR_OK)
> +        {
> +            rv = pkcs11h_setProviderProperty(provider,
> PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_is_private,
> sizeof(cert_is_private));
> +        }
> +
> +        if (rv != CKR_OK || (rv = pkcs11h_initializeProvider(provider))
> != CKR_OK)
> +        {
> +            msg(M_WARN, "PKCS#11: Cannot initialize provider '%s'
> %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
> +            pkcs11h_removeProvider(provider);
> +        }
> +    }
> +#else  /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
>      if (
>          (rv = pkcs11h_addProvider(
>               provider,
> @@ -410,6 +442,7 @@ pkcs11_addProvider(
>      {
>          msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'",
> provider, rv, pkcs11h_getMessage(rv));
>      }
> +#endif /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
>
>      dmsg(
>          D_PKCS11_DEBUG,
> --
> 2.38.1.windows.1
>

I have been delaying acking this until I get time to test 3/3, but as 1/3
is has been acked here goes:

Effectively this is the same as the original but splitting addProvider to
explicit register/set-properties/intialize calls when using recent versions
of pkcs11-helper is a useful refactoring.

Acked-by: Selva Nair <selva.nair@...277...>

--0000000000002616ec05efcb7cb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 11, 2022 at 2:14 PM Marc B=
ecker via Openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@...1768...=
ge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The new interf=
ace in=C2=A0 pkcs11-helper 1.28 allows decoupling of provider<br>
registration and initialization.<br>
This allows modifying more (and future) properties apart from the<br>
6 fixed ones supported as arguments to pkcs11h_addProvider().<br>
<br>
With the new interface it is easier to see (from a code perspective)<br>
which option is set to which value.<br>
It&#39;s also not necessary to supply values for built-in defaults:<br>
- slot_event_method=3DPKCS11H_SLOTEVENT_METHOD_AUTO<br>
- slot_poll_interval=3D0<br>
<br>
Signed-off-by: Marc Becker &lt;<a href=3D"mailto:marc.becker@...2704..." ta=
rget=3D"_blank">marc.becker@...2704...</a>&gt;<br>
---<br>
v2: improved code and description, no (essentially) duplicated log output<b=
r>
---<br>
=C2=A0src/openvpn/pkcs11.c | 33 +++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 33 insertions(+)<br>
<br>
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c<br>
index fbc4c472..b74ac8f4 100644<br>
--- a/src/openvpn/pkcs11.c<br>
+++ b/src/openvpn/pkcs11.c<br>
@@ -396,6 +396,38 @@ pkcs11_addProvider(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0provider<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
<br>
+#if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) | (0&lt;&lt;0))=
<br>
+=C2=A0 =C2=A0 if ((rv =3D pkcs11h_registerProvider(provider)) !=3D CKR_OK)=
<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;PKCS#11: Cannot register pro=
vider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv, pkcs11h_getMessage=
(rv));<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PKCS11H_BOOL allow_protected_auth =3D protecte=
d_auth;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PKCS11H_BOOL cert_is_private =3D cert_private;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rv =3D pkcs11h_setProviderProperty(provider, P=
KCS11H_PROVIDER_PROPERTY_LOCATION, provider, strlen(provider) + 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rv =3D=3D CKR_OK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rv =3D pkcs11h_setProviderProper=
ty(provider, PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &amp;allow_pro=
tected_auth, sizeof(allow_protected_auth));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rv =3D=3D CKR_OK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rv =3D pkcs11h_setProviderProper=
ty(provider, PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE, &amp;private_mode=
, sizeof(private_mode));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rv =3D=3D CKR_OK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rv =3D pkcs11h_setProviderProper=
ty(provider, PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &amp;cert_is_privat=
e, sizeof(cert_is_private));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rv !=3D CKR_OK || (rv =3D pkcs11h_initiali=
zeProvider(provider)) !=3D CKR_OK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;PKCS#11: Canno=
t initialize provider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv, pk=
cs11h_getMessage(rv));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkcs11h_removeProvider(provider)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#else=C2=A0 /* if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) |=
 (0&lt;&lt;0)) */<br>
=C2=A0 =C2=A0 =C2=A0if (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rv =3D pkcs11h_addProvider(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 provider,<br>
@@ -410,6 +442,7 @@ pkcs11_addProvider(<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(M_WARN, &quot;PKCS#11: Cannot initial=
ize provider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv, pkcs11h_get=
Message(rv));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#endif /* if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) | (0&l=
t;&lt;0)) */<br>
<br>
=C2=A0 =C2=A0 =C2=A0dmsg(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D_PKCS11_DEBUG,<br>
-- <br>
2.38.1.windows.1<br></blockquote><div><br></div><div>I have been delaying a=
cking this until I get time to test 3/3, but as 1/3 is has been acked=C2=A0=
here goes:</div><div><br></div><div>Effectively this is the same as the ori=
ginal but splitting addProvider to explicit register/set-properties/intiali=
ze=C2=A0calls when using recent versions of pkcs11-helper is a useful refac=
toring.</div><div><br></div><div>Acked-by: Selva Nair &lt;<a href=3D"mailto=
:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</div>=
</div></div>

--0000000000002616ec05efcb7cb2--

