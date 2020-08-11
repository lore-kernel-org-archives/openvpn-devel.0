Date: Tue, 11 Aug 2020 11:58:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811095850.GG75094@...1296...>
References: <20181008214923.11058-3-arne@...1227...>
 <20181010152918.27762-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aJDJANv8BPX70wwH"
Content-Disposition: inline
In-Reply-To: <20181010152918.27762-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/3] Implement the nopadding option
 to management-external-key for mbed TLS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--aJDJANv8BPX70wwH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 10, 2018 at 05:29:18PM +0200, Arne Schwabe wrote:
> Although mbed TLS does not have a TLS 1.3 API yet and we do not really
> know how mbed TLS will handle querying for TLS 1.3 signatures, being
> able to use the same API with OpenSSL and mbed TLS is a nice feature.
>=20
> Since mbed TLS does not expose a way to do pkcs1 padding, copy the
> trimmed down version of the pkcs1 copy to the OpenVPN source code.

What's the state of this patch?

The other parts (management-external-key, TLS 1.3, adjusted padding)
have gone in, but this one got left dangling.

(Patchwork #539)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aJDJANv8BPX70wwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmt/AAoJEB2Cnv7KVigSZIoL/jEHrhh/TeRW/CyMPXVvhiDQ
1BdEaApf0tR8jik1pUgtpGvjz5p/lz2NGRmWecDYp5XAUdiuk4Vtftw4tF5FB8H6
tM+bMxeUpM4Um4cmq3LvvaFt+H7PyDOmtEzOypnpwVPSgkq2RPPHXNYOBi0M5+2H
NOBGu4wo9GPT++rCttaEv1GJphGNpX9CRuXJ1gfWfQ0PwINsP/E+TRqcsQNFxnPm
G2AtNg6aetOm1y5p4DUyqFBJraANcO3cO4VXsfM3VtmdGQC5lDSa8xuiQHljZ/N4
g5ZTcJvKMSnQL5XLr1Sx4uhFw7WSJk04IEB8keI/app7dKGYrHXpiYRESfgJC70c
ZznRVZuPA0yviLNDsvQPcRbNfOf8d4fAkxgx3oiB0NeU4+1qxB2FCZ7IZIGTzPkQ
58lid7Ikiifqq6BMZ1dPyZxvtD9PKigEGXQKIetzDQtqm1dz9H3aqWp6cpdNoXKY
wPpLxBZTOG/OOoGVPZAnhV53aus+nv22ccGMaBd7VA==
=KLuP
-----END PGP SIGNATURE-----

--aJDJANv8BPX70wwH--

