From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 17 Oct 2011 15:44:36 +0200
References: <5688103A-7248-49C3-9DD8-4CF889DC500F@...277...>
	<4E97E60E.5000408@...515...>
In-Reply-To: <4E97E60E.5000408@...515...>
MIME-Version: 1.0
Message-ID: <201110171544.37084.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] Management interface doesn't handle PKCS11
	tokens with umlaut characters in the label
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Aivo, James Bekkema <support@...1515...>

Aivo

On Friday 14 October 2011 09:34:38 Samuli Sepp=E4nen wrote:
> > Would it be possible to patch OpenVPN in some way, so that the umlaut
> > characters doesn't get stripped in the management interface =85 or perh=
aps
> > there's some other, more robust way of handling such kind of smart-card
> > authentication?
>=20
> James, who is responsible for the management interface, can probably fix
> this easily.

Have you checked with git master. I believe commit=20
2627335ac2605d0987a68ce97a0a2c4efbe25159 should have fixed most of the non-
ASCII charset related problems.

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



