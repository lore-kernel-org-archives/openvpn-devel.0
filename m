From: Jeremie Courreges-Anglas <jca@...2272...>
References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
 <20180304161716.GN69387@...1296...>
Date: Sun, 04 Mar 2018 17:47:16 +0100
In-Reply-To: <20180304161716.GN69387@...1296...> (Gert Doering's message
 of "Sun, 4 Mar 2018 17:17:16 +0100")
Message-ID: <87d10jkctn.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Mina Barret <mina.barret@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 04 2018, Gert Doering <gert@...1296...> wrote:

[...]

> "Please note that LibreSSL is not a supported crypto backend. We
>  accept patches and we do test on OpenBSD 6.0 which comes with
>  LibreSSL, but if newer versions of LibreSSL break API compatibility
>  we do not take responsibility to fix that."
>
>
> I think a patch adding these LIBRESSL_VERSION checks has a reasonable
> chance of being ACKed and merged :-) - but LibreSSL support stuff has
> to come from some who cares, so Steffan or Antonio are not going to
> go out and check patches for "will it break LibreSSL?"...

I don't think adding "&& !defined(LIBRESSL_VERSION_NUMBER)" in more
places would be a good idea.  Those checks would do more harm than good
in the long run, preventing the use of new interfaces when they get
implemented by LibreSSL.  Better use function availability checks IMHO.

--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAlqcIxQACgkQDfp0rhUk
5+6YsQ//T3aOOUpCh7azbb08S3bOa1KD6oatXXYkG94sPpRsSlwgo7mVbZM8zF5K
9MlSWqpxBqzGmTZT4a2Ojm/RBlfzG5ZjxI617NzKNocYVW7cGw9dB1NwFQfQBs3D
o0lDRuaG4TVMfO77eWGQT4WVLO4Cpp9ameJRB+a/O65PChZ90fccjGDv2Z6UJD8a
ZTboyNSmvRAu5Lvy69m6pUHrdyW9LWRKLEQZewAUGLwsPAwFKehFTcCzpPskQllt
oes5EqDtthAEMtGPR/Z6dQkkLLPHeszKjqQnr1sJdTe1fOtPsZ7NvTX9EmwCVplv
QF9B1aEOO8yckm/pUHwD3O8BxPaD0eTDnRMJahTxZbU3BRjqEzpypSPw74NoEsfR
nfQE3O2yQeA7siF33v5+1FijYCFtwagbSI5Ufo7O+Vqdt9DYikBrha2zsMrGnX1l
V9wXd3ZIIdRsIG2vnK4sjg3U8Q/dGBtapaZc0mZkLhIBCfGc/TXby3BnYuvQwU80
X39WXdZ7KW0B5AEkYLr2NPwpYdaY+3jzL17EevmdEhP0StX4bg7NNQF4xk/3xFAt
eTNP3MkyrRCKTF6l8gOpmng+b/t95fr+nBebpbumqM0Dz2vaplLckc9osUSjbVoW
/J58PF21VO2opj0+LwkcVyoBpjOBqwgW96J90DUuBIeJkbSKbTU=
=HsOi
-----END PGP SIGNATURE-----
--=-=-=--

