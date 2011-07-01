From: Heiko Hund <hhund@...194...>
Date: Fri, 1 Jul 2011 19:29:47 +0200
References: <4E0DD5E4.2040609@...515...>
In-Reply-To: <4E0DD5E4.2040609@...515...>
MIME-Version: 1.0
Message-Id: <201107011929.47404.hhund@...194...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (30th June 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Friday 01 July 2011 16:12:52 Samuli Sepp=E4nen wrote:
> Discussed the domake-win (mingw) and Python-based buildsystems used on
> Windows:
>=20
> <https://community.openvpn.net/openvpn/wiki/BuildingOnWindows>
>=20
> Agreed that the domake-win buildsystem will has some rough edges and it
> needs modernization. It was also agreed that it should be maintained
> even though official releases are now built with the Python-based
> buildsystem. Two primary motivations for this were cross-compiling and
> the ability to build OpenVPN on Windows without Visual Studio. Nobody
> volunteered to take the role of domake-win maintainer.

Have you guys considered autotools for building native WIN32 binaries in=20
cygwin? We use it for building openvpn itself. With a little effort one cou=
ld=20
even build the driver, sign the binaries and create the installer using mak=
e=20
targets.

I'm not sure if that would be more convenient for the majority of the peopl=
e=20
building openvpn for Windows, but it feels more like home to me. =3D)

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro GmbH & Co. KG | Amalienbadstra=DFe 41/Bau 52 | 76227 Karlsruhe | Ger=
many
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
An der RaumFabrik 33a | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

