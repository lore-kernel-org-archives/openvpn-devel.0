MIME-Version: 1.0
In-Reply-To: <4F4CCEDD.10607@...1147...>
References: <CAOazyz2Rr6JgnmojZ3Naht6eybdq1KnooEAbARSS=3ZM-iLVJg@...278...>
	<4F4B402F.70507@...515...>
	<CAOazyz1xxbxSzHRvS1+3my_86iOQh0Jsvk-G_0+kMLERr0UXog@...278...>
	<6021266.D0OP5FaSJF@...1526...> <4F4CCDD4.4080701@...515...>
	<4F4CCEDD.10607@...1147...>
Date: Tue, 28 Feb 2012 14:59:11 +0200
Message-ID: <CAOazyz1B7ad3i1f=QSVhHsMQTpncTag84bxKOjcbkPumVeM2tg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] openvpn windows gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/2/28 Jan Just Keijser <janjust@...1147...>:
> Samuli Sepp=C3=A4nen wrote:
>>>>
>>>> We should probably write an installer.
>>>>
>>>
>>> I'm not sure if it's the best idea to make each and every GUI project o=
ut
>>> there write it's own installer, when it's mostly a single executable th=
at
>>> needs to be replaced to package it with upstream openvpn. The pragmatic=
 way
>>> to do it would be to leave the GUI stuff in openvpn itself, but I guess=
 you
>>> guys like the idea of bundling installers with other installers, right?
>>>
>>> Heiko
>>
>>
>> Right :). The primary benefit I see in having separate installers for
>> the OpenVPN-GUI, TAP-driver and easy-rsa is the possibility of
>> installing and upgrading each component separately more easily. It might
>> even be possible (=3Dhave not checked) to have the "OpenVPN Windows
>> installer bundle" fetch the latest dependency installers from predefined
>> URLs prior to installation and fallback to included ones if that fails.
>> Not sure if we want do that, but it's an option.
>>
>>
>
> errrr, it would be nice to keep/have a "single click install" option - one
> of the nice features of the current OpenVPN installer is that you get
> everything in one download. Also, it will ensure that there is at least o=
ne
> set of components that works together.
>
> JM2CW,
>
> JJK
>
>

The new Installer installs easy-rsa and openvpn-gui.
Soon also the tap.

Alon.

