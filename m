Date: Sat, 15 Apr 2017 14:34:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170415123455.GH30424@...1296...>
References: <20170413172609.29093-1-davids@...515...>
	<20170415091647.GG30424@...1296...>
	<924aa9d7-bf6e-6428-4d24-9009d36b635f@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Content-Disposition: inline
In-Reply-To: <924aa9d7-bf6e-6428-4d24-9009d36b635f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 15, 2017 at 11:42:30AM +0200, David Sommerseth wrote:
> So reviewing this now, this 12 bit shift may actually fail on big endian
> machines.  It would probably be better to do a full 16 bit shift.
>=20
> But if we don't want to reduce the match set to only version numbers,
> I'm fine with skipping the shifts all together.

Since this is a nice number, comparing with "<" or ">" will just ignore
those lower bits anyway.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY8hNuAAoJEB2Cnv7KVigS7/0L/ib1uKgB/tBHjsMXMOUXRpNq
GvRsjYpjDvFtajB4sVg44W7Idez+PCdq50nHoFxlFBQN5mCzUYgyMPZ324GmCYAu
q/z0PTUY4XzygenZYl5vDc7E6QxpJHZ4PCFDojx+Pdm6KULecjdYHSGWPgMQW7Ru
eCINwDQwq72/D/R2n4VmOVFZca5LhsCqxYCL37b5PnSMuMzZfvdVJzyj8mD/pBU4
8g0JIjQ9OfBPDqsE6RzY5WTTkqqR3Mj7p2zDC0ZoRoZpT3RUYAe/dl3xWBi+2h5E
V9Re2fvZZxnwWEEL/OHroQbJLAA/JKUXl07fwiXi0rMmnZE0fwX6lJglOigku7mQ
sMoTxInOOL7Ut9I9+VQsoCCorbfBMOkdcL7rODdoGMRz5vrKnNDdBVaGyHLV8chW
Qh5pJsVmN3Iqq7qqqMDbd1C8chSALfqoDxQ4xAdaV7FXGEwEfzGNnnq8/dIhi4QE
hmNdrP/jcMdnIOhgaR38ZvzgE9vIyeR8e4M3o8hB+A==
=EQuG
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--

