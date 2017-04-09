MIME-Version: 1.0
In-Reply-To: <7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
	<CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
	<7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 9 Apr 2017 18:31:55 +0500
Message-ID: <CAFHpkQELjBpk4TXNrrOrkMaE1vooH=ZySG6HfQts+RuuPuXGfg@...278...>
Content-Type: multipart/alternative; boundary=001a114b3c2ae461ad054cbbe167
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only
	configurations"
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

--001a114b3c2ae461ad054cbbe167
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-04-09 17:03 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 09-04-17 12:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >
> > 2017-04-09 13:44 GMT+05:00 Steffan Karger <steffan@...1856...
> > <mailto:steffan@...1856...>>:
> >
> >     On 26-03-17 13:21, Ilya Shipitsin wrote:
> >     > +      TAP_CFLAGS=3D"-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}
> /include"
> >     LZO_CFLAGS=3D"-I${PREFIX}/include" LZO_LIBS=3D"-L${PREFIX}/lib -llz=
o2"
> >     PKCS11_HELPER_LIBS=3D"-L${PREFIX}/lib -lpkcs11-helper"
> >     PKCS11_HELPER_CFLAGS=3D"-I${PREFIX}/include" ./configure
> >     --host=3D${CHOST} --build=3Dx86_64-pc-linux-gnu --enable-pkcs11
> >     --disable-plugins || (cat config.log && exit 1);
> >
> >     All these _CFLAGS and _LIBS should go into the env: section above.
> >
> >
> > there are 3 "env" sections: global and 2 "mingw".
> > I'm afraid, defining those variables in global section might have some
> > side effect, while specifying variables 2 times in both mingw sections
> > also do not make much sense.
>
> Good point, my suggestion will not work.  I'm still not quite happy with
> this very long line though.  Maybe put them in something like
> .travis/win_build_vars and source that file from .travis.yml ?  Other
> suggestions are welcome too.
>
> >     Any reason to --enable-pkcs11 for the windows builds, while that's
> not
> >     done for the non-windows builds?
> >
> >
> > regular windows installer is built with pkcs11. that's why I added that
> > option.
>
> Ok.  Makes sense to verify that at least our own Windows builds work.
>
> > build matrix for non-windows builds was discussed and nobody asked me to
> > add pkcs11 there.
>
> I just wondered why the difference, didn't mean to suggest that we need
> to add pkcs11 to the other builds.
>
> >     >  # Enable ccache
> >     > -if [ "${TRAVIS_OS_NAME}" !=3D "osx" ]; then
> >     > +if [ "${TRAVIS_OS_NAME}" !=3D "osx" ] && [ -z "${CHOST+xxx}" ]; =
then
> >     >      # ccache not available on osx, see:
> >     >      # https://github.com/travis-ci/travis-ci/issues/5567
> >     <https://github.com/travis-ci/travis-ci/issues/5567>
> >
> >     Is ccache not available for mingw?  In that case, please update the
> >     comment, preferably with a reference to a travis issue so that we c=
an
> >     enable it if travis adds support later on.
> >
> >
> > I could not get ccache working with mingw, but there's no issue, I'm not
> > sure it is related to travis either.
>
> Ok.  Then just make sure to update the comment so it becomes clear that
> && [ -z "${CHOST+xxx}" ] disables ccache for windows cross compiles.
>
> >     > @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" !=3D "osx" ]; then
> >     >  fi
> >     >
> >     >  # Download and build crypto lib
> >     > -mkdir -p download-cache
> >     >  if [ "${SSLLIB}" =3D "openssl" ]; then
> >     >      download_openssl
> >     >      build_openssl
> >     > @@ -81,3 +94,35 @@ else
> >     >      echo "Invalid crypto lib: ${SSLLIB}"
> >     >      exit 1
> >     >  fi
> >     > +
> >     > +if [ ! -z ${CHOST+xxx} ]; then
> >     > +      echo "deb http://archive.ubuntu.com/ubuntu <
> http://archive.ubuntu.com/ubuntu>
> >     xenial main universe" | sudo tee -a /etc/apt/sources.list.d/
> xenial.list
> >     > +      echo "deb http://archive.ubuntu.com/ubuntu <
> http://archive.ubuntu.com/ubuntu>
> >     xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
> >     > +      sudo apt-get update
> >     > +      sudo apt-get -y install dpkg mingw-w64
> >     > +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSIO=
N}.zip"
> ]; then
> >     > +         wget -P download-cache/ http://build.openvpn.net/
> downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
> >     <http://build.openvpn.net/downloads/releases/tap-
> windows-${TAP_WINDOWS_VERSION}.zip>
> >     > +      fi
> >
> >     This should be in a download_tap_windows() function.
> >
> >
> > can you be more particular on "should be".
> > it does not mean "must be".
> > if so, we can leave it, right ?
>
> I'll be more clear (and less polite..):  writing long lists of commands
> is bad.  That's not only true for code, it goes for scripts as well.
> Writing functions (with good names!) allows the reader to not have to
> parse the commands to understand what the author wanted to do.
>
> If we put this in functions, the pkcs11 section will read
>
>       download_pkcs11helper
>       build_pkcs11helper
>
> Which makes it immediately clear what the intent of that code is.
>
> For tap-windows we only have to download and extract, to that would only
> read
>
>      download_tap_windows
>
> which makes this immediately clear too.
>
> This really is basic software engineering, and the lack of quality in
> quite some of your contributions is an important reason why your
> contributions aren't picked up quickly.  Your ideas and intentions are
> good, but we need to put in far too much effort to make the quality of
> your contribution acceptable.  Time that we can also spend on
> better-quality contributions.  It would help us all (including you) if
> you would try to improve on that.
>


