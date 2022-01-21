MIME-Version: 1.0
References: <20220119182126.56880-1-openvpn@...2080...>
 <Yero3Th1c4D74EY8@...1296...>
In-Reply-To: <Yero3Th1c4D74EY8@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 21 Jan 2022 14:09:42 -0500
Message-ID: <CAKuzo_h7LFR0t8LxKHpxi_0fNzzRwJGvFKkC-7RZcj23MxEiaw@...278...>
Content-Type: multipart/alternative; boundary="0000000000007239ab05d61c5d36"
Subject: Re: [Openvpn-devel] [PATCH v3] crypto: Fix OPENSSL_FIPS enabled
 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <openvpn@...2080...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007239ab05d61c5d36
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Jan 21, 2022 at 12:10 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Jan 19, 2022 at 07:21:26PM +0100, David Sommerseth wrote:
> > index 5626e2b6..eb0b1254 100644
> > --- a/src/openvpn/crypto.c
> > +++ b/src/openvpn/crypto.c
> > @@ -34,6 +34,7 @@
> >  #include "error.h"
> >  #include "integer.h"
> >  #include "platform.h"
> > +#include "openssl_compat.h"
> >
> >  #include "memdbg.h"
>
> This breaks compilation for mbedtls builds, depending on which version
> of OpenSSL happens to be installed on the system (if any).
>
> In this particular case, mbedtls build with a system openssl of 0.9.8,
> it blows up with
>
> In file included from crypto.c:37:
> openssl_compat.h: In function 'SSL_CTX_get_min_proto_version':
> openssl_compat.h:635: error: 'SSL_OP_NO_TLSv1_1' undeclared
>                 (first use in this
>
> (and more of this)
>
> which is unsurprising - it's not supposed to pull in these headers
> in the first place.
>

Looking back at it, the patch and the problem it's trying to solve are both
misplaced in crypto.c. That file should be ssl-lib agnostic and openssl
related bits should go to crypto_openssl.c...

I think we need to remove that OPENSSL_FIPS clause and think of providing
that extra info somewhere else if possible.

Selva

--0000000000007239ab05d61c5d36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jan 21, 2022 at 12:10 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Jan 19, 2022 at 07:21:26PM +0100, David Sommerseth wrote:<br>
&gt; index 5626e2b6..eb0b1254 100644<br>
&gt; --- a/src/openvpn/crypto.c<br>
&gt; +++ b/src/openvpn/crypto.c<br>
&gt; @@ -34,6 +34,7 @@<br>
&gt;=C2=A0 #include &quot;error.h&quot;<br>
&gt;=C2=A0 #include &quot;integer.h&quot;<br>
&gt;=C2=A0 #include &quot;platform.h&quot;<br>
&gt; +#include &quot;openssl_compat.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;memdbg.h&quot;<br>
<br>
This breaks compilation for mbedtls builds, depending on which version<br>
of OpenSSL happens to be installed on the system (if any).<br>
<br>
In this particular case, mbedtls build with a system openssl of 0.9.8,<br>
it blows up with<br>
<br>
In file included from crypto.c:37:<br>
openssl_compat.h: In function &#39;SSL_CTX_get_min_proto_version&#39;:<br>
openssl_compat.h:635: error: &#39;SSL_OP_NO_TLSv1_1&#39; undeclared <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (first use in this<=
br>
<br>
(and more of this)<br>
<br>
which is unsurprising - it&#39;s not supposed to pull in these headers<br>
in the first place.<br></blockquote><div><br></div><div>Looking back at it,=
 the patch and the problem it&#39;s trying to solve are both misplaced in c=
rypto.c. That file should be ssl-lib agnostic and openssl related bits shou=
ld go to crypto_openssl.c...</div><div><br></div><div>I think we need to re=
move that OPENSSL_FIPS clause and think of providing that extra info somewh=
ere else if possible.<br></div><div><br></div><div>Selva</div></div></div>

--0000000000007239ab05d61c5d36--

