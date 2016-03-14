Date: Mon, 14 Mar 2016 20:58:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160314195809.GQ24952@...1296...>
References: <56E185E9.60506@...515...>
	<1457945194.124630.191.camel@...1866...>
	<56E6AC00.4090700@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zs05zgqpx9/gK3b8"
Content-Disposition: inline
In-Reply-To: <56E6AC00.4090700@...515...>
Subject: Re: [Openvpn-devel] Windows installer with SHA-256 signatures ready
 for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Woodhouse <dwmw2@...1866...>

--zs05zgqpx9/gK3b8
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 14, 2016 at 02:18:08PM +0200, Samuli Sepp=E4nen wrote:
> Lack of the update might become more problematic after I rebuild the=20
> tap-windows6 driver and sign it with our new key, in which case Windows=20
> 7 might reject the driver altogether. So that part requires more=20
> thorough pre-release testing.

The old key is still valid, just not "good enough" for win8+, right?

In that case we might consider building two tap driver packages, one
signed with the vista/win7 key, one with the win8+ key.

Or maybe I'm totally misunderstanding this, so ignore me :)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zs05zgqpx9/gK3b8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVucX0KkuBuNlUUl1AQLORQP/b5PWUAjNrFfRz4NscXDWDCRRslq7crRQ
73xtwmafj3OPdpZCVvEQTQvnS6rWVMLO9KTtRX14Votsb0rIDG1zxcv63zfeKT6B
voGTERr4ZtIPib1AFdQUqiA+pegSF2daFsLL/IU8ENPIrx52N2YsDrseR0nI5T6j
fL3O5cHLRlw=
=lzeK
-----END PGP SIGNATURE-----

--zs05zgqpx9/gK3b8--

