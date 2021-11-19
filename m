MIME-Version: 1.0
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
 <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
 <CAKuzo_gOVrTYqK7s3ZryCSxJmbXE1ogquTDyQfMfZ6GUy4coGA@...278...>
 <CAGyAFMXfhmN+79joNEgcGR9E-+3EMgWyWDCUcC7JAD5bWFvzAA@...278...>
In-Reply-To: <CAGyAFMXfhmN+79joNEgcGR9E-+3EMgWyWDCUcC7JAD5bWFvzAA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Nov 2021 08:56:16 -0500
Message-ID: <CAKuzo_gY+U1KKwLZXiMM=t_2QvJkN3nKxYYhtwzSi2CMrNc9Pg@...278...>
Content-Type: multipart/alternative; boundary="00000000000088040105d124a4d2"
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000088040105d124a4d2
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Nov 19, 2021 at 6:43 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> I've submitted PR to vcpkg's openssl port:
> https://github.com/microsoft/vcpkg/pull/21540
>
> With that PR merged, we could specify proper location of config like
> this (extracted from custom triplet):
>
>   set(OPENSSL_OPENSSLDIR "c:\\Program Files\\OpenVPN\\ssl")
>   set(OPENSSL_NO_INSTALL_SSLDIRS ON)
>

I don't know about vcpkg, but having a way to override prefix and
OPENSSLDIR should help us.

What does the resulting executable when run as  "openssl.exe version -a"?
output for OPENSSLDIR, ENGINESDIR and MODULESDIR? The last one is for
OpenSSL 3+ only and indicates the default location of provider modules like
"legacy".

Selva

--00000000000088040105d124a4d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Fri, Nov 19, 2021 at 6:43 AM Lev Stipakov &lt;<=
a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
I&#39;ve submitted PR to vcpkg&#39;s openssl port:<br>
<a href=3D"https://github.com/microsoft/vcpkg/pull/21540" rel=3D"noreferrer=
" target=3D"_blank">https://github.com/microsoft/vcpkg/pull/21540</a><br>
<br>
With that PR merged, we could specify proper location of config like<br>
this (extracted from custom triplet):<br>
<br>
=C2=A0 set(OPENSSL_OPENSSLDIR &quot;c:\\Program Files\\OpenVPN\\ssl&quot;)<=
br>
=C2=A0 set(OPENSSL_NO_INSTALL_SSLDIRS ON)<br></blockquote><div><br></div><d=
iv>I don&#39;t know about vcpkg, but having a way to override prefix and OP=
ENSSLDIR should help us.</div><div><br></div><div>What does the resulting e=
xecutable when run as=C2=A0 &quot;openssl.exe version -a&quot;? output for =
OPENSSLDIR, ENGINESDIR and MODULESDIR? The last one is for OpenSSL 3+ only =
and indicates the default location of provider modules like &quot;legacy&qu=
ot;.</div><div><br></div><div>Selva</div></div></div>

--00000000000088040105d124a4d2--

