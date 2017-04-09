MIME-Version: 1.0
In-Reply-To: <3b1c076e-4cd9-07f6-dd8c-9c687c0f5eb8@...1856...>
References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
	<CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
	<7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
	<CAFHpkQELjBpk4TXNrrOrkMaE1vooH=ZySG6HfQts+RuuPuXGfg@...278...>
	<3b1c076e-4cd9-07f6-dd8c-9c687c0f5eb8@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 9 Apr 2017 22:10:53 +0500
Message-ID: <CAFHpkQFtJ69J47w1SsSU-8qrmx8-xxT66VgewK2A8Vd4A_R43w@...278...>
Content-Type: multipart/alternative; boundary=001a113c3a1afd9adc054cbef00f
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

--001a113c3a1afd9adc054cbef00f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-04-09 21:58 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 09-04-17 15:31, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >     >     > @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" !=3D "osx" ]; th=
en
> >     >     >  fi
> >     >     >
> >     >     >  # Download and build crypto lib
> >     >     > -mkdir -p download-cache
> >     >     >  if [ "${SSLLIB}" =3D "openssl" ]; then
> >     >     >      download_openssl
> >     >     >      build_openssl
> >     >     > @@ -81,3 +94,35 @@ else
> >     >     >      echo "Invalid crypto lib: ${SSLLIB}"
> >     >     >      exit 1
> >     >     >  fi
> >     >     > +
> >     >     > +if [ ! -z ${CHOST+xxx} ]; then
> >     >     > +      echo "deb http://archive.ubuntu.com/ubuntu
> >     <http://archive.ubuntu.com/ubuntu> <http://archive.ubuntu.com/ubuntu
> >     <http://archive.ubuntu.com/ubuntu>>
> >     >     xenial main universe" | sudo tee -a /etc/apt/sources.list.d/
> xenial.list
> >     >     > +      echo "deb http://archive.ubuntu.com/ubuntu
> >     <http://archive.ubuntu.com/ubuntu> <http://archive.ubuntu.com/ubuntu
> >     <http://archive.ubuntu.com/ubuntu>>
> >     >     xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
> >     >     > +      sudo apt-get update
> >     >     > +      sudo apt-get -y install dpkg mingw-w64
> >     >     > +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_=
VERSION}.zip"
> ]; then
> >     >     > +         wget -P download-cache/ http://build.openvpn.net/
> downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
> >     <http://build.openvpn.net/downloads/releases/tap-
> windows-${TAP_WINDOWS_VERSION}.zip>
> >     >     <http://build.openvpn.net/downloads/releases/tap-
> windows-${TAP_WINDOWS_VERSION}.zip
> >     <http://build.openvpn.net/downloads/releases/tap-
> windows-${TAP_WINDOWS_VERSION}.zip>>
> >     >     > +      fi
> >     >
> >     >     This should be in a download_tap_windows() function.
> >     >
> >     >
> >     > can you be more particular on "should be".
> >     > it does not mean "must be".
> >     > if so, we can leave it, right ?
> >
> >     I'll be more clear (and less polite..):  writing long lists of
> commands
> >     is bad.  That's not only true for code, it goes for scripts as well.
> >     Writing functions (with good names!) allows the reader to not have =
to
> >     parse the commands to understand what the author wanted to do.
> >
> >     If we put this in functions, the pkcs11 section will read
> >
> >           download_pkcs11helper
> >           build_pkcs11helper
> >
> >     Which makes it immediately clear what the intent of that code is.
> >
> >     For tap-windows we only have to download and extract, to that would
> only
> >     read
> >
> >          download_tap_windows
> >
> >     which makes this immediately clear too.
> >
> >     This really is basic software engineering, and the lack of quality =
in
> >     quite some of your contributions is an important reason why your
> >     contributions aren't picked up quickly.  Your ideas and intentions
> are
> >     good, but we need to put in far too much effort to make the quality
> of
> >     your contribution acceptable.  Time that we can also spend on
> >     better-quality contributions.  It would help us all (including you)
> if
> >     you would try to improve on that.
> >
> >
> >
> > those code lines are not reusable, so not splitting it into functions
> > does not mean poor quality (for me)
> > the rule of thumb is "to put into function piece of code, which is
> > called many times"
> >
> > otherwise, it might be either function or not.
>
> Functions are not only to prevent code duplication.  They are also for
> structuring your code.  Which is exactly what I'm suggesting here.  Code
> does not only need to do it's job, it also needs to be maintainable.
>
> > how did you came to conclusion that it means poor code quality?
> > is it written somewhere on the https://openvpn.net on how to write bash
> > scripts ?
>
> We're not here to give software engineering classes.  Nor is the openvpn
> wiki meant to be a book on software engineering.
>

