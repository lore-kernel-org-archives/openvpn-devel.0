MIME-Version: 1.0
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
 <Y+azhVMqdJb/6gAN@...1296...>
In-Reply-To: <Y+azhVMqdJb/6gAN@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 10 Feb 2023 16:58:12 -0500
Message-ID: <CAKuzo_gD_nL4V=+rMfuu52FF03iAPMyWR-s0N6YjbrLXfRR8UA@...278...>
Content-Type: multipart/alternative; boundary="000000000000ee552405f45f98bd"
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000ee552405f45f98bd
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 10, 2023 at 4:13 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Feb 07, 2023 at 07:59:25PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Minor changes to the build system to include some
> >   dependencies for Windows build
> >
> > - test_tls_crypt not built as it will pull in win32.c and
> >   its dependencies
> >
> > - If cross-compiling, "make check" will only build the tests but not
> >   run any. Copy to Windows and run manually. Executables are in
> >   <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
> >   cmocka.dll in addition to openssl libs that some tests link to.
>
> I am something wrong, or I'm missing some bits.
>
> I took this patch, on top of commit e80720ef939 ("top of master as of
> now").  MinGW on Ubuntu.  "autoreconf -iv", make clean, then
> make && make check.
>
> make check claims
>
> make[4]: Entering directory '/home/gert/mingw/openvpn.git/tests'
> ==================
> All 0 tests passed
> ==================
>
> ... but it seems to have done... nothing?
>

My patch only enables to build the tests while cross-compiling but disables
running them. As the executables  are not native, you have to manually copy
them to Windows and run there.

With the next patch from Arne, GHA actions will copy it automagically to
Windows and run there. But that works only for github actions.

Selva

--000000000000ee552405f45f98bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 10, 2023 at 4:13 PM Gert =
Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Feb 07, 2023 at 07:59:25PM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Minor changes to the build system to include some<br>
&gt;=C2=A0 =C2=A0dependencies for Windows build<br>
&gt; <br>
&gt; - test_tls_crypt not built as it will pull in win32.c and<br>
&gt;=C2=A0 =C2=A0its dependencies<br>
&gt; <br>
&gt; - If cross-compiling, &quot;make check&quot; will only build the tests=
 but not<br>
&gt;=C2=A0 =C2=A0run any. Copy to Windows and run manually. Executables are=
 in<br>
&gt;=C2=A0 =C2=A0&lt;buid-dir&gt;/tests/unit_tests/openvpn/.libs/ and these=
 depend on<br>
&gt;=C2=A0 =C2=A0cmocka.dll in addition to openssl libs that some tests lin=
k to.<br>
<br>
I am something wrong, or I&#39;m missing some bits.<br>
<br>
I took this patch, on top of commit e80720ef939 (&quot;top of master as of<=
br>
now&quot;).=C2=A0 MinGW on Ubuntu.=C2=A0 &quot;autoreconf -iv&quot;, make c=
lean, then<br>
make &amp;&amp; make check.<br>
<br>
make check claims<br>
<br>
make[4]: Entering directory &#39;/home/gert/mingw/openvpn.git/tests&#39;<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
All 0 tests passed<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
... but it seems to have done... nothing?<br></blockquote><div><br></div><d=
iv>My patch only enables to build=C2=A0the tests while cross-compiling=C2=
=A0but disables running them. As the executables=C2=A0 are not native, you =
have to manually copy them to Windows and run there.=C2=A0</div><div><br></=
div><div>With the next patch from Arne, GHA actions will copy it automagica=
lly to Windows and run there. But that works only for github actions.</div>=
<div><br></div><div>Selva</div></div></div>

--000000000000ee552405f45f98bd--

