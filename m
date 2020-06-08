MIME-Version: 1.0
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-3-James.Bottomley@...2316...>
 <20200607111138.GA50189@...1296...>
 <1591567858.4011.15.camel@...2316...>
 <fa1ee755-c255-5985-7104-578e62f96e0a@...1227...>
In-Reply-To: <fa1ee755-c255-5985-7104-578e62f96e0a@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 8 Jun 2020 16:12:56 +0500
Message-ID: <CAFHpkQFdn1HNsbvb9S8hO1rmwnx1bMLpmYF18NEZMXmyGi9Ckw@...278...>
Content-Type: multipart/alternative; boundary="00000000000011bc1d05a790b25d"
Subject: Re: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add
 initialization to pick up local configuration
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: James Bottomley <James.Bottomley@...2317...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000011bc1d05a790b25d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 8 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 15:06, Arne Schwabe=
 <arne@...1227...>:

>
> >
> > Sorry about that.  Best guess is it's missing an include for
> > openssl/conf.h.  You don't need that today because pretty much every
> > other openssl header includes it, but that may not always have been so.
> >
> > Does the below patch fix it?  If it does, it should probably be folded
> > into the other patch.  It should be safe because openssl/conf.h has
> > existed for every version of openssl you support.
>
>
> I am also puzzeld by this. On my local machine the OpenSSL 1.0.2 buildis
> fine without this extra include.
>
> But I am ACKing this alone on the basis that including the conf.h header
> is the corect thing to do (the man page says it should be included)
>
> It fixes the travis build error
> (https://travis-ci.org/github/schwabe/openvpn/builds/695947378) but I do
> not really understand why OpenSSL behaves different there.
>

it might happen if includes are mixed from OS openssl and custom openssl.
I'll have a look (what is include path in travis).



>
> So
>
> Acked-By: Arne Schwabe <arne@...1227...>
>
> >
> > James
> >
> > ---8>8>8><8<8<8---
> > From: James Bottomley <James.Bottomley@...2316...>
> > Subject: [PATCH] crypto_openssl: add include for openssl/conf.h
> >
> > Fix build failure on older versions of openssl.
> >
> > Signed-off-by: James Bottomley <James.Bottomley@...2316...>
> > ---
> >  src/openvpn/crypto_openssl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> > index fd57edd2..94b6d85b 100644
> > --- a/src/openvpn/crypto_openssl.c
> > +++ b/src/openvpn/crypto_openssl.c
> > @@ -43,6 +43,7 @@
> >  #include "crypto_backend.h"
> >  #include "openssl_compat.h"
> >
> > +#include <openssl/conf.h>
> >  #include <openssl/des.h>
> >  #include <openssl/err.h>
> >  #include <openssl/evp.h>
> >
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000011bc1d05a790b25d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 8 =D0=B8=D1=8E=D0=BD. 2=
020 =D0=B3. =D0=B2 15:06, Arne Schwabe &lt;<a href=3D"mailto:arne@...2477...=
.">arne@...1227...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><br>
&gt; <br>
&gt; Sorry about that.=C2=A0 Best guess is it&#39;s missing an include for<=
br>
&gt; openssl/conf.h.=C2=A0 You don&#39;t need that today because pretty muc=
h every<br>
&gt; other openssl header includes it, but that may not always have been so=
.<br>
&gt; <br>
&gt; Does the below patch fix it?=C2=A0 If it does, it should probably be f=
olded<br>
&gt; into the other patch.=C2=A0 It should be safe because openssl/conf.h h=
as<br>
&gt; existed for every version of openssl you support.<br>
<br>
<br>
I am also puzzeld by this. On my local machine the OpenSSL 1.0.2 buildis<br>
fine without this extra include.<br>
<br>
But I am ACKing this alone on the basis that including the conf.h header<br>
is the corect thing to do (the man page says it should be included)<br>
<br>
It fixes the travis build error<br>
(<a href=3D"https://travis-ci.org/github/schwabe/openvpn/builds/695947378" =
rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org/github/schwabe/o=
penvpn/builds/695947378</a>) but I do<br>
not really understand why OpenSSL behaves different there.<br></blockquote>=
<div><br></div><div>it might happen if includes are mixed from OS openssl a=
nd custom openssl.</div><div>I&#39;ll have a look (what is include path in =
travis).<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
So<br>
<br>
Acked-By: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_bl=
ank">arne@...1227...</a>&gt;<br>
<br>
&gt; <br>
&gt; James<br>
&gt; <br>
&gt; ---8&gt;8&gt;8&gt;&lt;8&lt;8&lt;8---<br>
&gt; From: James Bottomley &lt;James.Bottomley@...2316...&gt;<br>
&gt; Subject: [PATCH] crypto_openssl: add include for openssl/conf.h<br>
&gt; <br>
&gt; Fix build failure on older versions of openssl.<br>
&gt; <br>
&gt; Signed-off-by: James Bottomley &lt;James.Bottomley@...2316...&gt;<br>
&gt; ---<br>
&gt;=C2=A0 src/openvpn/crypto_openssl.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl=
.c<br>
&gt; index fd57edd2..94b6d85b 100644<br>
&gt; --- a/src/openvpn/crypto_openssl.c<br>
&gt; +++ b/src/openvpn/crypto_openssl.c<br>
&gt; @@ -43,6 +43,7 @@<br>
&gt;=C2=A0 #include &quot;crypto_backend.h&quot;<br>
&gt;=C2=A0 #include &quot;openssl_compat.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +#include &lt;openssl/conf.h&gt;<br>
&gt;=C2=A0 #include &lt;openssl/des.h&gt;<br>
&gt;=C2=A0 #include &lt;openssl/err.h&gt;<br>
&gt;=C2=A0 #include &lt;openssl/evp.h&gt;<br>
&gt; <br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000011bc1d05a790b25d--

