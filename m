References: <59B26C92.1040105@...1147...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <61c0c096-14e8-1e8d-cfc5-7726d667a31f@...515...>
Date: Mon, 11 Sep 2017 10:06:03 +0300
MIME-Version: 1.0
In-Reply-To: <59B26C92.1040105@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] how to roll your own OpenVPN Windows installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

Il 08/09/2017 13:10, Jan Just Keijser ha scritto:
> hi dev list,
>=20
> someone asked me this question: how can one roll their own Windows=20
> OpenVPN installer, including a signed TAP driver?  There's no need to=20
> rebuild OpenVPN or the TAP driver, but they do need to include other=20
> things, such as certificates, config files etc.
> Is there a way to repackage the existing TAP driver?  are there=20
> instructions for that?
>=20
> TIA,
>=20
> JJK
>=20
Hi,

I meant to answer this earlier, but then apparently forgot. The=20
tap-windows installer is simply embedded into the main OpenVPN=20
installer, so the pre-existing, signed tap-windows6 driver can be reused=20
as-is. An OpenVPN installer can be generated in the openvpn-build=20
cross-compile environment:

<https://github.com/OpenVPN/openvpn-build>

Usage of openvpn-build is pretty well documented on Trac:

<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem>

On this page you can find automated cross-compile environment setup=20
scripts which work for Ubuntu 14.04 and 16.04:

<https://community.openvpn.net/openvpn/wiki/SettingUpGenericBuildsystem>

It is also possible to generate a new installer without actually=20
building anything. The challenge is that the NSI install script=20
(openvpn.nsi) in openvpn-build depends on a number of variables set=20
during the build process, and on a certain directory structure. So it is=20
generally easier just to rebuild everything.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

