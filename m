Date: Mon, 14 Nov 2016 19:46:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161114184616.GQ28918@...1296...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-3-git-send-email-steffan.karger@...1435...>
	<e5e524cb-1b41-2dab-8204-a4e0f49334c7@...1227...>
	<61283c80-0326-8584-5097-c3f31e84d120@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mpzwaonlGz3UQS74"
Content-Disposition: inline
In-Reply-To: <61283c80-0326-8584-5097-c3f31e84d120@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Add control channel encryption
 (--tls-crypt)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--mpzwaonlGz3UQS74
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 13, 2016 at 08:14:05PM +0100, Steffan Karger wrote:
> I have an automated test for this in the OpenVPN-NL test suite, that now
> verifies this works in UDP and TCP modes, and also checks that the
> authentication fails if the wrong keys are used.  And then there are of
> course the unit tests from 5/5.  It would be nice to also add a t_client
> test with --tls-crypt, but I do not maintain that infrastructure.

I'm happy to add that, but for pure practical reasons, this is a bit
cumbersome until the patches are actually *in*.  Please remind me later.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mpzwaonlGz3UQS74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCoGd6kuBuNlUUl1AQLc+gP/SpO8px0SqXzzf0HdOjn1YlyYrfFSADJR
7ZNJ5LKxawuSUArCNJWSyPoGYMZyDcmftmpeM/geA/Rb07PXctusOHQKC7HvnZg4
z3Iie5/+U5rYlADmzKXdigmXzrHiIM5VX30AFEke8qQ9nqMSjsjPApMtidlwNWfs
IFWv/6ydlPg=
=f5jI
-----END PGP SIGNATURE-----

--mpzwaonlGz3UQS74--

