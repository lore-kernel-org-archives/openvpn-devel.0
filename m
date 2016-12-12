References: <CAFHpkQFNRHCCccrSR5ZMCvZj_VC+K=UMR9P4RDhvjCMqGXX1wg@...278...>
	<b79d336b-9d5e-6d7e-a899-06ab10d322d0@...515...>
	<CAFHpkQGsewCStyZ5HHXC9mcwNGN5-_w+BjmmqoHNufd12YZN5w@...278...>
	<e6cfa59d-8424-8cc6-92df-d23e91c3c396@...515...>
	<CAFHpkQGLS1SuebnkZCOJGnMgigqW+zJ7D=qEytUrN9A7uGYHow@...278...>
	<429ef600-ead9-7544-e563-57b1fbf05220@...515...>
	<CAFHpkQERa49dRP1S=g8sybGzCFW47Ytv0T=otOeh+GhGgxMDgw@...278...>
	<c53dbb4e-4c72-4c7a-2b2f-f4708322d409@...515...>
	<CAFHpkQFh=R8Ruv6gNrPK8i+JfV_7c_qdPfMR==0PRN1MpMdtWQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a1ade7b7-47f2-eaca-2bfc-ee0905c44d6a@...515...>
Date: Mon, 12 Dec 2016 13:54:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFh=R8Ruv6gNrPK8i+JfV_7c_qdPfMR==0PRN1MpMdtWQ@...278...>
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

Il 12/12/2016 11:45, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD ha scritto:
>
>         I investigated Fedora (we use CentOS/Fedora) and Debian world.
>         as for Fedora, it is far from being ready (I'll take care of that)
>
>         as for Debian, there's
>         http://deb.debian.org/debian/pool/main/n/nsis/
>         <http://deb.debian.org/debian/pool/main/n/nsis/>
>         <http://deb.debian.org/debian/pool/main/n/nsis/
>         <http://deb.debian.org/debian/pool/main/n/nsis/>>
>         so, I installed ubuntu 16.04, added "debian experimental" (the ab=
ove
>         repo), and voila, I compiled openvpn installer.
>
>         I think we can move to unicode nsis right after 2.4
>
>
>     Excellent news! Once 2.4.0 is out I can again focus on non-release
>     critical things, like updating the build VM.
>
>
>
> for future discussion:
>
> a) adopt building guide (on https://openvpn.net) "nsis3 is required...."
> b) add "Unicode true" to openvpn.nsi + comment that + provide link to
> web page "a)"
> c) check every nsis plugin whether it supports unicode
> d) release installer
> ...
> z) split installer into several language files + choose language
> automatically (I also do not like manual language selection)

Makes sense.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

