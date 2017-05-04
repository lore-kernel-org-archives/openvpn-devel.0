MIME-Version: 1.0
In-Reply-To: <f2c52b1c-44a1-31bc-a6c4-a5c014cbfb0f@...1856...>
References: <1493194434-16926-1-git-send-email-chipitsine@...277...>
	<f2c52b1c-44a1-31bc-a6c4-a5c014cbfb0f@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 4 May 2017 14:13:08 +0500
Message-ID: <CAFHpkQHgpe-TBw5F9bAgJiBqCmNz4FLMi+0o+1T2Q3ROWHPvyA@...278...>
Content-Type: multipart/alternative; boundary=001a114e32ee73bbe7054eaf2ebc
Subject: Re: [Openvpn-devel] [PATCH] v3,
	travis-ci: add 2 mingw "build only" configurations
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

--001a114e32ee73bbe7054eaf2ebc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-05-04 0:13 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 26-04-17 10:13, Ilya Shipitsin wrote:
> > Inspired by https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13032.html
> > build options are taken from regular windows installer builds
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> > v2: moved download/build dependencies into functions, changed cross bui=
ld
> > detection from shell expansion ${CHOST+x} to more recognised -z
> "${CHOST}",
> > which required changing 'set -eux' to 'set -ex'. Added comments to make
> > code readable without looking into commit message.
> >
> > v3: fixed "trailing whitespaces" found by Samuli Sepp=C3=A4nen. Added b=
ack
> "set -u",
> > thanks to Steffan Karger. Changed repo manipulation to
> "apt-add-repository", thanks
> > to Nathan Stratton Treadway.
>
> Thanks for not giving up - this looks a lot better now!  Still a problem
> though:
>
> > -  - ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} ||
> (cat config.log && exit 1)
> > -  - make -j$JOBS
> > -  - src/openvpn/openvpn --version || true
> > -  - if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd src/openvpn/openv=
pn;
> fi
> > -  - if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L
> src/openvpn/openvpn; fi
> > -  - make check
> > -  - $EXTRA_SCRIPT
> > +  - if [ -z "${CHOST}" ]; then
> > +      ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} =
||
> (cat config.log && exit 1);
> > +      make -j$JOBS;
> > +      src/openvpn/openvpn --version || true;
> > +      if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd
> src/openvpn/openvpn; fi;
> > +      if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L
> src/openvpn/openvpn; fi;
> > +      make check;
> > +      $EXTRA_SCRIPT;
> > +    else
> > +      export TAP_CFLAGS=3D"-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}
> /include";
> > +      export LZO_CFLAGS=3D"-I${PREFIX}/include";
> > +      export LZO_LIBS=3D"-L${PREFIX}/lib -llzo2";
> > +      export PKCS11_HELPER_LIBS=3D"-L${PREFIX}/lib -lpkcs11-helper";
> > +      export PKCS11_HELPER_CFLAGS=3D"-I${PREFIX}/include";
> > +      ./configure --with-crypto-library=3D"${SSLLIB}" --host=3D${CHOST}
> --build=3Dx86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat
> config.log && exit 1);
> > +      make -j$JOBS;
> > +    fi
>
> Adding this as a command - with the steps separated by ; - will cause
> failures to be ignored.  This patch should fail the build:
>
>        make check;
> +      false;
>        $EXTRA_SCRIPT;
>
> ... but it doesn't:
>
> https://github.com/syzzer/openvpn/commit/df910243428589691cfaa1c0dcc6d9
> 2ec7d12b8e
>
> https://travis-ci.org/syzzer/openvpn/builds/228462383?utm_
> source=3Dgithub_status&utm_medium=3Dnotification



I test both "cache enabled" and "cache purged" builds.
I should add "false" as well ))


thanks for catching that! I will send "v4 soon"


>
>
> To fix this, I propose to create a .travis/build-check.sh script, which
> contains the build steps (and set -eu), and call that script from
> .travis.yml
>
> -Steffan
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114e32ee73bbe7054eaf2ebc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-05-04 0:13 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 26-04-17 10:13, Ilya Shipitsin wrote:<br>
&gt; Inspired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg13032.html" rel=3D"noreferrer" target=3D"_blank">https=
://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/m=
sg13032.html</a><br>
&gt; build options are taken from regular windows installer builds<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
..">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt; v2: moved download/build dependencies into functions, changed cross bu=
ild<br>
&gt; detection from shell expansion ${CHOST+x} to more recognised -z &quot;=
${CHOST}&quot;,<br>
&gt; which required changing &#39;set -eux&#39; to &#39;set -ex&#39;. Added=
 comments to make<br>
