References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
	<CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <429ef600-ead9-7544-e563-57b1fbf05220@...515...>
Date: Fri, 2 Dec 2016 08:55:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
Subject: Re: [Openvpn-devel] combined ndis5 + ndis6 installer ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
> unicode nsis is different from ansi nsis. for example, nsProcess needs
> different dll.

Ok. More research is needed to see what is involved, then.

> and, unicode nsis is not shipped in most common Linux repo (you need to
> install it separately).

Indeed, that was my impression. So far I've only seen NSIS 2.46 or so in=20
the distribution repositories, and the link I provided talked about NSIS=20
3.0b or something.

> taking the above into account, I think, I should repack the above
> packages as "makensis3" instead of "makensis".

You mean creating deb/rpm packages for updated NSIS? I think manually=20
installing updated NSIS would be good enough, if repackaging proves to=20
be too much of an effort.

>
> @mattock, which linux distro do you use for release building ?

Right now Ubuntu 14.04, but I should upgrade to 16.04 soon.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

