MIME-Version: 1.0
References: <20221123154912.28394-1-maximilian.fillinger@...2507...>
 <efd32889-60e9-5892-9b38-bf54bf398a87@...1227...>
In-Reply-To: <efd32889-60e9-5892-9b38-bf54bf398a87@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Nov 2022 13:37:47 -0500
Message-ID: <CAKuzo_hB1As0L2tMGewNbi5_WFoeoFJViSYj4yAcQs66cp8hHA@...278...>
Content-Type: multipart/alternative; boundary="0000000000005e7ebd05ee27983d"
Subject: Re: [Openvpn-devel] [PATCH] Check if pkcs11_cert is NULL before
 freeing it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

--0000000000005e7ebd05ee27983d
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Nov 23, 2022 at 12:18 PM Arne Schwabe <arne@...1227...> wrote:

> Am 23.11.22 um 16:49 schrieb Max Fillinger:
> > When running openvpn --show-tls with mbedtls, it showed a null pointer
> > error at the end because of this.
> >
> > Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> > ---
> >   src/openvpn/ssl_mbedtls.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
> > index ea06cf70..aa55a1a0 100644
> > --- a/src/openvpn/ssl_mbedtls.c
> > +++ b/src/openvpn/ssl_mbedtls.c
> > @@ -165,7 +165,10 @@ tls_ctx_free(struct tls_root_ctx *ctx)
> >           free(ctx->crl);
> >
> >   #if defined(ENABLE_PKCS11)
> > -        pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
> > +        if (ctx->pkcs11_cert)
> > +        {
> > +            pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
> > +        }
> >   #endif
> >
> >           free(ctx->allowed_ciphers);
>
> Sigh, a function that violates the C paradigm that calling somethingfree
> on a null pointer is fine. Maybe we should add as a comment that this
> function is special in this way.
>

pkcs11h_certiciate_freeCertificate() does seem to handle NULL argument.
With --show-tls, are we calling this before intializing the pkcs11 library?
That could trigger an ASSERT.

Selva

--0000000000005e7ebd05ee27983d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Nov 23, 2022 at 12:18 PM Arne Schwabe &lt;=
<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 23.1=
1.22 um 16:49 schrieb Max Fillinger:<br>
&gt; When running openvpn --show-tls with mbedtls, it showed a null pointer=
<br>
&gt; error at the end because of this.<br>
&gt; <br>
&gt; Signed-off-by: Max Fillinger &lt;<a href=3D"mailto:maximilian.fillinge=
r@...2507..." target=3D"_blank">maximilian.fillinger@...2507...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0src/openvpn/ssl_mbedtls.c | 5 ++++-<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c<br>
&gt; index ea06cf70..aa55a1a0 100644<br>
&gt; --- a/src/openvpn/ssl_mbedtls.c<br>
&gt; +++ b/src/openvpn/ssl_mbedtls.c<br>
&gt; @@ -165,7 +165,10 @@ tls_ctx_free(struct tls_root_ctx *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(ctx-&gt;crl);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#if defined(ENABLE_PKCS11)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkcs11h_certificate_freeCertificate(ctx-&=
gt;pkcs11_cert);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx-&gt;pkcs11_cert)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkcs11h_certificate_freeCer=
tificate(ctx-&gt;pkcs11_cert);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(ctx-&gt;allowed_ciphers);=
<br>
<br>
Sigh, a function that violates the C paradigm that calling somethingfree <b=
r>
on a null pointer is fine. Maybe we should add as a comment that this <br>
function is special in this way.<br></blockquote><div><br></div><div>pkcs11=
h_certiciate_freeCertificate() does seem to handle NULL argument.</div><div=
>With --show-tls, are we calling this before=C2=A0intializing the pkcs11 li=
brary? That could trigger an ASSERT.</div><div><br></div><div>Selva=C2=A0</=
div></div></div>

--0000000000005e7ebd05ee27983d--

