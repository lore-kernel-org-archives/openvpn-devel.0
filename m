Date: Mon, 29 May 2017 16:50:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170529145009.GX97029@...1296...>
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
	<ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
	<36e89683-6f8f-7595-d140-64d64f71b0f0@...277...>
	<2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
	<ebd2f501-ff03-ee3c-7aeb-a10b6e1489ab@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="juLeBF1Sbpsr6d7u"
Content-Disposition: inline
In-Reply-To: <ebd2f501-ff03-ee3c-7aeb-a10b6e1489ab@...277...>
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--juLeBF1Sbpsr6d7u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 29, 2017 at 02:01:14PM +0100, debbie10t wrote:
> FYI:
> pkg-config was only required for --enable-systemd
> Running './configure' only did not need pkg-config.
> I don't know if it is required for any other options.

pkg-config is used for OpenSSL checking, but if it's not there, we fall
back to "just see if it works" - because the BSDs do not (all) have=20
pkg-config files for openssl.

As systemd is linux specific (today), and linux has pkg-config, it needs
to be there...

Maybe our configure should point this out more clearly, that is, if
"--enable-systemd" is given and pkg-config cannot be found, complain
about lack of *pkg-config*...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--juLeBF1Sbpsr6d7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZLDUhAAoJEB2Cnv7KVigSTAcL/RBmK2WTJ+cJYjAHjrLpALiQ
hIiVVluNZgG9wMpMVfdKsurj9zAUCvAafabCehq4Sthf2ky4+ATw/aLS7JQPvgGC
gxsjY76Cfqd7/yV6RH8A4NTw+BqFTE+wol54FZILJOKn4u4qPXe2TitK4YOODgTk
x/Ap9lmdm3YDlrPYo3qLV95VZeK3LGpHeG+CQXscj7ZFNgRO/I3qXrZMWap9mUBv
NVM3PJuGjCYtxnsq8Eoqcz4RKTmkNhIAVdptzWkoCFuqQGiDQoQK+2fEL6OG4uUr
pXiggNOiwxVn9DXrbbYlGgAqjKQIFYhdNokUbTqYAQOSYmL3522Gh3OMFnkyd9Uf
bDDaB9+datHNuBvh87OJVmDLGPPwrFpgpwXuqQ4Bcg9pVYLtFV+uNu189ihpKjRU
/gtjGZLI+MVpKx2O044uQXDMJU3s7raWcp8uixj0wQ+tyeLWOGBUh4AmkYHSO5o3
irfR1RnUSm/2lMEtn8cKtksVDj8dmxkvkCm/6iIhGQ==
=ZCrx
-----END PGP SIGNATURE-----

--juLeBF1Sbpsr6d7u--

