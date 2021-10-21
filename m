MIME-Version: 1.0
References: <20211019183127.614175-1-arne@...1227...>
 <20211019183127.614175-4-arne@...1227...>
 <CAKuzo_jOdVxYE4OOA+cjXCpi0PkgQqt_WHGtZT0X0vdAkJ7MXw@...278...>
 <110a6779-421f-6fe3-d1d5-530658e45555@...1227...>
In-Reply-To: <110a6779-421f-6fe3-d1d5-530658e45555@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 21 Oct 2021 14:04:41 -0400
Message-ID: <CAKuzo_gZkJ1Eqr3nezBuD7qHpfYKwrSMD+0KTCbr4835-yBDfw@...278...>
Content-Type: multipart/alternative; boundary="00000000000085531f05cee0bb3d"
Subject: Re: [Openvpn-devel] [PATCH v3 03/21] [OSSL 3.0] Implement DES ECB
 encrypt via EVP_CIPHER api
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--00000000000085531f05cee0bb3d
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 21, 2021 at 5:42 AM Arne Schwabe <arne@...1227...> wrote:

>
> >
> >
> > Apart from the wrong cipher type that Max pointed out, this call will
> > fail in OpenSSL 3.0 unless legacy is loaded, right? Causing a run-time
> > error in that case sounds good to me but a helpful error message like
> > legacy provider may be required or even a check whether legacy is loaded
> > and error out appropriately would be helpful.
> >
> > PS: can't we just get rid of the use of DES altogether?
> >
>
> As Gert pointed out that NTLM depends on it. We can trick a bit here
> with DES-EDE and three times the same key but yes it should have a
> better error message.
>

Oh, proxy with ntlm auth... That will have to live on for a while longer.

In that case we could load the legacy provider if http-proxy with auto,
auto-nct or ntlm is in options (in a separate patch), and can leave the
generic error message in this patch?

Selva

--00000000000085531f05cee0bb3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 21, 2021 at 5:42 AM Arne =
Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt; <br>
&gt; <br>
&gt; Apart from the wrong cipher type that Max pointed out, this call will<=
br>
&gt; fail in OpenSSL 3.0 unless legacy is loaded, right? Causing a run-time=
<br>
&gt; error in that case sounds good=C2=A0to me but a helpful error message =
like<br>
&gt; legacy provider may be required or even a check whether legacy is load=
ed<br>
&gt; and error out appropriately would be helpful.<br>
&gt; <br>
&gt; PS: can&#39;t we just get rid of the use of DES altogether?<br>
&gt; <br>
<br>
As Gert pointed out that NTLM depends on it. We can trick a bit here<br>
with DES-EDE and three times the same key but yes it should have a<br>
better error message.<br></blockquote><div><br></div><div>Oh, proxy with nt=
lm auth... That will have to live on for a while longer.</div><div><br></di=
v><div>In that case we could load the legacy provider if http-proxy with au=
to, auto-nct or ntlm is in options (in a separate patch), and can leave the=
 generic error message in this patch?</div><div><br></div><div>Selva</div><=
/div></div>

--00000000000085531f05cee0bb3d--

