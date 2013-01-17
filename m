Date: Thu, 17 Jan 2013 22:34:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130117213431.GN22465@...1296...>
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
	<50F7257C.9010404@...1800...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BB5Gmd4dKzFH7LVg"
Content-Disposition: inline
In-Reply-To: <50F7257C.9010404@...1800...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mike Tancsa <mike@...1800...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--BB5Gmd4dKzFH7LVg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 16, 2013 at 05:11:08PM -0500, Mike Tancsa wrote:
> 	I have been following the steps to build OpenVPN from the sources and
> was scratching my head as to why the prebuilt binary would work, but my
> build from the sources would bork on --show-pkcs11-ids ?!?!   Searching
> through the mailling list archives shows the patch below, which fixes my
> problem.  It seems that this patch is not in the generic sources?

Reading through the git log for 2.3.0, it most certainly is
(5fd3e56430678bee).

> I was following the directions at
> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyste=
m#Checkingoutopenvpn-buildrepository

On what platform did you build, and for which target?  Which git repository
was checked out, and which branch?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BB5Gmd4dKzFH7LVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPhuZ6kuBuNlUUl1AQL1KwP/WT3qpU3ezock/bQ7E6gxxxZvMWZU8CST
CIQoXyUmELR0UBAtdTYi2nLz5zqO1pRq+RbXEdY/1WKL/ZV4tAzDDted5DvKWwUB
9PfgYd3kcdbDjD5CCWgVA5NxeD8CgkAAqUhSd8tS9tAg2q++HzdOF4ut5gZrJq5I
xoBjqbu4qQU=
=XTCN
-----END PGP SIGNATURE-----

--BB5Gmd4dKzFH7LVg--

