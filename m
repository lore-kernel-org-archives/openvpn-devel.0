Date: Thu, 18 Mar 2021 14:56:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210318135631.GB976@...1296...>
References: <20210317181153.83716-1-juliusz@...2525...>
 <202103181321.12IDL2VF012379@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PpvsyVISjOIXJAkF"
Content-Disposition: inline
In-Reply-To: <202103181321.12IDL2VF012379@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support for wolfSSL in
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>
Cc: openvpn-devel@lists.sourceforge.net

--PpvsyVISjOIXJAkF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 18, 2021 at 02:21:02PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> I have not tested actual WolfSSL builds, but done a quick compile test
> to see if it would break old/new openssl or old/new mbedtls configure
> runs.  All works :-)

Well.  That was too fast.

I did not test with older autoconf versions, and it turns out that
PKG_CHECK_VAR() is not supported on older versions - this got introduced
by the WolfSSL patch, and half our buildbots have exploded (Ubuntu 16,
Ubuntu 18, NetBSD 8.1).

So, we need a fix for that... possibly some addition to our m4/ directory,
or a rewrite of this configure.ac hunk.

And we want it quick, because our buildbot infrastructure is half-down
now...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PpvsyVISjOIXJAkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgU1wOAAoJEB2Cnv7KVigSyzcL/1N/TRN0co3Ugz9htBO8iMO8
OBd1so0tb6Kku8kAQsAgsXS62oglhavDFzp4jO5UuEtfyjweR1Prljx+iNw6t39r
QtkJw8wbKp+l6goXg+6dbHKI2LJKII5NHzwSDUark0O2kf9xTWS2hv61TDl0I4WG
EFokeqMVDElsnPiJPYswV1pcAM1GNSgzzRdQkTciRAgT9R4PZ33wd/Gx+pgdJHTL
BmVk2R+PgpA1pwlYsBjouA6O24XQp9OgwLWMgi8OEkkXsp/IfquDLVZAUbjEv0QK
xn5ldJzSCdWUAEtxRQrrtLp9GoDnZ1W5TFwBRl81NbWD3OeKkp0JxP3IFKxgGfYf
ir3cIa2E0CmBxwxU/pKbkJjNrm98HUM/ghDtUMyyJnuhCQYQZN3/Yld1vA/IdLJi
gW8W5WgybNpbZceqNby0q4OdU9DWxOGkbntvukNzAKKZIp0PyGWn6dRQGfyzfsrP
yI1TWEaZ4AW+jzYVs/T6LWhKhxy4mOYFl0Q5o7lFHg==
=bN1j
-----END PGP SIGNATURE-----

--PpvsyVISjOIXJAkF--

