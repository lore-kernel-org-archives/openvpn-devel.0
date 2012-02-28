Message-ID: <4F4CCEDD.10607@...1147...>
Date: Tue, 28 Feb 2012 13:55:57 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>	<4F4B402F.70507@...515...>	<CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>	<6021266.D0OP5FaSJF@...1526...>
	<4F4CCDD4.4080701@...515...>
In-Reply-To: <4F4CCDD4.4080701@...515...>
Subject: Re: [Openvpn-devel] openvpn windows gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Samuli Sepp=E4nen wrote:
>>> We should probably write an installer.
>>>=20=20=20=20=20=20=20
>> I'm not sure if it's the best idea to make each and every GUI project ou=
t=20
>> there write it's own installer, when it's mostly a single executable tha=
t=20
>> needs to be replaced to package it with upstream openvpn. The pragmatic =
way to=20
>> do it would be to leave the GUI stuff in openvpn itself, but I guess you=
 guys=20
>> like the idea of bundling installers with other installers, right?
>>
>> Heiko=20
>>=20=20=20=20=20
>
> Right :). The primary benefit I see in having separate installers for
> the OpenVPN-GUI, TAP-driver and easy-rsa is the possibility of
> installing and upgrading each component separately more easily. It might
> even be possible (=3Dhave not checked) to have the "OpenVPN Windows
> installer bundle" fetch the latest dependency installers from predefined
> URLs prior to installation and fallback to included ones if that fails.
> Not sure if we want do that, but it's an option.
>
>=20=20=20
errrr, it would be nice to keep/have a "single click install" option -=20
one of the nice features of the current OpenVPN installer is that you=20
get everything in one download. Also, it will ensure that there is at=20
least one set of components that works together.

JM2CW,

JJK



