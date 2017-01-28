MIME-Version: 1.0
In-Reply-To: <1485590815-19226-1-git-send-email-chipitsine@...277...>
References: <1485590815-19226-1-git-send-email-chipitsine@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 28 Jan 2017 15:29:09 -0500
Message-ID: <CAKuzo_itKRGDSHB_80iNsbkTBHZndm8kjEcq-koK0YJs-99_Ew@...278...>
Content-Type: multipart/alternative; boundary=94eb2c065db47b719705472d7025
Subject: Re: [Openvpn-devel] [PATCH] Resolve several travis-ci issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c065db47b719705472d7025
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Jan 28, 2017 at 3:06 AM, Ilya Shipitsin <chipitsine@...277...>
wrote:

> MBEDTLS_VERSION, OPENSSL_VERSION were defined twice - in both
>  .travis.yml  and .travis/build-deps.sh files, the last one
> defined OPENSSL_VERSION via nonexistent OPENSSL_VERION
> variable, which lead us to use openssl-1.0.1 instead of
> openssl-1.0.2, I removed variable definition from build-deps.sh
>
> "cache: [ apt: true ]" is not a travis supported option, it was
> introduced by mistake, I removed it
>
> LD_LIBRARY_PATH was defined for the entire test run, it includes
> custom openssl build, which was picked by "wget", so "wget"
> could not verify SSL cert at https://www.openssl.org sometimes.
> We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved
> that variable to "script" section
>
> LD_LIBRARY_PATH was defined for both linux and osx environments,
> for the second DYLD_LIBRARY_PATH must be defined instead
>
> v2: Upgrade openssl, mbedtls to the most recent versions
> ---
>  .travis.yml           | 8 ++++----
>  .travis/build-deps.sh | 2 --
>  2 files changed, 4 insertions(+), 6 deletions(-)
>

Moving down the LD_LIBRARY_PATH definition makes sense -- we need it (more
on that below) in the env  to run the test executables, but do not want it
to modify the library search path for installed programs used for package
updates etc.

 script:
> +  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export
> LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
> +  - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export
> DYLD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi


On this platform DYLD_LIBRARY_PATH is what matters, so I think we should be
appending to it instead of redefining it in terms of LD_LIBRARY_PATH. That
is,

DYLD_LIBRARY_PATH="${PREFIX}/lib:${DYLD_LIBRARY_PATH}"

While this patch is good enough for travis builds,  there is a more general
issue here. I think its the job of libtool to set -rpath properly (and/or
use a wrapper) so that uninstalled test programs pick up the library it was
linked with. Else a developer building using custom libs gets wrong
libraries loaded while running tests. A proper fix will eliminate the need
for tweaking LD_LIBRARY_PATH in the first place. But my libtool foo is
virtually nil to suggest a proper solution.

Selva

