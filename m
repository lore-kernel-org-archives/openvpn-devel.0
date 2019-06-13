References: <011b01d52164$d8d48430$8a7d8c90$@gmail.com>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a9c0d024-ebaa-cdab-c979-d2dbfd081359@...515...>
Date: Thu, 13 Jun 2019 10:08:39 +0300
MIME-Version: 1.0
In-Reply-To: <011b01d52164$d8d48430$8a7d8c90$@gmail.com>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Win-ARM64 POC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Dan Haim <negativeiq@...277...>, openvpn-devel@lists.sourceforge.net


Hi,

Il 13/06/19 00:21, Dan Haim ha scritto:
> Hello,
>=20
> I've just managed to compile a Windows on ARM64 port of OpenVPN. If you
> happen to have a Windows on ARM laptop (ARM64, not the old RT) I'd like
> to hear from you and help test things out. I've uploaded it here for the
> time being =96

I should receive an ARM64 Windows test device "soon". I will remind the
people who are supposed to send it to me. Then I can test your build.

>=20
> https://www79.zippyshare.com/v/e8nKxDm9/file.html
>=20
> =A0
>=20
> Obviously it's only partial, there's no installer and no GUI but
> otherwise seems to work. If you have a decent VPN connection I'd

I suppose standard x86 OpenVPN GUI should work, as it communicates with
OpenVPN through the management interface. Did you try that out?

> appreciate if you could run a speed test because hopefully running out
> of the x86 emulator should increase performance and therefore bandwidth,
> problem is my current router is a bit slow so it'd be the bottleneck
> anyway (so I currently have no way of testing). It should also help
> conserve battery power.
>=20
> With that being said I had to compile the OpenSSL libraries with no-asm
> so it may impair performance a little bit (I used OpenSSL v1.0.2s, which
> doesn't officially support the platform and required multiple makefile
> hacks to compile, v1.1.x may be better).
>=20
> =A0
>=20
> Overall I needed to mess with a lot of compiler settings, mainly for
> OpenSSL and also a bit for OpenVPN itself but didn't change any actual
> code. The whole project took about ~5 hours.
>=20
> =A0
>=20
> I would like again to ask for feedback from other owners of such
> laptops, especially how this build compares to the x86 version in terms
> of speed and battery usage. Also I'd like to inquire what would it take
> to wrap it in a decent installer and whether an eventual official
> release can be considered.
>=20
> =A0
>=20
> =A0
>=20
> Sorry for the long message
>=20
> Cheers,
>=20
> Dan.
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