those code lines are not reusable, so not splitting it into functions does
not mean poor quality (for me)
the rule of thumb is "to put into function piece of code, which is called
many times"

otherwise, it might be either function or not.

how did you came to conclusion that it means poor code quality?
is it written somewhere on the https://openvpn.net on how to write bash
scripts ?


>
> -Steffan
>

--001a114b3c2ae461ad054cbbe167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-09 17:03 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 09-04-17 12:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt;<br>
&gt; 2017-04-09 13:44 GMT+05:00 Steffan Karger &lt;<a href=3D"mailto:steffa=
n@...1856...">steffan@...1856...</a><br>
</span>&gt; &lt;mailto:<a href=3D"mailto:steffan@...1856...">steffan@...1852...=
6...</a>&gt;&gt;:<br>
<span class=3D"">&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 26-03-17 13:21, Ilya Shipitsin wrote:<br>
</span><span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
TAP_CFLAGS=3D&quot;-I${PWD}/tap-<wbr>windows-${TAP_WINDOWS_VERSION}<wbr>/in=
clude&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0LZO_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&quot; L=
ZO_LIBS=3D&quot;-L${PREFIX}/lib -llzo2&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0PKCS11_HELPER_LIBS=3D&quot;-L${<wbr>PREFIX}/lib -lp=
kcs11-helper&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0PKCS11_HELPER_CFLAGS=3D&quot;-I${<wbr>PREFIX}/inclu=
de&quot; ./configure<br>
&gt;=C2=A0 =C2=A0 =C2=A0--host=3D${CHOST} --build=3Dx86_64-pc-linux-gnu --e=
nable-pkcs11<br>
&gt;=C2=A0 =C2=A0 =C2=A0--disable-plugins || (cat config.log &amp;&amp; exi=
t 1);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0All these _CFLAGS and _LIBS should go into the env:=
 section above.<br>
&gt;<br>
&gt;<br>
&gt; there are 3 &quot;env&quot; sections: global and 2 &quot;mingw&quot;.<=
br>
&gt; I&#39;m afraid, defining those variables in global section might have =
some<br>
&gt; side effect, while specifying variables 2 times in both mingw sections=
<br>
&gt; also do not make much sense.<br>
<br>
</span>Good point, my suggestion will not work.=C2=A0 I&#39;m still not qui=
te happy with<br>
this very long line though.=C2=A0 Maybe put them in something like<br>
.travis/win_build_vars and source that file from .travis.yml ?=C2=A0 Other<=
br>
suggestions are welcome too.<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0Any reason to --enable-pkcs11 for the windows build=
s, while that&#39;s not<br>
&gt;=C2=A0 =C2=A0 =C2=A0done for the non-windows builds?<br>
&gt;<br>
&gt;<br>
&gt; regular windows installer is built with pkcs11. that&#39;s why I added=
 that<br>
&gt; option.<br>
<br>
</span>Ok.=C2=A0 Makes sense to verify that at least our own Windows builds=
 work.<br>
