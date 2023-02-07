MIME-Version: 1.0
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <e45213bd-6aba-02ca-ecb5-fbd51aebe05e@...1227...>
In-Reply-To: <e45213bd-6aba-02ca-ecb5-fbd51aebe05e@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Feb 2023 12:55:08 -0500
Message-ID: <CAKuzo_hEivnhbMb+LH-PC8H91zaXsqE7zhQopi9xUaiomaUF9Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000028498705f41fdad4"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000028498705f41fdad4
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Feb 7, 2023 at 6:59 AM Arne Schwabe <arne@...1227...> wrote:

> Am 04.02.23 um 07:40 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Minor changes to the build system to include some
> >    dependencies for Windows build
> >
> > - test_tls_crypt not built as it will pull in win32.c and
> >    its dependencies
> >
> > - If cross-compiling, "make check" will only build the tests but not
> >    run any. Copy to Windows and run manually. Executables are in
> >    <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
> >    cmocka.dll in addition to openssl libs that some tests link to.
> >
> >    Building with mingw on Windows should run the tests (untested).
> >
> > v2: networking_testdriver was mistakenly enabled to run, while
> > originally it was only set to build. Corrected.
> >
>
> I am currently testing this and also trying to add this to the Github
> actions. This patch seems fine but I get other weird errors and cmocka
> builds fine crosscompiling on my own machine but breaks for some reason
> in Github Actions. I am looking into these problems and will give a full
> review after I solved those issues.
>

That would be nice. I was not sure how to copy the artifacts into a Windows
instance and add a job for testing them in GHA.

Regarding "weird errors" an obvious thing easy to overlook is that the
exe's are in .libs/ -- the wrapper that libtool generates is only useful
for running native builds in-place with uninstalled shared libraries.

Also, I just noticed that I had locally disabled the example test because
of some missing header warning -- it needs an include <stdint.h> to build.

Regards,

Selva

--00000000000028498705f41fdad4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 6:59 AM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Am 04.02.23 um 07:40 schrie=
b <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1665...=
77...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Minor changes to the build system to include some<br>
&gt;=C2=A0 =C2=A0 dependencies for Windows build<br>
&gt; <br>
&gt; - test_tls_crypt not built as it will pull in win32.c and<br>
&gt;=C2=A0 =C2=A0 its dependencies<br>
&gt; <br>
&gt; - If cross-compiling, &quot;make check&quot; will only build the tests=
 but not<br>
&gt;=C2=A0 =C2=A0 run any. Copy to Windows and run manually. Executables ar=
e in<br>
&gt;=C2=A0 =C2=A0 &lt;buid-dir&gt;/tests/unit_tests/openvpn/.libs/ and thes=
e depend on<br>
&gt;=C2=A0 =C2=A0 cmocka.dll in addition to openssl libs that some tests li=
nk to.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Building with mingw on Windows should run the tests (unte=
sted).<br>
&gt; <br>
&gt; v2: networking_testdriver was mistakenly enabled to run, while<br>
&gt; originally it was only set to build. Corrected.<br>
&gt;<br>
<br>
I am currently testing this and also trying to add this to the Github <br>
actions. This patch seems fine but I get other weird errors and cmocka <br>
builds fine crosscompiling on my own machine but breaks for some reason <br>
in Github Actions. I am looking into these problems and will give a full <b=
r>
review after I solved those issues.<br></blockquote><div><br></div><div>Tha=
t would be nice. I was not sure how to copy the artifacts=C2=A0into a Windo=
ws instance and add a job for testing them in GHA.</div><div><br></div><div=
>Regarding &quot;weird errors&quot; an obvious thing easy to overlook is th=
at the exe&#39;s are in .libs/ -- the wrapper that libtool generates is onl=
y useful for running native builds in-place with uninstalled shared librari=
es.</div><div><br></div><div>Also, I just noticed that I had locally disabl=
ed the example test because of some missing header warning -- it needs an i=
nclude &lt;stdint.h&gt; to build.</div><div><br></div><div>Regards,</div><d=
iv><br></div><div>Selva</div></div></div>

--00000000000028498705f41fdad4--

