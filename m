Date: Sun, 19 Nov 2017 22:38:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171119213837.GA80839@...1296...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <201711192037.vAJKbuHH080370@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 19, 2017 at 09:37:56PM +0100, Gert Doering wrote:
> .. of course this conflicts with o->renegotiate_seconds_min...
>=20
> Nevertheless, thanks for the patch :-) - it makes my FreeBSD 10.3=20
> (mbedTLS 2.6) buildslave now happy again (on the default settings - with
> --tls-cert-profile preferred, it refuses the old-hash cert, as it should).
>=20
> Also tested with openssl 1.0.1, where it warns and does nothing, as
> expected.  Good :-)

I *should* have tested with LibreSSL as well...

ssl_openssl.o: In function `tls_ctx_set_cert_profile': /home/buildbot/build=
-openvpn/build-cron2-openbsd-60-amd64-stable-master--disable -lzo--disable-=
management/build/src/openvpn/ssl_openssl.c:404: undefined reference to `SSL=
_CTX_set_security_level'
/home/buildbot/build-openvpn/build-cron2-openbsd-60-amd64-stable-master--di=
sable-lzo--disable-management/build/src/openvpn/ssl_openssl.c:400: undefine=
d reference to `SSL_CTX_set_security_level'

... *roll eyes*

(Not sure, though, why it only complains about two out of three, but
still annoyance...  if LibreSSL claims OPENSSL_VERSION_NUMBER >=3D 0x101000=
00
it better should provide everything needed)

This is on OpenBSD 6.0, which happens to be something Samuli's vagrant
setup can provide nicely if anyone wants to have a look :-)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaEfncAAoJEB2Cnv7KVigSpiQL/jEChQQOHoxWpghhFHUYlq5M
/CljYKT0QA4dHe6zEzLFb/vV6u7DUpsE2zOmCqRcUYYi1Eb9NM456pbn2VeawT0i
p+brR7yDgAsIG7kBkpU+f/cwGjV/1/HtPTGa2cktq9jPQrHUQSGcCb7MWT4IkNkM
j+tmFvNsjURos/Qfjt7inVkj2fxbYATKo1D0vzXYlTDU5g37BvbofCCm2qDFecyp
e7KKz6JrwIJUtSJsNXIEX9E/AdJn9EXuMvGoUXEzu7K+8p7l7tlLMVXXM0s+br4d
GgfQy3wtJDnp6LrATI+AYiTMpzzS37BHRUnmNphrQB1a3l/mVI9H004rqeZB6SNf
XbT/ACx17ooIO1B9kcGBnNgg5UdC/iNGhnoHNiG0XLsFwPQioKU1owbLtBNGqOpW
rnkEQDhsWOyVHX+xhs3to8wefxZ9U++ojhaPkXWDDnUGjOuAvCXAiW9N05QPOWFW
yGcYuaCZRuj5ke0DkkgShg7vG4Z/rbzV52dXTwpHgQ==
=DrD9
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