<span class=3D""><br>
&gt; build matrix for non-windows builds was discussed and nobody asked me =
to<br>
&gt; add pkcs11 there.<br>
<br>
</span>I just wondered why the difference, didn&#39;t mean to suggest that =
we need<br>
to add pkcs11 to the other builds.<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 # Enable ccache<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot=
;osx&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot=
;osx&quot; ] &amp;&amp; [ -z &quot;${CHOST+xxx}&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 # ccache not available on =
osx, see:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://githu=
b.com/travis-ci/travis-ci/issues/5567" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/travis-ci/<wbr>travis-ci/issues/5567</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/travis-ci/travis-=
ci/issues/5567" rel=3D"noreferrer" target=3D"_blank">https://github.com/tra=
vis-ci/<wbr>travis-ci/issues/5567</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Is ccache not available for mingw?=C2=A0 In that ca=
se, please update the<br>
&gt;=C2=A0 =C2=A0 =C2=A0comment, preferably with a reference to a travis is=
sue so that we can<br>
&gt;=C2=A0 =C2=A0 =C2=A0enable it if travis adds support later on.<br>
&gt;<br>
&gt;<br>
&gt; I could not get ccache working with mingw, but there&#39;s no issue, I=
&#39;m not<br>
&gt; sure it is related to travis either.<br>
<br>
</span>Ok.=C2=A0 Then just make sure to update the comment so it becomes cl=
ear that<br>
&amp;&amp; [ -z &quot;${CHOST+xxx}&quot; ] disables ccache for windows cros=
s compiles.<br>
<span class=3D""><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -70,7 +84,6 @@ if [ &quot;${TRAVIS_OS_NAME}=
&quot; !=3D &quot;osx&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 # Download and build crypto lib<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; -mkdir -p download-cache<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 if [ &quot;${SSLLIB}&quot; =3D &quot;ope=
nssl&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 download_openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 build_openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -81,3 +94,35 @@ else<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;Invalid crypto =
lib: ${SSLLIB}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 exit 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +if [ ! -z ${CHOST+xxx} ]; then<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a=
 href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"noreferrer" target=3D"_bl=
ank">http://archive.ubuntu.com/<wbr>ubuntu</a> &lt;<a href=3D"http://archiv=
e.ubuntu.com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ub=
untu.com/<wbr>ubuntu</a>&gt;<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0xenial main universe&quot; | sudo =
tee -a /etc/apt/sources.list.d/<wbr>xenial.list<br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a=
 href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"noreferrer" target=3D"_bl=
ank">http://archive.ubuntu.com/<wbr>ubuntu</a> &lt;<a href=3D"http://archiv=
e.ubuntu.com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ub=
untu.com/<wbr>ubuntu</a>&gt;<br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0xenial main&quot; | sudo tee -a /e=
tc/apt/sources.list.d/<wbr>xenial.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 sudo apt-get update<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 sudo apt-get -y install =
dpkg mingw-w64<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 if [ ! -f &quot;download=
-cache/tap-windows-${<wbr>TAP_WINDOWS_VERSION}.zip&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wget -P dow=
nload-cache/ <a href=3D"http://build.openvpn.net/downloads/releases/tap-win=
dows-${TAP_WINDOWS_VERSION}.zip" rel=3D"noreferrer" target=3D"_blank">http:=
//build.openvpn.net/<wbr>downloads/releases/tap-<wbr>windows-${TAP_WINDOWS_=
VERSION}<wbr>.zip</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://build.openvpn.net/downloads/r=
eleases/tap-windows-${TAP_WINDOWS_VERSION}.zip" rel=3D"noreferrer" target=
=3D"_blank">http://build.openvpn.net/<wbr>downloads/releases/tap-<wbr>windo=
ws-${TAP_WINDOWS_VERSION}<wbr>.zip</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This should be in a download_tap_windows() function=
.<br>
&gt;<br>
&gt;<br>
&gt; can you be more particular on &quot;should be&quot;.<br>
&gt; it does not mean &quot;must be&quot;.<br>
&gt; if so, we can leave it, right ?<br>
<br>
</span>I&#39;ll be more clear (and less polite..):=C2=A0 writing long lists=
 of commands<br>
is bad.=C2=A0 That&#39;s not only true for code, it goes for scripts as wel=
l.<br>
Writing functions (with good names!) allows the reader to not have to<br>
parse the commands to understand what the author wanted to do.<br>
<br>
If we put this in functions, the pkcs11 section will read<br>
<br>
=C2=A0 =C2=A0 =C2=A0 download_pkcs11helper<br>
=C2=A0 =C2=A0 =C2=A0 build_pkcs11helper<br>
<br>
Which makes it immediately clear what the intent of that code is.<br>
<br>
For tap-windows we only have to download and extract, to that would only<br>
read<br>
<br>
=C2=A0 =C2=A0 =C2=A0download_tap_windows<br>
<br>
which makes this immediately clear too.<br>
<br>
This really is basic software engineering, and the lack of quality in<br>
quite some of your contributions is an important reason why your<br>
contributions aren&#39;t picked up quickly.=C2=A0 Your ideas and intentions=
 are<br>
good, but we need to put in far too much effort to make the quality of<br>
your contribution acceptable.=C2=A0 Time that we can also spend on<br>
better-quality contributions.=C2=A0 It would help us all (including you) if=
<br>
you would try to improve on that.<br></blockquote><div><br><br></div><div>t=
hose code lines are not reusable, so not splitting it into functions does n=
ot mean poor quality (for me)<br></div><div>the rule of thumb is &quot;to p=
ut into function piece of code, which is called many times&quot;<br><br></d=
iv><div>otherwise, it might be either function or not.<br><br></div><div>ho=
w did you came to conclusion that it means poor code quality?<br></div><div=
>is it written somewhere on the <a href=3D"https://openvpn.net">https://ope=
nvpn.net</a> on how to write bash scripts ?<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div></div>

--001a114b3c2ae461ad054cbbe167--

