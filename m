MIME-Version: 1.0
In-Reply-To: <8b5e5f96-a198-dcb9-66cc-d1969743d801@...1856...>
References: <1487874133-28780-1-git-send-email-chipitsine@...277...>
	<8b5e5f96-a198-dcb9-66cc-d1969743d801@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 25 Feb 2017 21:35:15 +0500
Message-ID: <CAFHpkQEt+0aS7USZMkvBMT5V5Rm8sDmDgB7Xn31OAtv+04ToBg@...278...>
Content-Type: multipart/alternative; boundary=001a11469c545bfe8c05495d6e50
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add "make distcheck" to test
	scenario
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11469c545bfe8c05495d6e50
Content-Type: text/plain; charset=UTF-8

2017-02-25 21:10 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 23-02-17 19:22, Ilya Shipitsin wrote:
> > in rare cases openvpn is built from tarball, it happens during
> "installer build"
> > process. "make distcheck" helps to prevent problems during such builds.
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> >  .travis.yml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index a68374a..6ebfa39 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -79,6 +79,7 @@ script:
> >    - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"; fi
> >    - autoreconf -vi
> >    - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
> > +  - make distcheck > build.log 2>&1 || (cat build.log && exit 1)
> >    - make -j$JOBS
> >    - src/openvpn/openvpn --version || true
> >    - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn;
> fi
> >
>
> Running 'make distcheck' from travis is a good idea.  But, I think it
> should be done *after* 'make check'.  Futhermore, it would be nice to
> only do this for one of the configurations, to keep our travis runs as
> lightweight as possible (saves devs some waiting time, saves travis
> energy/capacity).
>

I think we can introduce ADDITIONAL_SCRIPT env, and, if it is defined, run
script defined in that variable


>
> -Steffan
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a11469c545bfe8c05495d6e50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-25 21:10 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 23-02-17 19:22, Ilya Shipitsin wrote:<br>
&gt; in rare cases openvpn is built from tarball, it happens during &quot;i=
nstaller build&quot;<br>
&gt; process. &quot;make distcheck&quot; helps to prevent problems during s=
uch builds.<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
..">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .travis.yml | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index a68374a..6ebfa39 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -79,6 +79,7 @@ script:<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=
=C2=A0 =C2=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/<wbr>lib:${=
DYLD_LIBRARY_PATH}&quot;; fi<br>
&gt;=C2=A0 =C2=A0 - autoreconf -vi<br>
&gt;=C2=A0 =C2=A0 - ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB=
}&quot; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
&gt; +=C2=A0 - make distcheck &gt; build.log 2&gt;&amp;1 || (cat build.log =
&amp;&amp; exit 1)<br>
&gt;=C2=A0 =C2=A0 - make -j$JOBS<br>
&gt;=C2=A0 =C2=A0 - src/openvpn/openvpn --version || true<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot=
; ]; then ldd src/openvpn/openvpn; fi<br>
&gt;<br>
<br>
</span>Running &#39;make distcheck&#39; from travis is a good idea.=C2=A0 B=
ut, I think it<br>
should be done *after* &#39;make check&#39;.=C2=A0 Futhermore, it would be =
nice to<br>
only do this for one of the configurations, to keep our travis runs as<br>
lightweight as possible (saves devs some waiting time, saves travis<br>
energy/capacity).<br></blockquote><div><br></div><div>I think we can introd=
uce ADDITIONAL_SCRIPT env, and, if it is defined, run script defined in tha=
t variable<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-Steffan<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a11469c545bfe8c05495d6e50--

