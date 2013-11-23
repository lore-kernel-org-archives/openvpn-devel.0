Date: Sat, 23 Nov 2013 13:13:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131123121335.GA27496@...1296...>
References: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
	<1379587649-25506-2-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <1379587649-25506-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Refactor
	tls_ctx_use_external_private_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 19, 2013 at 12:47:27PM +0200, steffan.karger@...1435... wrote:
> From: Joachim Schipper <joachim.schipper@...1435...>
>=20
> OpenSSL's tls_ctx_load_cert_file() had a parameter in which a copy of the
> context's certificate chain was stored on return, used by
> tls_ctx_use_external_private_key() only and free()d immediately thereafte=
r.
>=20
> PolarSSL also supported this output parameter, but returned a pointer to =
the
> context's certificate chain (rather than to a copy of the certificate, as
> OpenSSL does) - which meant that we would have to #ifdef the free().
>=20
> PolarSSL cannot make a copy of a certificate chain, and OpenSSL cannot st=
ore a
> pointer to (instead of a copy of) the cert.
>=20
> So remove the output parameter from tls_ctx_load_cert_file() and incorpor=
ate
> the needed functionality directly into tls_ctx_use_external_private_key()
> (which is straightforward for both OpenSSL and PolarSSL, as long as you d=
on't
> try to support both at once.)

While I'm sure this works all nice and dandy for PolarSSL builds, it
blows up for me for OpenSSL builds (in master)...

ssl_openssl.o: In function `tls_ctx_load_cert_file': /rhome/gert/src/openvp=
n-maint/test-build-master/src/openvpn/../../../openvpn/src/openvpn/ssl_open=
ssl.c:537: undefined reference to `tls_ctx_load_cert_file_ext'
ssl_openssl.o: In function `tls_ctx_use_external_private_key': /rhome/gert/=
src/openvpn-maint/test-build-master/src/openvpn/../../../openvpn/src/openvp=
n/ssl_openssl.c:687: undefined reference to `tls_ctx_load_cert_file_ext'
collect2: ld returned 1 exit status

This is on a gentoo installation with openssl 1.0.1c - does it need
a more recent version?  Is this based on other patches that we've not
seen yet?

(I'd NAK it, but since it's in and pushed - should have done a test-build
myself, instead of just relying on the buildslaves - could you please=20
send a fix?)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUpCb76kuBuNlUUl1AQLMVgP/WmZBBoL60IRo8WmtB4GIBtRYCiZ8DoEI
QouejTm+Qr+Ify7/a4LnJPIzBoE0ZS2T9kZ1SCW+1YpkIb/YJXVqpMEIqeINN0id
3Ufa7j4WpxupZ7xnO3kfesBRx0BettXR2koXvworOW9HjJx4RYl4hvtVB/ODgcyL
aUvdvaJ1SAo=
=0BTr
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

