MIME-Version: 1.0
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
 <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
In-Reply-To: <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 3 Feb 2023 00:00:59 -0500
Message-ID: <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003802ff05f3c49201"
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

--0000000000003802ff05f3c49201
Content-Type: text/plain; charset="UTF-8"

Hi

>
> On Wed, Feb 1, 2023 at 6:56 AM Frank Lichtenheld <frank@...2641...>
> wrote:
>
>> On Sat, Jan 28, 2023 at 05:34:21PM -0500, selva.nair@...277... wrote:
>> > From: Selva Nair <selva.nair@...277...>
>> >
>> > Signed-off-by: Selva Nair <selva.nair@...277...>
>> > ---
>> >  src/openvpn/cryptoapi.c | 44 +++++++++++------------------------------
>> >  1 file changed, 12 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
>> > index 6ff4fcb5..9fd5aea9 100644
>> > --- a/src/openvpn/cryptoapi.c
>> > +++ b/src/openvpn/cryptoapi.c
>> > @@ -210,49 +210,29 @@ find_certificate_in_store(const char *cert_prop,
>> HCERTSTORE cert_store)
>>
>> This seems to ask for a unittest.
>
>
> Would be nice indeed.
>
> But, I've never tried to enable cmocka in our Windows build -- does it
> work? If it does, I would be inclined to add tests for this as well as some
> other functions in cryptoapi.c
>

Well, replying to myself:

I tried building the unit tests using cmocka for Windows  (cross-compiling
using mingw-w64 with locally built cmocka). Unfortunately, none of the
tests could be built out of the box because of missing dependencies, so I
guess no one is running these tests on Windows.

Good news is that I could get provider_testdriver to build and run on
Windows with minor tweaks and a test for this patch could be easily written
too.

I can follow up with a test patch, but wonder whether it's worth spending
time on if no one else is building these tests for Windows.

Regards,

Selva

--0000000000003802ff05f3c49201
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 1, 2023 at 6:56 AM =
Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_blank"=
>frank@...2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Sat, Jan 28, 2023 at 05:34:21PM -0500, <a href=3D"mailt=
o:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a> wrote:<b=
r>
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
v></div></div></blockquote><div><br></div><div>Well, replying to myself:</d=
iv><div><br></div><div>I tried building the unit tests using cmocka for Win=
dows=C2=A0 (cross-compiling using mingw-w64 with locally built cmocka). Unf=
ortunately, none of the tests could be built out of the box because of miss=
ing dependencies, so I guess no one is running these tests on Windows.=C2=
=A0</div><div><br></div><div>Good news is that I could get provider_testdri=
ver to build and run on Windows with minor tweaks and a test for this patch=
 could be easily written too.=C2=A0</div><div><br></div><div>I can follow u=
p with a test patch, but wonder whether it&#39;s=C2=A0worth spending time o=
n if no one else is building these tests for Windows.</div><div><br></div><=
div>Regards,</div><div><br></div><div>Selva</div></div></div>

--0000000000003802ff05f3c49201--

