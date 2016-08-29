MIME-Version: 1.0
In-Reply-To: <5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
	<CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
	<5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
From: Bojan Komazec <bojan.komazec@...277...>
Date: Mon, 29 Aug 2016 10:10:24 +0100
Message-ID: <CAHX+n4sJCs1_YLcvA_QUVd+DqRn_E0pd7fVr+2mQQqrXh3tbWQ@...278...>
Content-Type: multipart/alternative; boundary=089e0102e0b611b0ec053b323cef
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
 match openvpn-install-2.3.12-I601
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--089e0102e0b611b0ec053b323cef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot Samuli.

I cloned "openvpn-build" repo yesterday and created my patch branch off the
last commit on "release/2.3" but after reading your email I checked it out
again and saw that my "release/2.3" was actually 1 commit behind the
origin. I am still trying to understand how this difference happened but
yeah, my patch is not necessary.

Regarding the contribution process, I was reading
https://community.openvpn.net/openvpn/wiki/CodeRepositories page which
states: "All bug fixes should be developed against the master branch, and
where it is decided to include such fixes in a minor release (2.1.x, 2.2.x,
etc), it will be cherry-picked from the master branch and into the suitable
release branches.". This is what made me thinking I should create a patch
for "master" rather than "release/2.3". Did you suggest using release
branch as a target because my patch was not a bug fix (but a simple build
parameter update)?

Bojan

On Mon, Aug 29, 2016 at 9:26 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Il 29/08/2016 11:05, Bojan Komazec ha scritto:
>
>> This is my first attempt to contribute to OpenVpn project. Please let me
>> know if I am doing it right.
>>
>
> Forgot to thank you for your contribution, so here it comes: thank you! :)
>
> When you contribute to openvpn-gui, openvpn-build or easy-rsa you can use
> GitHub pull requests. These PRs will be reviewed an merged in the typical
> GitHub fashion.
>
> Even when contributing to the main OpenVPN project you can send a PR,
> which will then get reviewed in GitHub. Later, when/if the PR has been
> ACKed (=3Daccepted), the patch needs to be sent to this list using
> git-send-email for the final comments (if any), and merged to the codebas=
e.
> =C3=84lternatively you can just send the patch to this list, like you did=
 now.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>
>> Thanks,
>> Bojan
>>
>> On Sun, Aug 28, 2016 at 9:18 PM, Bojan Komazec <bojan.komazec@...277...
>> <mailto:bojan.komazec@...277...>> wrote:
>>
>>     OpenVPN/openvpn-build has to be updated so it fetches and builds
>>     OpenVpn v2.3.12.
>>
>>     From 87a0ca6307ea9c772fc5fa584efc2f2f0f3805a8 Mon Sep 17 00:00:00
>> 2001
>>     From: Bojan Komazec <bojan.komazec@...277...
>>     <mailto:bojan.komazec@...277...>>
>>     Date: Sun, 28 Aug 2016 20:49:02 +0100
>>     Subject: [PATCH] Updated build parameters to match
>>     openvpn-install-2.3.12-I601
>>
>>     Signed-off-by: Bojan Komazec <bojan.komazec@...277...
>>     <mailto:bojan.komazec@...277...>>
>>     ---
>>      generic/build.vars | 2 +-
>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>     diff --git a/generic/build.vars b/generic/build.vars
>>     index ed93a0b..9d44d06 100644
>>     --- a/generic/build.vars
>>     +++ b/generic/build.vars
>>     @@ -5,7 +5,7 @@ OPENSSL_VERSION=3D"${OPENSSL_VERSION:-1.0.1t}"
>>      PKCS11_HELPER_VERSION=3D"${PKCS11_HELPER_VERSION:-1.11}"
>>      LZO_VERSION=3D"${LZO_VERSION:-2.09}"
>>      TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.21.2}"
>>     -OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.11}"
>>     +OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.12}"
>>      OPENVPN_GUI_VERSION=3D"${OPENVPN_GUI_VERSION:-10}"
>>
>>      OPENSSL_URL=3D"${OPENSSL_URL:-http://www.openssl.org/source/o
>> penssl-${OPENSSL_VERSION}.tar.gz
>>     <http://www.openssl.org/source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz
>> >}"
>>     --
>>     2.9.2.windows.1
>>
>>
>>
>>
>>
>
>

--089e0102e0b611b0ec053b323cef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks a lot Samuli.=C2=A0<div><br></div><div>I cloned &qu=
ot;<span style=3D"font-size:12.8px">openvpn-build&quot; repo yesterday and =
created my patch branch off the last commit on &quot;release/2.3&quot; but =
after reading your email I checked it out again and saw that my=C2=A0</span=
><span style=3D"font-size:12.8px">&quot;release/2.3&quot; was actually 1 co=
mmit behind the origin. I am still trying to understand how this difference=
 happened but yeah, my patch is not necessary.</span></div><div><span style=
=3D"font-size:12.8px"><br></span><div><span style=3D"font-size:12.8px">Rega=
rding the contribution process, I was reading=C2=A0<a href=3D"https://commu=
nity.openvpn.net/openvpn/wiki/CodeRepositories">https://community.openvpn.n=
et/openvpn/wiki/CodeRepositories</a> page which states:=C2=A0</span><span s=
tyle=3D"font-size:12.8px">&quot;All bug fixes should be developed against t=
he master branch, and where it is decided to include such fixes in a minor =
release (2.1.x, 2.2.x, etc), it will be cherry-picked from the master branc=
h and into the suitable release branches.</span><span style=3D"font-size:12=
.8px">&quot;. This is what made me thinking I should create a patch for &qu=
ot;master&quot; rather than &quot;release/2.3&quot;. Did you suggest using =
release branch as a target because my patch was not a bug fix (but a simple=
 build parameter update)?=C2=A0</span></div><div><div><div><br></div><div>B=
