Date: Thu, 28 Mar 2019 08:51:12 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190328075111.GE31008@...1296...>
References: <20190327215626.23502-1-rosenp@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20190327215626.23502-1-rosenp@...277...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: Replace not[Before/After]
 functions with get0 variants
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 27, 2019 at 02:56:26PM -0700, Rosen Penev wrote:
> Also removed initialization with OpenSSL 1.1 as it is no longer needed and
> causes compilation errors when disabling deprecated APIs.
>=20
> Same with SSL_CTX_set_ecdh_auto as it got removed.

The Subject: line is a bit misleading - shouldn't this be more something
like "Avoid calling deprecated-API calls of OpenSSL 1.1" or similar?

(People *do* look at commit logs, and the current subject does not cover
making the SSL_library_init() call conditional, etc.)

On the patch itself, I have no strong opinion and would welcome a review
from Steffan or Arne :-) - the Subject: line I can fix at commit time.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcnHzuAAoJEB2Cnv7KVigSkxgL/0qIgkTW7G9WzXMhouI0o4Qy
+gmhOVbvcA22OJC7zbzaRvSP8HvH6q4dyiA3Duq1af2zXglKvpiE9wkiV/bwynZI
E9F2ENLaJC0wDxHtAEwNf+B7DK+Bgj/iYoiOzOIeVqNi/AZA4s2NVdkHAk+t35T7
Undv8XCS0PJIfFLqRL+416OWMcpZCunqt8aSvtmioCEJ+B14g0OrcHAdIV54DtVp
cWlVHmvztjzQCXAi59tqkvnjHQNsOn3l/FhJgBKxY2aHn4Sx6mGE3uTaFqWpj/X9
VEYvwIkF5dJdZ8vbMRNnnASkMJbdpcfxXncyCq3Txtt0SqM6IQtfuLeOMonOBJ3a
DYEeIz235gfD4ent8lwxgE2jCsd9bbJNl7oyj84Fhh+zgIbYBzL8nladllSgX2EU
JAs2C7mNtZLeN+3ipDaEmPGlpl+FQJzGjbAVKqyxRYjlqA24qilbyrTxeIqSiuXm
dTsBO7jONL64T3xKLPvZ9XAclukA4BRT5CtZn0unFg==
=ijSu
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

