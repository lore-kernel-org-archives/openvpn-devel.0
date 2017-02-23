Date: Thu, 23 Feb 2017 09:03:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170223080347.GA56089@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
 access to the internal of SSL_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logout@...260...
Cc: openvpn-devel@lists.sourceforge.net

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Good morning,

On Fri, Feb 17, 2017 at 11:00:40PM +0100, logout@...260... wrote:
> From: Emmanuel Deloget <logout@...260...>
>=20
> OpenSSL 1.1 does not allow us to directly access the internal of
> any data type, including SSL_CTX. We have to use the defined functions
> to do so.
>=20
> Compatibility with OpenSSL 1.0 is kept by defining the corresponding
> functions when they are not found in the library.
>=20
> Signed-off-by: Emmanuel Deloget <logout@...260...>
> ---
>  configure.ac                 |  9 ++++++
>  src/openvpn/openssl_compat.h | 74 ++++++++++++++++++++++++++++++++++++++=
++++++

This patch brings two problems outside the "OpenSSL functionality"=20
part.

 - openssl_compat.h is not included in the built tarballs, so mingw builds
   fail (and "builds for anyone building from tarballs" would break) ->
   findable by running "make distcheck"

 - configure.ac does something to CentOS 6 / RHEL 6 which makes configure
   explode:

...
checking for linux/if_tun.h... yes
checking tap-windows.h usability... no
checking tap-windows.h presence... no
checking for tap-windows.h... no
checking whether TUNSETPERSIST is declared... yes
checking for setcon in -lselinux... yes
checking for pam_start in -lpam... yes
checking for PKCS11_HELPER... no
./configure: line 21440: syntax error near unexpected token `fi'
./configure: line 21440: `fi'



The first one is easily fixed, but I do not know how to tackle the=20
second one - no access to a CentOS6/RHEL6 box, and not enough autoconf
clue to see this right away.  Patch *looks* good...  most likely just a=20
stray "\" where none should be, or so...

Please :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYrpdiAAoJEB2Cnv7KVigSeZcL/0mhGCul89A3zPFucAR5je4n
Jqp/B1yjWLXYLPkCeQc0VNOxw4gpbTEQhUWt7xtznf4Q6KKLwnS/Ld9csnvlK+5q
o6AIJ+IcStkvPXxCw5aGwAXvymHfBZxX6hAHPdlAez3SxLnMsGXK0BqYYvWbMOqp
yRh9eG7J2ZYZQNgh9lFJvl4oPXK5tmxGcwAGuJfLh1bd1ZolXZqjnXuLaa8cLveN
8aOwLyW0jlru9BmR4AsfdZk5H+LXKR/pXhkOe6M5K6yJALmqcCHMLNQlx9d0eLcr
+Fh4Rc4aelJk/tQ9KEtAxye5yhTw5w6BTZNYd5SCD6dZCvfkNnl1X8S1w4c6d+/l
2/o0lIUj/bWed+xJv59BW0IDIlgRjsydrM3B1NKcqvFCmhkb34dIrypKNMAoolw5
W37/0mF1dPlmeNNEYak236L909xSEg3tpRwRc26hkEr85RACld5sv3rfqTcHxWsH
LW3oskvfsiu1eIhxGA3NIUbn2EI4c0Nc7c6PnV3S0w==
=B4jv
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

