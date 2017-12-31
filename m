MIME-Version: 1.0
In-Reply-To: <70f5d18c-3bbe-0c14-eb0f-54bc10d6019f@...1856...>
References: <20171121063618.13749-1-chipitsine@...277...>
 <70f5d18c-3bbe-0c14-eb0f-54bc10d6019f@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 31 Dec 2017 11:29:41 +0500
Message-ID: <CAFHpkQH1nEfgJrMG2qd-3qP_i9vutxxnrw+eEVhJdkXgcZ3P2Q@...278...>
Content-Type: multipart/alternative; boundary="001a113ed26ab1176505619cfd2c"
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: enable ccache for osx and
 mingw builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113ed26ab1176505619cfd2c
Content-Type: text/plain; charset="UTF-8"

2017-12-30 16:19 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> Sorry for taking so long to respond.
>
> On 21-11-17 07:36, Ilya Shipitsin wrote:
> > --
> > ccache was now tested by me and works for osx
> > and mingw builds as well
>
> By how much does this improve build times?  I'm asking, because I
>

I noticed 1-2 minutes speedup on osx builds. however, it might be
due to brew slowness


> recently noticed that brew on the osx slaves takes a serious amount of
> time.  So I was wondering if we shouldn't try to avoid any brew
> operations for the osx builds.
>

I will add brew to travis-ci cache in "v2"

ccache itself seem to add about zero speedup (and definetly no speedup on
mingw builds)


>
> > ---
> >  .travis.yml           |  2 +-
> >  .travis/build-deps.sh | 14 ++++++--------
> >  2 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 366e6599..8efb1cbd 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -88,7 +88,7 @@ cache:
> >
> >  before_install:
> >    - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
> > -  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
> > +  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo ccache; fi
>
> Before adding ccache here, we could reduce the build time by three
> minutes using --disable-lzo.
>
> >
> >  install:
> >    - if [ ! -z "${CHOST}" ]; then unset CC; fi
> > diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
> > index e787abab..001565f3 100755
> > --- a/.travis/build-deps.sh
> > +++ b/.travis/build-deps.sh
> > @@ -130,15 +130,13 @@ build_openssl () {
> >      fi
> >  }
> >
> > -# Enable ccache
> > -if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z ${CHOST+x} ]; then
> > -    # ccache not available on osx, see:
> > -    # https://github.com/travis-ci/travis-ci/issues/5567
> > -    # also ccache not enabled for cross builds
> > -    mkdir -p "${HOME}/bin"
> > -    ln -s "$(which ccache)" "${HOME}/bin/${CC}"
> > -    PATH="${HOME}/bin:${PATH}"
> > +mkdir -p "${HOME}/bin"
> > +if [ -z ${CHOST+x} ]; then
> > +        ln -s "$(which ccache)" "${HOME}/bin/${CC}"
> > +else
> > +        ln -s "$(which ccache)" "${HOME}/bin/${CHOST}-cc"
> >  fi
> > +PATH="${HOME}/bin:${PATH}"
> >
> >  if [ ! -z ${CHOST+x} ]; then
> >        #
> >
>
> Code-wise the patch looks good.  But curious about your thought on the
> above.
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

--001a113ed26ab1176505619cfd2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-12-30 16:19 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Sorry for taking so long to respond.<br>
<span class=3D""><br>
On 21-11-17 07:36, Ilya Shipitsin wrote:<br>
&gt; --<br>
&gt; ccache was now tested by me and works for osx<br>
&gt; and mingw builds as well<br>
<br>
</span>By how much does this improve build times?=C2=A0 I&#39;m asking, bec=
ause I<br></blockquote><div><br></div><div>I noticed 1-2 minutes speedup on=
 osx builds. however, it might be <br></div><div>due to brew slowness<br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
recently noticed that brew on the osx slaves takes a serious amount of<br>
time.=C2=A0 So I was wondering if we shouldn&#39;t try to avoid any brew<br>
operations for the osx builds.<br></blockquote><div><br></div><div>I will a=
dd brew to travis-ci cache in &quot;v2&quot;</div><div><br></div><div>ccach=
e itself seem to add about zero speedup (and definetly no speedup on mingw =
builds)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; ---<br>
&gt;=C2=A0 .travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-=
<br>
&gt;=C2=A0 .travis/build-deps.sh | 14 ++++++--------<br>
&gt;=C2=A0 2 files changed, 7 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.travis.yml b/.travis.yml<br>
&gt; index 366e6599..8efb1cbd 100644<br>
&gt; --- a/.travis.yml<br>
&gt; +++ b/.travis.yml<br>
&gt; @@ -88,7 +88,7 @@ cache:<br>
&gt;<br>
&gt;=C2=A0 before_install:<br>
&gt;=C2=A0 =C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; =
]; then brew update=C2=A0 =C2=A0 =C2=A0; fi<br>
&gt; -=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; th=
en brew install lzo; fi<br>
&gt; +=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot; ]; th=
en brew install lzo ccache; fi<br>
<br>
</span>Before adding ccache here, we could reduce the build time by three<b=
r>
minutes using --disable-lzo.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;=C2=A0 install:<br>
&gt;=C2=A0 =C2=A0 - if [ ! -z &quot;${CHOST}&quot; ]; then unset CC; fi<br>
&gt; diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh<br>
&gt; index e787abab..001565f3 100755<br>
&gt; --- a/.travis/build-deps.sh<br>
&gt; +++ b/.travis/build-deps.sh<br>
&gt; @@ -130,15 +130,13 @@ build_openssl () {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -# Enable ccache<br>
&gt; -if [ &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quot; ] &amp;&amp; =
[ -z ${CHOST+x} ]; then<br>
&gt; -=C2=A0 =C2=A0 # ccache not available on osx, see:<br>
&gt; -=C2=A0 =C2=A0 # <a href=3D"https://github.com/travis-ci/travis-ci/iss=
ues/5567" rel=3D"noreferrer" target=3D"_blank">https://github.com/travis-ci=
/<wbr>travis-ci/issues/5567</a><br>
&gt; -=C2=A0 =C2=A0 # also ccache not enabled for cross builds<br>
&gt; -=C2=A0 =C2=A0 mkdir -p &quot;${HOME}/bin&quot;<br>
&gt; -=C2=A0 =C2=A0 ln -s &quot;$(which ccache)&quot; &quot;${HOME}/bin/${C=
C}&quot;<br>
&gt; -=C2=A0 =C2=A0 PATH=3D&quot;${HOME}/bin:${PATH}&quot;<br>
&gt; +mkdir -p &quot;${HOME}/bin&quot;<br>
&gt; +if [ -z ${CHOST+x} ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ln -s &quot;$(which ccache)&quot; &quot;$=
{HOME}/bin/${CC}&quot;<br>
&gt; +else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ln -s &quot;$(which ccache)&quot; &quot;$=
{HOME}/bin/${CHOST}-cc&quot;<br>
&gt;=C2=A0 fi<br>
&gt; +PATH=3D&quot;${HOME}/bin:${PATH}&quot;<br>
&gt;<br>
&gt;=C2=A0 if [ ! -z ${CHOST+x} ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 #<br>
&gt;<br>
<br>
</div></div>Code-wise the patch looks good.=C2=A0 But curious about your th=
ought on the<br>
above.<br>
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

--001a113ed26ab1176505619cfd2c--

