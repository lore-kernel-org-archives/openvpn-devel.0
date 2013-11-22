Date: Fri, 22 Nov 2013 11:15:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131122101521.GZ161@...1296...>
References: <OF05315ED1.21B1F5C0-ONC1257C2B.0035DBF4-C1257C2B.00362669@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K7jxEI7rEZN6gxvu"
Content-Disposition: inline
In-Reply-To: <OF05315ED1.21B1F5C0-ONC1257C2B.0035DBF4-C1257C2B.00362669@...1846...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak? (addendum3
	and 4)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: Brad Zhang <hebei5000@...277...>, openvpn-devel@lists.sourceforge.net

--K7jxEI7rEZN6gxvu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 22, 2013 at 10:51:27AM +0100, arno.odermatt@...1845... wrote:
> Dear Gert, Brad all,
>=20
> as I also had reported to have recognized, that memory was not freed, eve=
n=20
>=20
> though the openvpn disconnect-script was disconnecting all of the 3400=20
> Openvpn-sessions (pls see mail below).
> Would you think, this is also improved by the change from malloc to=20
> calloc, so we could update to 2.3.3 to improve the memory-leak situation?

Using malloc() or calloc() will neither affect the total memory used,
nor any fragmentation issues or mem leaks.  It's just about guaranteeing
that allocated memory is zeroed-out.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--K7jxEI7rEZN6gxvu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUo8uuakuBuNlUUl1AQIP+gP/aLOMYO5uguE8a0n2ISu8PDwMKZquBeT5
PPL2LyHOdVegRpezDO2uZaEB4JBL39f+cPYEhINPe2S82MdwQ8bATp3nPFpn/EWI
0J17QBePB86UVY8NTyzoE9WRRp72shtyL3KEGR97JY7YofXW1r4ijILtJnr0a4S2
9QqT2KDmy5A=
=uBS1
-----END PGP SIGNATURE-----

--K7jxEI7rEZN6gxvu--

