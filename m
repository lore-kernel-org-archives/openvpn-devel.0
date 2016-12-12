References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
	<CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
	<429ef600-ead9-7544-e563-57b1fbf05220@...515...>
	<CAFHpkQERa49dRP1S=g8sybGzCFW47Ytv0T=otOeh+GhGgxMDgw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c53dbb4e-4c72-4c7a-2b2f-f4708322d409@...515...>
Date: Mon, 12 Dec 2016 10:46:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQERa49dRP1S=g8sybGzCFW47Ytv0T=otOeh+GhGgxMDgw@...278...>
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

Il 12/12/2016 08:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>
> 2016-12-02 11:55 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>
>     Il 02/12/2016 05:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD ha scritto:
>
>         unicode nsis is different from ansi nsis. for example, nsProcess
>         needs
>         different dll.
>
>
>     Ok. More research is needed to see what is involved, then.
>
>         and, unicode nsis is not shipped in most common Linux repo (you
>         need to
>         install it separately).
>
>
>     Indeed, that was my impression. So far I've only seen NSIS 2.46 or
>     so in the distribution repositories, and the link I provided talked
>     about NSIS 3.0b or something.
>
>         taking the above into account, I think, I should repack the above
>         packages as "makensis3" instead of "makensis".
>
>
>     You mean creating deb/rpm packages for updated NSIS? I think
>     manually installing updated NSIS would be good enough, if
>     repackaging proves to be too much of an effort.
>
>
> I investigated Fedora (we use CentOS/Fedora) and Debian world.
> as for Fedora, it is far from being ready (I'll take care of that)
>
> as for Debian, there's http://deb.debian.org/debian/pool/main/n/nsis/
> <http://deb.debian.org/debian/pool/main/n/nsis/>
> so, I installed ubuntu 16.04, added "debian experimental" (the above
> repo), and voila, I compiled openvpn installer.
>
> I think we can move to unicode nsis right after 2.4

Excellent news! Once 2.4.0 is out I can again focus on non-release=20
critical things, like updating the build VM.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

