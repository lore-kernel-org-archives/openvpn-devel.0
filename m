Date: Fri, 10 Nov 2017 17:11:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171110161131.GZ958@...1296...>
References: <3275c6bd-8194-2e23-2e64-3d3fd5d2f090@...2080...>
 <1492184450-11994-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7gzJCi2wfhUHVacz"
Content-Disposition: inline
In-Reply-To: <1492184450-11994-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add --tls-cert-profile option for
 mbedtls builds
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

--7gzJCi2wfhUHVacz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 14, 2017 at 05:40:49PM +0200, Steffan Karger wrote:
> v2:
>  - add documentation (manpage, Changes.rst and --help)
>  - no longer print a warning message on each startup for OpenSSL builds
> v3:
>  - remove format changes in unrelated items (introduced in v2)
>  - Update Changes.rst text to reflect that the default in 2.4.2 is 'legac=
y'
>    and the default in 2.5 will be 'preferred' (as discussed on the ML).
>  - This patch is for the master branch only now (due to the default).

Tested-by: Gert Doering <gert@...1296...>

I've applied this to "master", added "--tls-cert-profile legacy" to my
openvpn command line, and my FreeBSD 10.3 + mbedTLS 2.6.0 t_client tests
came back to "all tests passed".

So from that point of view, this is a necessary addition.

OTOH, it adds a command line option that will lead to a fatal error on
an OpenSSL build, which I'm not happy about (read: it will break the=20
buildslave for openssl builds then...) - so even if we do not have the
functionality for OpenSSL yet, we should still understand the option
and then print out a warning.

(Also it - obviously - does not apply to master anymore, due to
surrounding code changes)


David: Steffan said you did not like this patch -> we should discuss=20
how to improve this / what is missing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7gzJCi2wfhUHVacz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaBc+yAAoJEB2Cnv7KVigSqOQL/0PK8Z5rFsNt3cR99s4JNgqC
pCJywSlM6jOvSm84yGEAWJTJNTlD18Ut8kRgaHeQFrxCyCli40G91mHOfHynnrDc
eiDV+z/fn5HNJ3JpRFPNAnkkzCWeberxaFAemNFvT9YWkppv1v4l/17HAdi68Oz3
srf5QP+iH4AQ+NcQ0smWtyPW5rflHfy3LE3k3kwumWXio/DTDEJSf5o6QZ3x7wfH
cXoyfJ+tiE7jncrI0hqpEcav0z3i4/wa+7OBzTjLMJHLkDAOMetpjxeiDJmJuUrA
+w6or8848tywpq7SsBD36zY/+oVWT7CjHbvX/mnaX6T/AdpbKMm8J9PuQ1E6ibs8
9zVBY5MyvqY1eo3HeI1ZHCg4EC5hXI1nfa4Qj4lv7Pj83P0ib6i0IlFTA225bAVf
n+CIWlw29moRDDTWDIaCcfkYd3NjhrRIfbk6Ky6FNbpX1eatPRUWUXmMedUEhCYM
qUjkyS5YKQNxAFoXQu1rKVeaf+AhG3SL4bTajve3/Q==
=lp2L
-----END PGP SIGNATURE-----

--7gzJCi2wfhUHVacz--

