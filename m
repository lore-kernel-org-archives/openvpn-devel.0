MIME-Version: 1.0
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
In-Reply-To: <Y9pTdgI+T90r6PBz@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 1 Feb 2023 21:45:20 -0500
Message-ID: <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000037d00a05f3ae8f6c"
Subject: Re: [Openvpn-devel] [PATCH 4/4] cryptoapi.c: simplify parsing of
 thumbprint hex string
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

--00000000000037d00a05f3ae8f6c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Feb 1, 2023 at 6:56 AM Frank Lichtenheld <frank@...2641...>
wrote:

> On Sat, Jan 28, 2023 at 05:34:21PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
> > ---
> >  src/openvpn/cryptoapi.c | 44 +++++++++++------------------------------
> >  1 file changed, 12 insertions(+), 32 deletions(-)
> >
> > diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> > index 6ff4fcb5..9fd5aea9 100644
> > --- a/src/openvpn/cryptoapi.c
> > +++ b/src/openvpn/cryptoapi.c
> > @@ -210,49 +210,29 @@ find_certificate_in_store(const char *cert_prop,
> HCERTSTORE cert_store)
>
> This seems to ask for a unittest.


Would be nice indeed.

But, I've never tried to enable cmocka in our Windows build -- does it
work? If it does, I would be inclined to add tests for this as well as some
other functions in cryptoapi.c

Regards,

Selva

--00000000000037d00a05f3ae8f6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Feb 1, 2023 at 6:56 AM Frank Lichtenheld &=
lt;<a href=3D"mailto:frank@...2641..." target=3D"_blank">frank@...2641...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Sat, Jan 28, 2023 at 05:34:21PM -0500, <a href=3D"mailto:selva.nair@...1482...=
..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/cryptoapi.c | 44 +++++++++++------------------------=
------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 32 deletions(-)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c<br>
&gt; index 6ff4fcb5..9fd5aea9 100644<br>
&gt; --- a/src/openvpn/cryptoapi.c<br>
&gt; +++ b/src/openvpn/cryptoapi.c<br>
&gt; @@ -210,49 +210,29 @@ find_certificate_in_store(const char *cert_prop,=
 HCERTSTORE cert_store)<br>
<br>
This seems to ask for a unittest.</blockquote><div>=C2=A0</div><div>Would b=
e nice indeed.</div><div><br></div><div>But, I&#39;ve never tried to enable=
 cmocka in our Windows build -- does it work? If it does, I would be inclin=
ed to add tests for this as well as some other functions in cryptoapi.c</di=
v><div><br></div><div>Regards,</div><div><br></div><div>Selva</div></div></=
div>

--00000000000037d00a05f3ae8f6c--