ojan</div></div></div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Mon, Aug 29, 2016 at 9:26 AM, Samuli Sepp=C3=A4nen <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank">sam=
uli@...515...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span=
 class=3D"">Il 29/08/2016 11:05, Bojan Komazec ha scritto:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This is my first attempt to contribute to OpenVpn project. Please let me<br>
know if I am doing it right.<br>
</blockquote>
<br></span>
Forgot to thank you for your contribution, so here it comes: thank you! :)<=
br>
<br>
When you contribute to openvpn-gui, openvpn-build or easy-rsa you can use G=
itHub pull requests. These PRs will be reviewed an merged in the typical Gi=
tHub fashion.<br>
<br>
Even when contributing to the main OpenVPN project you can send a PR, which=
 will then get reviewed in GitHub. Later, when/if the PR has been ACKed (=
=3Daccepted), the patch needs to be sent to this list using git-send-email =
for the final comments (if any), and merged to the codebase. =C3=84lternati=
vely you can just send the patch to this list, like you did now.<span class=
=3D""><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br><span class=3D"">
Thanks,<br>
Bojan<br>
<br>
On Sun, Aug 28, 2016 at 9:18 PM, Bojan Komazec &lt;<a href=3D"mailto:bojan.=
komazec@...277..." target=3D"_blank">bojan.komazec@...277...</a><br></span>=
<span class=3D"">
&lt;mailto:<a href=3D"mailto:bojan.komazec@...277..." target=3D"_blank">boj=
an.komazec@...2163...<wbr>m</a>&gt;&gt; wrote:<br>
<br>
=C2=A0 =C2=A0 OpenVPN/openvpn-build has to be updated so it fetches and bui=
lds<br>
=C2=A0 =C2=A0 OpenVpn v2.3.12.<br>
<br>
=C2=A0 =C2=A0 From 87a0ca6307ea9c772fc5fa584efc2f<wbr>2f0f3805a8 Mon Sep 17=
 00:00:00 2001<br>
=C2=A0 =C2=A0 From: Bojan Komazec &lt;<a href=3D"mailto:bojan.komazec@...1664...=
7..." target=3D"_blank">bojan.komazec@...277...</a><br></span>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:bojan.komazec@...277..." target=
=3D"_blank">bojan.komazec@...2163...<wbr>m</a>&gt;&gt;<span class=3D""><br>
=C2=A0 =C2=A0 Date: Sun, 28 Aug 2016 20:49:02 +0100<br>
=C2=A0 =C2=A0 Subject: [PATCH] Updated build parameters to match<br>
=C2=A0 =C2=A0 openvpn-install-2.3.12-I601<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Bojan Komazec &lt;<a href=3D"mailto:bojan.koma=
zec@...277..." target=3D"_blank">bojan.komazec@...277...</a><br></span>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:bojan.komazec@...277..." target=
=3D"_blank">bojan.komazec@...2163...<wbr>m</a>&gt;&gt;<span class=3D""><br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0generic/build.vars | 2 +-<br>
=C2=A0 =C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
=C2=A0 =C2=A0 diff --git a/generic/build.vars b/generic/build.vars<br>
=C2=A0 =C2=A0 index ed93a0b..9d44d06 100644<br>
=C2=A0 =C2=A0 --- a/generic/build.vars<br>
=C2=A0 =C2=A0 +++ b/generic/build.vars<br>
=C2=A0 =C2=A0 @@ -5,7 +5,7 @@ OPENSSL_VERSION=3D&quot;${OPENSSL_VER<wbr>SIO=
N:-1.0.1t}&quot;<br>
=C2=A0 =C2=A0 =C2=A0PKCS11_HELPER_VERSION=3D&quot;${PKCS<wbr>11_HELPER_VERS=
ION:-1.11}&quot;<br>
=C2=A0 =C2=A0 =C2=A0LZO_VERSION=3D&quot;${LZO_VERSION:-<wbr>2.09}&quot;<br>
=C2=A0 =C2=A0 =C2=A0TAP_WINDOWS_VERSION=3D&quot;${TAP_WI<wbr>NDOWS_VERSION:=
-9.21.2}&quot;<br>
=C2=A0 =C2=A0 -OPENVPN_VERSION=3D&quot;${OPENVPN_VE<wbr>RSION:-2.3.11}&quot=
;<br>
=C2=A0 =C2=A0 +OPENVPN_VERSION=3D&quot;${OPENVPN_VE<wbr>RSION:-2.3.12}&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0OPENVPN_GUI_VERSION=3D&quot;${OPENVP<wbr>N_GUI_VERSION:=
-10}&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0OPENSSL_URL=3D&quot;${OPENSSL_URL:-<a href=3D"http://ww=
w.openssl.org/source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz" rel=3D"noreferr=
er" target=3D"_blank">h<wbr>ttp://www.openssl.org/source/o<wbr>penssl-${OPE=
NSSL_VERSION}.tar.<wbr>gz</a><br></span>
=C2=A0 =C2=A0 &lt;<a href=3D"http://www.openssl.org/source/openssl-$%7BOPEN=
SSL_VERSION%7D.tar.gz" rel=3D"noreferrer" target=3D"_blank">http://www.open=
ssl.org/source<wbr>/openssl-$%7BOPENSSL_VERSION%<wbr>7D.tar.gz</a>&gt;}&quo=
t;<br>
=C2=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 2.9.2.windows.1<br>
<br>
<br>
<br>
<br>
</blockquote>
<br>
<br>
</blockquote></div><br></div>

--089e0102e0b611b0ec053b323cef--

