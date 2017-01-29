MIME-Version: 1.0
In-Reply-To: <1485673091-7600-1-git-send-email-chipitsine@...277...>
References: <1485673091-7600-1-git-send-email-chipitsine@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Jan 2017 10:49:42 -0500
Message-ID: <CAKuzo_iJ4s3ikM-sqjFCm-D1O4fE9QE-MF=yqpoAVxFpqtUpCw@...278...>
Content-Type: multipart/alternative; boundary=001a1146fde0f51dcd05473da628
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

--001a1146fde0f51dcd05473da628
Content-Type: text/plain; charset=UTF-8

On Sun, Jan 29, 2017 at 1:58 AM, Ilya Shipitsin <chipitsine@...277...>
wrote:

> MBEDTLS_VERSION, OPENSSL_VERSION were defined twice - in both
> .travis.yml  and .travis/build-deps.sh files, the last one
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
>
> v3: DYLD_LIBRARY_PATH was defined via LD_LIBRARY_PATH by mistake


This should take care of travis builds so ACK from me.

For completeness I will copy what I wrote before:
While this patch is good enough for travis builds,  there is a more general
issue here. I think its the job of libtool to set -rpath properly (and/or
use a wrapper) so that uninstalled test programs pick up the library it was
linked with.

Selva

--001a1146fde0f51dcd05473da628
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Jan 29, 2017 at 1:58 AM, Ilya Shipitsin <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
span class=3D"m_7141687512112534894m_3176133587804690368gmail-">MBEDTLS_VER=
SION, OPENSSL_VERSION were defined twice - in both<br>
.travis.yml=C2=A0 and .travis/build-deps.sh files, the last one<br>
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
<br>
</span>v3: DYLD_LIBRARY_PATH was defined via LD_LIBRARY_PATH by mistake</bl=
ockquote><div><br></div><div>This should take care of travis builds so ACK =
from me.<br><br>For completeness I will copy what I wrote before:<br>While =
this patch is good enough for <span id=3D"m_7141687512112534894m_3176133587=
804690368gmail-m_-1004148434648144806m_-7565827237911351733:430.12">travis<=
/span> builds,=C2=A0 there is a more general issue here. I think its the jo=
b of <span id=3D"m_7141687512112534894m_3176133587804690368gmail-m_-1004148=
434648144806m_-7565827237911351733:430.13">libtool</span> to set -<span id=
=3D"m_7141687512112534894m_3176133587804690368gmail-m_-1004148434648144806m=
_-7565827237911351733:430.14">rpath</span> properly (and/or use a wrapper) =
so that <span id=3D"m_7141687512112534894m_3176133587804690368gmail-m_-1004=
148434648144806m_-7565827237911351733:430.15">uninstalled</span> test progr=
ams pick up the library it was linked with.<br></div></div><br></div><div c=
lass=3D"gmail_extra">Selva<br></div></div>

--001a1146fde0f51dcd05473da628--

