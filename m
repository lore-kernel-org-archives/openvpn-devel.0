From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 20 Sep 2011 12:28:30 +0200
References: <4e6f25dc2a58c3.42657146@...1498...> <4E6F73B1.7070600@...515...>
	<4e7850551f9909.15751189@...1498...>
In-Reply-To: <4e7850551f9909.15751189@...1498...>
MIME-Version: 1.0
Message-Id: <201109201228.30353.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Snapshot
	openvpn-2.x-20110909-master-install.exe fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Samuli

On Tuesday 20 September 2011 10:35:33 Krashan Brahmanjara wrote:
> > Krashan: how can I reproduce this? Is trying to connect to an OpenVPN
> > server enough?
>=20
> I installed this package and start openvpnggui only. It doesn't start at
> all.

The GUI runs openvpn during startup to get version information. That's wher=
e=20
the error occurs. ws2_32.dll on Windows XP doesn't have inet_pton and=20
inet_ntop. However, openvpn has its own version of these functions on Windo=
ws.=20
I wonder why the linker is looking for it in the dll? I assume it has=20
something to do with the import library on the build system overriding the=
=20
symbols or maybe it's just that _MSC_VER was not defined. Samuli could you=
=20
investigate?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen

