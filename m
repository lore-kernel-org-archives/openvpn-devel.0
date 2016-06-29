MIME-Version: 1.0
In-Reply-To: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 29 Jun 2016 14:08:23 +0500
Message-ID: <CAFHpkQGCv6eR3j4o+31RkdtnpdMeBmg5jnx4yux+YZ8TWojRkQ@...278...>
Content-Type: multipart/alternative; boundary=001a11c3af2e78f6f105366718a7
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11c3af2e78f6f105366718a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ok, I've figured out what fwpuclnt.dll is used for: block_dns feature.


2016-06-29 13:05 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

> Hello,
>
> I'm trying to install openvpn git master on WinXP, no luck, it complains
> on missing fwpuclnt.dll
>
> there's no such dll in WinXP (and it is not possible to supply dll within
> installer)
>
>
>
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/Makefile.am#L1=
30
>
>
> however, I do not see, where it is called in code.
> what is it for ?
>
>
> Cheers,
> Ilya Shipitsin
>

--001a11c3af2e78f6f105366718a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">ok, I&#39;ve figured out what fwpuclnt.dll is used for: bl=
ock_dns feature.<br><br></div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">2016-06-29 13:05 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:c=
hipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span>:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div>Hello,<br><br=
></div>I&#39;m trying to install openvpn git master on WinXP, no luck, it c=
omplains on missing fwpuclnt.dll<br><br></div>there&#39;s no such dll in Wi=
nXP (and it is not possible to supply dll within installer)<br><br><div><br=
><br><a href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/=
Makefile.am#L130" target=3D"_blank">https://github.com/OpenVPN/openvpn/blob=
/master/src/openvpn/Makefile.am#L130</a><br><br><br></div><div>however, I d=
o not see, where it is called in code.<br></div><div>what is it for ?<br><b=
r><br></div><div>Cheers,<br></div><div>Ilya Shipitsin<br></div></div>
</blockquote></div><br></div>

--001a11c3af2e78f6f105366718a7--

