Date: Sat, 15 Dec 2012 13:09:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121215120924.GU22465@...1296...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
	<50CC4FB8.8040005@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D9qdZDjLhFh4Fk+E"
Content-Disposition: inline
In-Reply-To: <50CC4FB8.8040005@...1790...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--D9qdZDjLhFh4Fk+E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 15, 2012 at 11:23:52AM +0100, Tore Anderson wrote:
> * Arne Schwabe
>=20
> > This patch contains a number of changes. I did not further spit this
> > since some changes make only sense being changed together.
[..]
>=20
> ACK, I tested several different fail-over scenarios and all worked fine.
> Also all my pre-existing VPNs (maintained by GNOME NetworkManager)
> worked just fine.

Thanks for testing.

Nevertheless, as this is a HUGE change (and needs patch 02/10...09/10 as
prerequisites), I'd put this in 2.4 - so we can release 2.3 "real soon now"=
,=20
without an even longer test/beta/RC phase.

(And yes, this is important work!)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--D9qdZDjLhFh4Fk+E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUMxodKkuBuNlUUl1AQJ06QQAuqrxcUaN8qt8zK7W1a/kAFjas4KEhN72
iaPJ5/IULQ6N1s7lWvvKFMtFauNmVYLI5nc+gjbBzlc9RAcqvKijw50B+3Mlwz2G
mKy8phaD86ftN4q5NWugCpFL/Ewy0OKUXpsAEGfuVkMPoI/t9Ag+aUn4CFcMieBL
MDSpetdoyn4=
=3Csn
-----END PGP SIGNATURE-----

--D9qdZDjLhFh4Fk+E--