well, I did not ask for software engineering classes.
what I still do not understand is your "ultimate" statement about "poor
code quality".
bash allows either use or not use functions. openvpn does not propose any
standards on that.

so, what I did - I wrote very small piece of code, which fits single
screen, also it is
pretty self documented (wget --> tar --> make). I still think it is good
enough.

yes, we can use functions if people on list would agree on that, but I
think there were not enough reasons for calling that "poor code quality".



>
> -Steffan
>

--001a113c3a1afd9adc054cbef00f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-09 21:58 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 09-04-17 15:31, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -70,7 +84,6 @@ if [=
 &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 # Download and b=
uild crypto lib<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; -mkdir -p download-cac=
he<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 if [ &quot;${SSL=
LIB}&quot; =3D &quot;openssl&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 do=
wnload_openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 bu=
ild_openssl<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -81,3 +94,35 @@ els=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 ec=
ho &quot;Invalid crypto lib: ${SSLLIB}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 ex=
it 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +if [ ! -z ${CHOST+xxx=
} ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
echo &quot;deb <a href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"noreferr=
er" target=3D"_blank">http://archive.ubuntu.com/<wbr>ubuntu</a><br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://archive.ubuntu.com/ubu=
ntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>ub=
untu</a>&gt; &lt;<a href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"norefe=
rrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>ubuntu</a><br>
<span class=3D"">&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://archive.ubun=
tu.com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.c=
om/<wbr>ubuntu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0xenial main universe&quot; =
| sudo tee -a /etc/apt/sources.list.d/<wbr>xenial.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
echo &quot;deb <a href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"noreferr=
er" target=3D"_blank">http://archive.ubuntu.com/<wbr>ubuntu</a><br>
</span>&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://archive.ubuntu.com/ubu=
ntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>ub=
untu</a>&gt; &lt;<a href=3D"http://archive.ubuntu.com/ubuntu" rel=3D"norefe=
rrer" target=3D"_blank">http://archive.ubuntu.com/<wbr>ubuntu</a><br>
<div><div class=3D"h5">&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://archiv=
e.ubuntu.com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ub=
untu.com/<wbr>ubuntu</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0xenial main&quot; | sudo te=
e -a /etc/apt/sources.list.d/<wbr>xenial.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
sudo apt-get update<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
sudo apt-get -y install dpkg mingw-w64<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
if [ ! -f &quot;download-cache/tap-windows-${<wbr>TAP_WINDOWS_VERSION}.zip&=
quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0wget -P download-cache/ <a href=3D"http://build.openvpn.net/do=
wnloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip" rel=3D"noreferrer"=
 target=3D"_blank">http://build.openvpn.net/<wbr>downloads/releases/tap-<wb=
r>windows-${TAP_WINDOWS_VERSION}<wbr>.zip</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://build.openvpn.net/downloads/r=
eleases/tap-windows-${TAP_WINDOWS_VERSION}.zip" rel=3D"noreferrer" target=
=3D"_blank">http://build.openvpn.net/<wbr>downloads/releases/tap-<wbr>windo=
ws-${TAP_WINDOWS_VERSION}<wbr>.zip</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://build=
.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip" rel=
=3D"noreferrer" target=3D"_blank">http://build.openvpn.net/<wbr>downloads/r=
eleases/tap-<wbr>windows-${TAP_WINDOWS_VERSION}<wbr>.zip</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"http://build.openvpn.net/downloads/r=
eleases/tap-windows-${TAP_WINDOWS_VERSION}.zip" rel=3D"noreferrer" target=
=3D"_blank">http://build.openvpn.net/<wbr>downloads/releases/tap-<wbr>windo=
ws-${TAP_WINDOWS_VERSION}<wbr>.zip</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =
fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0This should be in a downloa=
d_tap_windows() function.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; can you be more particular on &quot;should be&=
quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; it does not mean &quot;must be&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; if so, we can leave it, right ?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I&#39;ll be more clear (and less polite..):=C2=A0 w=
riting long lists of commands<br>
&gt;=C2=A0 =C2=A0 =C2=A0is bad.=C2=A0 That&#39;s not only true for code, it=
 goes for scripts as well.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Writing functions (with good names!) allows the rea=
der to not have to<br>
&gt;=C2=A0 =C2=A0 =C2=A0parse the commands to understand what the author wa=
nted to do.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0If we put this in functions, the pkcs11 section wil=
l read<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0download_pkcs11helper<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_pkcs11helper<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Which makes it immediately clear what the intent of=
 that code is.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0For tap-windows we only have to download and extrac=
t, to that would only<br>
&gt;=C2=A0 =C2=A0 =C2=A0read<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 download_tap_windows<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0which makes this immediately clear too.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This really is basic software engineering, and the =
lack of quality in<br>
&gt;=C2=A0 =C2=A0 =C2=A0quite some of your contributions is an important re=
ason why your<br>
&gt;=C2=A0 =C2=A0 =C2=A0contributions aren&#39;t picked up quickly.=C2=A0 Y=
our ideas and intentions are<br>
&gt;=C2=A0 =C2=A0 =C2=A0good, but we need to put in far too much effort to =
make the quality of<br>
&gt;=C2=A0 =C2=A0 =C2=A0your contribution acceptable.=C2=A0 Time that we ca=
n also spend on<br>
&gt;=C2=A0 =C2=A0 =C2=A0better-quality contributions.=C2=A0 It would help u=
s all (including you) if<br>
&gt;=C2=A0 =C2=A0 =C2=A0you would try to improve on that.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; those code lines are not reusable, so not splitting it into functions<=
br>
&gt; does not mean poor quality (for me)<br>
&gt; the rule of thumb is &quot;to put into function piece of code, which i=
s<br>
&gt; called many times&quot;<br>
&gt;<br>
&gt; otherwise, it might be either function or not.<br>
<br>
</div></div>Functions are not only to prevent code duplication.=C2=A0 They =
are also for<br>
structuring your code.=C2=A0 Which is exactly what I&#39;m suggesting here.=
=C2=A0 Code<br>
does not only need to do it&#39;s job, it also needs to be maintainable.<br>
<span class=3D""><br>
&gt; how did you came to conclusion that it means poor code quality?<br>
&gt; is it written somewhere on the <a href=3D"https://openvpn.net" rel=3D"=
noreferrer" target=3D"_blank">https://openvpn.net</a> on how to write bash<=
br>
&gt; scripts ?<br>
<br>
</span>We&#39;re not here to give software engineering classes.=C2=A0 Nor i=
s the openvpn<br>
wiki meant to be a book on software engineering.<br></blockquote><div><br><=
/div><div>well, I did not ask for software engineering classes.<br></div><d=
iv>what I still do not understand is your &quot;ultimate&quot; statement ab=
out &quot;poor code quality&quot;.<br></div><div>bash allows either use or =
not use functions. openvpn does not propose any standards on that.<br><br><=
/div><div>so, what I did - I wrote very small piece of code, which fits sin=
gle screen, also it is <br></div><div>pretty self documented (wget --&gt; t=
ar --&gt; make). I still think it is good enough.<br><br></div><div>yes, we=
 can use functions if people on list would agree on that, but I think there=
 were not enough reasons for calling that &quot;poor code quality&quot;. <b=
r></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div></div>

--001a113c3a1afd9adc054cbef00f--

