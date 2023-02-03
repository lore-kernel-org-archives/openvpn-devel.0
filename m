MIME-Version: 1.0
References: <20230128223421.2207802-1-selva.nair@...277...>
 <20230128223421.2207802-5-selva.nair@...277...>
 <Y9pTdgI+T90r6PBz@...2685...>
 <CAKuzo_jCb_tcMY6b1MeHJXLQ37cHDcpOSUttKqT9fFuzNL0w5Q@...278...>
 <CAKuzo_jPnumze9KSWA6ywKh-rH3=vrtDZPtWVK-FGrwjgcv=mA@...278...>
 <5fbbea42-096a-f9e9-f230-ccc526e973e2@...1227...>
In-Reply-To: <5fbbea42-096a-f9e9-f230-ccc526e973e2@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 3 Feb 2023 11:18:03 -0500
Message-ID: <CAKuzo_jTyEnq9-MwT8XePMby7yNXzN-auwx8osYSx16nC-z8zA@...278...>
Content-Type: multipart/alternative; boundary="000000000000932f6c05f3ce076b"
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
To: Arne Schwabe <arne@...1227...>
Cc: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

--000000000000932f6c05f3ce076b
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 3, 2023 at 5:25 AM Arne Schwabe <arne@...1227...> wrote:

>
> > Well, replying to myself:
> >
> > I tried building the unit tests using cmocka for Windows
> > (cross-compiling using mingw-w64 with locally built cmocka).
> > Unfortunately, none of the tests could be built out of the box because
> > of missing dependencies, so I guess no one is running these tests on
> > Windows.
> >
> > Good news is that I could get provider_testdriver to build and run on
> > Windows with minor tweaks and a test for this patch could be easily
> > written too.
> >
> > I can follow up with a test patch, but wonder whether it's worth
> > spending time on if no one else is building these tests for Windows.
>
> I have a cmake build file for OpenVPN that actually builds part of the
> unit tests ("test_packet_id" "test_crypto" "test_ncp" "test_auth_token"
> "test_misc" "test_buffer" "test_provider" "test_pkt") and run them in
> the Github actions pipeline. But the cmake stuff is more "work in
> progress" and the general consensus was to stick with the autoconf
> approach.
>
> I looked into building the test binaries as part of the normal MSVC
> build but gave up on trying to figure out how to deal with MSVC and
> their solutions, especially since you can nowadays just point it at a
> CmakeLists.txt and it will pick that up just fine.
>
> If you want to take a look:
>
> Cmake build file:
> https://github.com/schwabe/openvpn/blob/bloom/CMakeLists.txt
>
> Running tests as part of GHA:
>
> https://github.com/schwabe/openvpn/blob/bloom/.github/workflows/build.yaml#L561


Thanks a lot for that.

By adding win32-util.c and -lws2_32 where required, I can now build almost
all tests using the autotools framework --- cmocka had to be cross-compiled
using cmake which is a pain.

I do not particularly like cmake though it's convenient for Windows MSVC
build, so sticking to autoconf/automake for now. Unless the "consensus" is
to move to cmake --- hope not :)

Anyway, this is motivating to write some tests.

Selva

--000000000000932f6c05f3ce076b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 3, 2023 at 5:25 AM Arne S=
chwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...2068...=
7...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
&gt; Well, replying to myself:<br>
&gt; <br>
&gt; I tried building the unit tests using cmocka for Windows=C2=A0 <br>
&gt; (cross-compiling using mingw-w64 with locally built cmocka). <br>
&gt; Unfortunately, none of the tests could be built out of the box because=
 <br>
&gt; of missing dependencies, so I guess no one is running these tests on <=
br>
&gt; Windows.<br>
&gt; <br>
&gt; Good news is that I could get provider_testdriver to build and run on =
<br>
&gt; Windows with minor tweaks and a test for this patch could be easily <b=
r>
&gt; written too.<br>
&gt; <br>
&gt; I can follow up with a test patch, but wonder whether it&#39;s=C2=A0wo=
rth <br>
&gt; spending time on if no one else is building these tests for Windows.<b=
r>
<br>
I have a cmake build file for OpenVPN that actually builds part of the <br>
unit tests (&quot;test_packet_id&quot; &quot;test_crypto&quot; &quot;test_n=
cp&quot; &quot;test_auth_token&quot; <br>
&quot;test_misc&quot; &quot;test_buffer&quot; &quot;test_provider&quot; &qu=
ot;test_pkt&quot;) and run them in <br>
the Github actions pipeline. But the cmake stuff is more &quot;work in <br>
progress&quot; and the general consensus was to stick with the autoconf <br>
approach.<br>
<br>
I looked into building the test binaries as part of the normal MSVC <br>
build but gave up on trying to figure out how to deal with MSVC and <br>
their solutions, especially since you can nowadays just point it at a <br>
CmakeLists.txt and it will pick that up just fine.<br>
<br>
If you want to take a look:<br>
<br>
Cmake build file: <br>
<a href=3D"https://github.com/schwabe/openvpn/blob/bloom/CMakeLists.txt" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/schwabe/openvpn/blob/=
bloom/CMakeLists.txt</a><br>
<br>
Running tests as part of GHA: <br>
<a href=3D"https://github.com/schwabe/openvpn/blob/bloom/.github/workflows/=
build.yaml#L561" rel=3D"noreferrer" target=3D"_blank">https://github.com/sc=
hwabe/openvpn/blob/bloom/.github/workflows/build.yaml#L561</a></blockquote>=
<div><br></div><div>Thanks a lot for that.=C2=A0</div><div><br></div><div>B=
y adding win32-util.c and -lws2_32 where required, I can now build almost a=
ll tests using the autotools framework --- cmocka had to be cross-compiled =
using cmake which is a pain.</div><div>=C2=A0</div><div>I do not particular=
ly like cmake though it&#39;s=C2=A0convenient for Windows MSVC build, so st=
icking to autoconf/automake for now. Unless the &quot;consensus&quot; is to=
 move to cmake --- hope not :)</div><div><br></div><div>Anyway, this is mot=
ivating to write some tests.</div><div><br></div><div>Selva</div></div></di=
v>

--000000000000932f6c05f3ce076b--

