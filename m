From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 11 Aug 2011 08:44:53 +0200
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-3-git-send-email-heiko.hund@...1489...>
	<20110810203646.GC8496@...1296...>
In-Reply-To: <20110810203646.GC8496@...1296...>
MIME-Version: 1.0
Message-Id: <201108110844.53606.heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] don't use struct in6_addr s6_addr32
	member anymore
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

On Wednesday 10 August 2011 22:36:47 Gert Doering wrote:
> On Wed, Aug 10, 2011 at 12:55:08PM +0000, Heiko Hund wrote:
> > The s6_addr32 member of struct in6_addr is not available when building
> > for WIN32. To work around this, a local union is defined that allows
> > accessing 32 bit chunks of the IPv6 address passed to add_in6_addr().
>=20
> NAK, that's massively ugly.

o_O
=20
> I've changed the code to do 8-bit rounds.  While somewhat slower, the
> code is actually more readable that way, and since this is only called
> once per connecting client, the few microseconds are well-spent.

ACK, as it fixes the issue

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

