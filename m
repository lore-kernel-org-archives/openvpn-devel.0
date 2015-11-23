Date: Mon, 23 Nov 2015 21:48:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151123204828.GU24952@...1296...>
References: <1373890626-13943-1-git-send-email-mludvig@...1388...>
	<1444553060-15946-1-git-send-email-dejong@...1435...>
	<20151114190545.GY24952@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6GRFrjYdWqOKrmmZ"
Content-Disposition: inline
In-Reply-To: <20151114190545.GY24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH APPLIED] Support for username-only auth
 file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net, Michal Ludvig <mludvig@...1388...>

--6GRFrjYdWqOKrmmZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 14, 2015 at 08:05:45PM +0100, Gert Doering wrote:
> On Sun, Oct 11, 2015 at 10:44:20AM +0200, Adriaan de Jong wrote:
> > Make OpenVPN read the username from the auth file
> > parameter of --auth-user-pass and prompt for a
> > password if it's not in the file.
>=20
> ACK, applied and merged to master.
>=20
> commit 6e9373c84639382c16d9eb8f1f78f60079bb89df
> Author: Michal Ludvig <mludvig@...1388...>
> Date:   Sun Oct 11 10:44:20 2015 +0200

... and cherry-picked to release/2.3 - useful feature, fairly non-intrusive
patch.

commit 76b82f0e9d272a703624b102bd2e2b38d9947afb
Author: Michal Ludvig <mludvig@...1388...>
Date:   Sun Oct 11 10:44:20 2015 +0200

    Support for username-only auth file.

(as discussed in the IRC meeting just now)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6GRFrjYdWqOKrmmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlN7m6kuBuNlUUl1AQKdCAQAoWLT+AKvISBZjDcR0wrF+rrYmFf3u/wp
u5Sgcbe5vCwU7IJgIb7WRNioQ9uf96DXJfnx722lLsUpvd3escSSrbXySepTfSG5
JLB3ZQGgAYkiEkwG4pdY+fqwk48XcXfklBNav+hxNbkDRgqnOCaZzgzNcbN376fy
OdiIhocKFEc=
=VMiC
-----END PGP SIGNATURE-----

--6GRFrjYdWqOKrmmZ--