--94eb2c065db47b719705472d7025
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Jan 28, 2017 at 3:06 AM, <s=
pan id=3D"m_-7565827237911351733:430.1">Ilya</span> <span id=3D"m_-75658272=
37911351733:430.2">Shipitsin</span> <span dir=3D"ltr">&lt;<a href=3D"mailto=
:chipitsine@...277..." target=3D"_blank"><span id=3D"m_-7565827237911351733=
:430.3">chipitsine</span>@gmail.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><span class=3D"m_-7565827237911351733m_=
2116998593314623666m_6767501573257298459m_-992930816600332107gmail-">MBEDTL=
S_VERSION, OPENSSL_VERSION were defined twice - in both<br>
=C2=A0.travis.yml=C2=A0 and .travis/build-deps.sh files, the last one<br>
defined OPENSSL_VERSION via nonexistent OPENSSL_VERION<br>
variable, which lead us to use openssl-1.0.1 instead of<br>
openssl-1.0.2, I removed variable definition from build-deps.sh<br>
<br>
&quot;cache: [ apt: true ]&quot; is not a travis supported option, it was<b=
r>
introduced by mistake, I removed it<br>
<br>
LD_LIBRARY_PATH was defined for the entire test run, it includes<br>
custom openssl build, which was picked by &quot;wget&quot;, so &quot;wget&q=
uot;<br>
could not verify SSL cert at <a href=3D"https://www.openssl.org" rel=3D"nor=
eferrer" target=3D"_blank">https://www.openssl.org</a> sometimes.<br>
We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved<br>
that variable to &quot;script&quot; section<br>
<br>
LD_LIBRARY_PATH was defined for both linux and osx environments,<br>
for the second DYLD_LIBRARY_PATH must be defined instead<br>
<br>
v2: Upgrade openssl, mbedtls to the most recent versions<br>
---<br>
</span>=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8 ++++--=
--<br>
=C2=A0.travis/build-deps.sh | 2 --<br>
=C2=A02 files changed, 4 insertions(+), 6 deletions(-)<br></blockquote><div=
><br></div><div>Moving down the <span id=3D"m_-7565827237911351733:430.4">L=
D</span>_LIBRARY_PATH definition makes sense -- we need it (more on that be=
low) in the <span id=3D"m_-7565827237911351733:430.5">env</span>=C2=A0 to r=
un the test <span id=3D"m_-7565827237911351733:430.6">executables</span>, b=
ut do not want it to modify the library search path for installed programs =
used for package updates etc.<br></div><span class=3D"m_-756582723791135173=
3m_2116998593314623666m_6767501573257298459m_-992930816600332107gmail-"></s=
pan><br><span class=3D"m_-7565827237911351733m_2116998593314623666m_6767501=
573257298459m_-992930816600332107gmail-"></span><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><span class=3D"m_-7565827237911351733m_2116998593314=
623666m_6767501573257298459m_-992930816600332107gmail-">
=C2=A0script:<br>
</span>+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]=
; then export LD_LIBRARY_PATH=3D&quot;${PREFIX}/lib<wbr>:${LD_LIBRARY_PATH}=
&quot;; fi<br>
+=C2=A0 - if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;osx&quot;=C2=A0 =C2=
=A0]; then export DYLD_LIBRARY_PATH=3D&quot;${PREFIX}/l<wbr>ib:${LD_LIBRARY=
_PATH}&quot;; fi</blockquote><div>=C2=A0</div><div>On this platform <span i=
d=3D"m_-7565827237911351733:430.7">DYLD</span>_LIBRARY_PATH is what matters=
, so I think we should be appending to it instead of redefining it in terms=
 of <span id=3D"m_-7565827237911351733:430.8">LD</span>_LIBRARY_PATH. That =
is,<br><br><span id=3D"m_-7565827237911351733:430.9">DYLD</span>_LIBRARY_PA=
TH=3D&quot;${PREFIX}/l<span id=3D"m_-7565827237911351733:430.10"><wbr>ib</s=
pan>:${<span id=3D"m_-7565827237911351733:430.11">DYLD</span>_LIBRARY_PATH}=
&quot;<br></div></div><br></div><div class=3D"gmail_extra">While this patch=
 is good enough for <span id=3D"m_-7565827237911351733:430.12">travis</span=
> builds,=C2=A0 there is a more general issue here. I think its the job of =
<span id=3D"m_-7565827237911351733:430.13">libtool</span> to set -<span id=
=3D"m_-7565827237911351733:430.14">rpath</span> properly (and/or use a wrap=
per) so that <span id=3D"m_-7565827237911351733:430.15">uninstalled</span> =
test programs pick up the library it was linked with. Else a developer buil=
ding using custom <span id=3D"m_-7565827237911351733:430.16"></span>libs ge=
ts wrong libraries loaded while running tests. A proper fix will eliminate =
the need for tweaking <span id=3D"m_-7565827237911351733:430.17">LD</span>_=
LIBRARY_PATH in the first place. But my <span id=3D"m_-7565827237911351733:=
430.18">libtool</span> foo is virtually nil to suggest a proper solution.<b=
r><br><span id=3D"m_-7565827237911351733:430.19">Selva</span><br></div></di=
v>

--94eb2c065db47b719705472d7025--

