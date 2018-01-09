MIME-Version: 1.0
In-Reply-To: <1515378076-5774-1-git-send-email-selva.nair@...277...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 9 Jan 2018 11:00:18 +0500
Message-ID: <CAFHpkQG9UOK7U+=-dh8EVmeo141iYZMx4JdTNVLz_fssrjWkKg@...278...>
Content-Type: multipart/alternative; boundary="001a114f5cce263bb0056251a1a0"
Subject: Re: [Openvpn-devel] [PATCH 0/2] Make cryptoapicert work with TLS 1.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--001a114f5cce263bb0056251a1a0
Content-Type: text/plain; charset="UTF-8"

2018-01-08 7:21 GMT+05:00 <selva.nair@...277...>:

> From: Selva Nair <selva.nair@...277...>
>
> Hi,
>
> I am not sure how receptive the crypto maintaineres are to the
> idea of adding more code into cryptoapi.c, but here goes:
>
> I've been wanting to add TLS 1.2 support for certs in the
> Windows cert store using management external key. But that's
> a lot more work than extending cryptoapicert support. And,
> rather surprsingly, it turns out that the CNG API for signing is
> easy to use (well after some groping in the dark..) and doesn't
> take much to implement.
>
> So these patches..
>
> The first patch is not really related and to make the existing code
> "openssl-1.1 ready" (missed by past patches as no one probably builds
> Windows binary with 1.1..).
>

there was an agreement on one of the recent community meetings to
gracefully deprecate both libressl and openssl-1.0.X in favour of
openssl-1.1.X

so, we should learn how to build windows binary with 1.1.X :)




>
> The second patch is not dependent on this, but close-by code paths
> are touched by both.
>
> Selva
>
> Selva Nair (2):
>   Bring cryptoapi.c upto speed with openssl 1.1
>   TLS v1.2 support for cryptoapicert -- RSA only
>
>  configure.ac                 |   1 +
>  src/openvpn/Makefile.am      |   2 +-
>  src/openvpn/cryptoapi.c      | 155 ++++++++++++++++++++++++++++++
> ++++---------
>  src/openvpn/openssl_compat.h |  14 ++++
>  src/openvpn/options.c        |  18 -----
>  5 files changed, 140 insertions(+), 50 deletions(-)
>
> --
> 2.1.4
>
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

--001a114f5cce263bb0056251a1a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-08 7:21 GMT+05:00  <span dir=3D"ltr">&lt;<a href=3D"mailto:selv=
a.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span>:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">From: Selva Nair &lt;<a href=3D"mailto:selv=
a.nair@...277...">selva.nair@...277...</a>&gt;<br>
<br>
Hi,<br>
<br>
I am not sure how receptive the crypto maintaineres are to the<br>
idea of adding more code into cryptoapi.c, but here goes:<br>
<br>
I&#39;ve been wanting to add TLS 1.2 support for certs in the<br>
Windows cert store using management external key. But that&#39;s<br>
a lot more work than extending cryptoapicert support. And,<br>
rather surprsingly, it turns out that the CNG API for signing is<br>
easy to use (well after some groping in the dark..) and doesn&#39;t<br>
take much to implement.<br>
<br>
So these patches..<br>
<br>
The first patch is not really related and to make the existing code<br>
&quot;openssl-1.1 ready&quot; (missed by past patches as no one probably bu=
ilds<br>
Windows binary with 1.1..).<br></blockquote><div><br></div><div>there was a=
n agreement on one of the recent community meetings to</div><div>gracefully=
 deprecate both libressl and openssl-1.0.X in favour of</div><div>openssl-1=
.1.X</div><div><br></div><div>so, we should learn how to build windows bina=
ry with 1.1.X :)<br></div><div><br></div><div><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
The second patch is not dependent on this, but close-by code paths<br>
are touched by both.<br>
<br>
Selva<br>
<br>
Selva Nair (2):<br>
=C2=A0 Bring cryptoapi.c upto speed with openssl 1.1<br>
=C2=A0 TLS v1.2 support for cryptoapicert -- RSA only<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
=C2=A0src/openvpn/Makefile.am=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0src/openvpn/cryptoapi.c=C2=A0 =C2=A0 =C2=A0 | 155 +++++++++++++++++++=
+++++++++++<wbr>++++---------<br>
=C2=A0src/openvpn/openssl_compat.h |=C2=A0 14 ++++<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 -----<br>
=C2=A05 files changed, 140 insertions(+), 50 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
2.1.4<br>
<br>
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
</font></span></blockquote></div><br></div></div>

--001a114f5cce263bb0056251a1a0--

