Date: Mon, 6 Jun 2016 09:43:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160606074339.GZ53051@...1296...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<20160605172402.GT53051@...1296...>
	<4E34C528-AE50-4620-9587-EF5E04B19FAD@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4JFrVUvC4Ma1CYT3"
Content-Disposition: inline
In-Reply-To: <4E34C528-AE50-4620-9587-EF5E04B19FAD@...2127...>
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
To: Jens Neuhalfen <jens@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--4JFrVUvC4Ma1CYT3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 06, 2016 at 12:44:38AM +0200, Jens Neuhalfen wrote:
> I agree to remove them from the next stable, but honestly think we really
> should go the last step and make them work in master.
>=20
> Is anything besides mingw still an issue with the unit testing patchset?

As far as I can see, with David's latest tweaks, all the buildbots are
happy - all green, no more test fails (well, there was one, but that was
due to two different tests running on the same machine in the same
network namespace, so two openvpn clients trampled on each other's=20
routing table), and building windows installers (=3Dmingw) succeeded as
well.

So, I think we've at least fixed the fallout - and since Steffann reviewed
the patches fairly thoroughly, I assume that they actually work :-)  (have
not had time to look into that and play with cmocka myself)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4JFrVUvC4Ma1CYT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1UpqqkuBuNlUUl1AQIEMwP8CVoqjSGhdfhScy96S0fPhgqo4Gc5Q4NS
0Dohk1Iornnvj3wJ9rZ3c8fIpdrq/b6DnjfJnogwgKqmPThpRySRJUmx/XTxVntO
sKC9W09ZPkS+1WySozWX2uXbNDoC7/TltfYxAQw7s3kluIqFB/mSyPBRaoOkl2Qc
8yKEJhxVMrc=
=p6H7
-----END PGP SIGNATURE-----

--4JFrVUvC4Ma1CYT3--

