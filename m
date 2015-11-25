MIME-Version: 1.0
In-Reply-To: <SN1PR08MB1391EA7CA6193754DBB6DAEEB9050@...2065...>
References: <564AFAF5.4030004@...515...>
	<CAKuzo_ga8AhYyRHDTktndfXFeP9Yzfw-SBGx4J6ZkBcEGg9tcw@...278...>
	<SN1PR08MB1391C6F144144362BB6BA1B9B9050@...2065...>
	<1584543.znVl45ZabU@...1526...>
	<SN1PR08MB1391EA7CA6193754DBB6DAEEB9050@...2065...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Nov 2015 12:08:09 -0500
Message-ID: <CAKuzo_iewE=FPgN=CzRiBKvhJnABZhF2Yy0sr8Nzaaa0COnUew@...278...>
Content-Type: multipart/alternative; boundary=001a11443d9edc829805256081ba
Subject: Re: [Openvpn-devel] OpenVPN-GUI now on GitHub + other Windows team
	things
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11443d9edc829805256081ba
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 25, 2015 at 11:48 AM, Morris, Russell <rmorris@...1315...>
wrote:

> Hi,
>
> Yep, that makes sense - but Selva was thinking this would ignore the
> libraries for now ... or did I misunderstand?
>

Yes, as a first test its easier to build without openssl and with my
suggested configure command you shouldn't need openssl.

But just found out it needs a small tweak (the original worked for me
because pkg-config was finding the native libcrypto on my machine and thus
not triggering the error you see)

So please run configure again as

./configure --prefix=/ --host=x86_64-w64-mingw32
--build=x86_64-pc-linux-gnu --program-prefix=''
CFLAGS=-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS="-L./"
 OPENSSL_CRYPTO_CFLAGS="-I./"

Its a hack, but should work.

Selva

--001a11443d9edc829805256081ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 25, 2015 at 11:48 AM, Morris, Russell <span dir=3D"ltr">&lt;<a =
href=3D"mailto:rmorris@...1315..." target=3D"_blank">rmorris@...1315...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div id=3D":2xa" class=3D"" style=3D=
"overflow:hidden">Hi,<br>
<br>
Yep, that makes sense - but Selva was thinking this would ignore the librar=
ies for now ... or did I misunderstand?<br></div></blockquote></div><br>Yes=
, as a first test its easier to build without openssl and with my suggested=
 configure command you shouldn&#39;t need openssl.=C2=A0</div><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra">But just found out it ne=
eds a small tweak (the original worked for me because pkg-config was findin=
g the native libcrypto on my machine and thus not triggering the error you =
see)</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">S=
o please run configure again as</div><div class=3D"gmail_extra"><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">./configure --prefix=
=3D/ --host=3Dx86_64-w64-mingw32 --build=3Dx86_64-pc-linux-gnu --program-pr=
efix=3D&#39;&#39; CFLAGS=3D-DDISABLE_CHANGE_PASSWORD OPENSSL_CRYPTO_LIBS=3D=
&quot;-L./&quot; =C2=A0OPENSSL_CRYPTO_CFLAGS=3D&quot;-I./&quot;</div><div><=
br></div><div>Its a hack, but should work.</div><div><br></div><div>Selva</=
div></div><div class=3D"gmail_extra"><br></div></div>

--001a11443d9edc829805256081ba--

