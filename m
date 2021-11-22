MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
In-Reply-To: <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Nov 2021 16:33:36 -0500
Message-ID: <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
Content-Type: multipart/alternative; boundary="0000000000009daace05d1676104"
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009daace05d1676104
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Nov 22, 2021 at 3:27 PM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> I added
>
>     _putenv("OPENSSL_CONF=c:\\Temp\\lol.conf");
>
> to openvpn_main() and see
>
>     22:01:38,9512311 openvpn.exe 27668 CreateFile C:\Temp\lol.conf
> NAME NOT FOUND
>
> in procmon. So would it be enough to set config/engines/modules paths
> as env variables for openvpn and gui? OTOH we also ship openssl.exe,
> which is used by easyrsa?
>

I would be a bit wary of distributing OpenSSL libs with "unsafe" built-in
paths, so probably we may still need to get some good defaults in the
build. My concern is that even C:\Program Files\...\ is probably not safe
enough -- I see that curl developers had the same thought.
https://github.com/openssl/openssl/issues/9520#issuecomment-913562621
Not sure how they solved it. I think they cross-build using mingw which is
much easier to handle.

I think setting env vars would give us extra protection as we can detect
the actual location of Program Files or executable's path at run time.

Selva

--0000000000009daace05d1676104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 22, 2021 at 3:27 PM Le=
v Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
,<br>
<br>
I added<br>
<br>
=C2=A0 =C2=A0 _putenv(&quot;OPENSSL_CONF=3Dc:\\Temp\\lol.conf&quot;);<br>
<br>
to openvpn_main() and see<br>
<br>
=C2=A0 =C2=A0 22:01:38,9512311 openvpn.exe 27668 CreateFile C:\Temp\lol.con=
f<br>
NAME NOT FOUND<br>
<br>
in procmon. So would it be enough to set config/engines/modules paths<br>
as env variables for openvpn and gui? OTOH we also ship openssl.exe,<br>
which is used by easyrsa?<br></blockquote><div><br></div><div>I would be a =
bit wary of distributing OpenSSL libs with &quot;unsafe&quot; built-in path=
s, so probably we may still need to get some good defaults in the build. My=
 concern is that even C:\Program Files\...\ is probably not safe enough -- =
I see that curl developers had the same thought. <a href=3D"https://github.=
com/openssl/openssl/issues/9520#issuecomment-913562621">https://github.com/=
openssl/openssl/issues/9520#issuecomment-913562621</a><br></div><div> Not s=
ure how they solved it. I think they cross-build using mingw which is much =
easier to handle.<br></div><div><br></div><div>I think setting env vars wou=
ld give us extra protection as we can detect the actual location of Program=
 Files or executable&#39;s path at run time.<br></div><div><br> </div><div>=
Selva</div></div></div>

--0000000000009daace05d1676104--

