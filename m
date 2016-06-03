Date: Fri, 3 Jun 2016 20:14:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160603181404.GM53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GhfD4PI+w7CddqFO"
Content-Disposition: inline
In-Reply-To: <1464976163-6162-1-git-send-email-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <dazo@...2145...>

--GhfD4PI+w7CddqFO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 03, 2016 at 07:49:23PM +0200, David Sommerseth wrote:
> From: David Sommerseth <dazo@...2145...>
>=20
> Continuing to fix breakage caused by commit 40cb4cfc5d011102.
[..]

Not having actually tested this, looking at it seems to properly quote
the bits that caused buildbot explosion and "make dist" fails (also as
discussed between David and Samuli on IRC).

So - ACK!  Please apply and let's make the buildbots all green again :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GhfD4PI+w7CddqFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1HI7KkuBuNlUUl1AQIqWwP8Cem09lF/amBChaSa1n2yHdAPhtZG1hJv
DzZNbEnXGuLfQJFMSQlLjTvchXuGnxrA0cMiTXk1sIZxaubpnmhOG5579292BHMR
QmggK6WV1nlHc0XBonnM47qHE8hRkau+gSP3r3DCjpUfCWu9TtZA/DNIk23Vaifh
vKWED8OlWkU=
=fvDO
-----END PGP SIGNATURE-----

--GhfD4PI+w7CddqFO--