&gt; code readable without looking into commit message.<br>
&gt;<br>
&gt; v3: fixed &quot;trailing whitespaces&quot; found by Samuli Sepp=C3=A4n=
en. Added back &quot;set -u&quot;,<br>
&gt; thanks to Steffan Karger. Changed repo manipulation to &quot;apt-add-r=
epository&quot;, thanks<br>
&gt; to Nathan Stratton Treadway.<br>
<br>
</span>Thanks for not giving up - this looks a lot better now!=C2=A0 Still =
a problem<br>
though:<br>
<span class=3D""><br>
&gt; -=C2=A0 - ./configure --with-crypto-library=3D&quot;${<wbr>SSLLIB}&quo=
t; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1)<br>
&gt; -=C2=A0 - make -j$JOBS<br>
&gt; -=C2=A0 - src/openvpn/openvpn --version || true<br>
&gt; -=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; =
then ldd src/openvpn/openvpn; fi<br>
&gt; -=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; th=
en otool -L src/openvpn/openvpn; fi<br>
&gt; -=C2=A0 - make check<br>
&gt; -=C2=A0 - $EXTRA_SCRIPT<br>
&gt; +=C2=A0 - if [ -z &quot;${CHOST}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3D&quot;${<wbr=
>SSLLIB}&quot; ${EXTRA_CONFIG} || (cat config.log &amp;&amp; exit 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 src/openvpn/openvpn --version || true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;lin=
ux&quot; ]; then ldd src/openvpn/openvpn; fi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx=
&quot; ]; then otool -L src/openvpn/openvpn; fi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make check;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 $EXTRA_SCRIPT;<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 export TAP_CFLAGS=3D&quot;-I${PWD}/tap-<wbr>wind=
ows-${TAP_WINDOWS_VERSION}<wbr>/include&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 export LZO_CFLAGS=3D&quot;-I${PREFIX}/<wbr>inclu=
de&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 export LZO_LIBS=3D&quot;-L${PREFIX}/lib -llzo2&q=
uot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 export PKCS11_HELPER_LIBS=3D&quot;-L${<wbr>PREFI=
X}/lib -lpkcs11-helper&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 export PKCS11_HELPER_CFLAGS=3D&quot;-I${<wbr>PRE=
FIX}/include&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 ./configure --with-crypto-library=3D&quot;${<wbr=
>SSLLIB}&quot; --host=3D${CHOST} --build=3Dx86_64-pc-linux-gnu --enable-pkc=
s11 --disable-plugins || (cat config.log &amp;&amp; exit 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 make -j$JOBS;<br>
&gt; +=C2=A0 =C2=A0 fi<br>
<br>
</span>Adding this as a command - with the steps separated by ; - will caus=
e<br>
failures to be ignored.=C2=A0 This patch should fail the build:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0make check;<br>
+=C2=A0 =C2=A0 =C2=A0 false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$EXTRA_SCRIPT;<br>
<br>
... but it doesn&#39;t:<br>
<br>
<a href=3D"https://github.com/syzzer/openvpn/commit/df910243428589691cfaa1c=
0dcc6d92ec7d12b8e" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
syzzer/<wbr>openvpn/commit/<wbr>df910243428589691cfaa1c0dcc6d9<wbr>2ec7d12b=
8e</a><br>
<br>
<a href=3D"https://travis-ci.org/syzzer/openvpn/builds/228462383?utm_source=
=3Dgithub_status&amp;utm_medium=3Dnotification" rel=3D"noreferrer" target=
=3D"_blank">https://travis-ci.org/syzzer/<wbr>openvpn/builds/228462383?utm_=
<wbr>source=3Dgithub_status&amp;utm_<wbr>medium=3Dnotification</a></blockqu=
ote><div><br><br></div><div>I test both &quot;cache enabled&quot; and &quot=
;cache purged&quot; builds.<br></div><div>I should add &quot;false&quot; as=
 well ))<br><br><br></div><div>thanks for catching that! I will send &quot;=
v4 soon&quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
To fix this, I propose to create a .travis/build-check.sh script, which<br>
contains the build steps (and set -eu), and call that script from<br>
.travis.yml<br>
<br>
-Steffan<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div><br></div></div>

--001a114e32ee73bbe7054eaf2ebc--

