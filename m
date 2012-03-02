From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 2 Mar 2012 09:56:58 +0100
Message-ID: <2587657.DLePWL2mdU@...1526...>
MIME-Version: 1.0
Subject: [Openvpn-devel] GUI size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Samuli,

I've received a question about the size of the snapshot binaries in the iss=
ue=20
tracker yesterday.

https://sourceforge.net/tracker/?func=3Ddetail&atid=3D1327094&aid=3D3496102=
&group_id=3D248281

Could you compile the GUI yourself and link against the openssl crypto DLL =
for=20
the next release? The GUI shouldn't be linked statically if there a=20
libeay32.dll lying next to it, really.

Thanks
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


