Message-ID: <4F761FEC.1000502@...1114...>
Date: Fri, 30 Mar 2012 23:04:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1329214286-9179-1-git-send-email-dejong@...1435...>
In-Reply-To: <1329214286-9179-1-git-send-email-dejong@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44D9F673E35F0F91C701CFCF"
Subject: Re: [Openvpn-devel] [PATCH 0/3] Use the garbage collector when
 retrieving x509 fields
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44D9F673E35F0F91C701CFCF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/02/12 11:11, Adriaan de Jong wrote:
> A number of the x509 functions allocated memory directly, instead of
> using the default OpenVPN convention: the garbage collector. This is
> fixed in this series of patches.
>=20
> Adriaan

These patches got ACKed by James and me at the developers meeting
yesterday.  They are now applied to the master branch on -testing and
-stable trees.


commit 8e5613c2a8545a67cab2734569a8f088100d731b
Author: Adriaan de Jong <dejong@...1435...>
Date:   Tue Feb 14 11:11:26 2012 +0100

    Migrated x509_get_sha1_hash to use the garbage collector

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: James Yonan <james@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 025f30d7c6434aaf0ab4af3744f76aaf8c0b71d6
Author: Adriaan de Jong <dejong@...1435...>
Date:   Tue Feb 14 11:11:25 2012 +0100

    Migrated x509_get_serial to use the garbage collector

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: James Yonan <james@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 00b973f8af85c3ea8fa3cef80eec55e8dc139b27
Author: Adriaan de Jong <dejong@...1435...>
Date:   Tue Feb 14 11:11:24 2012 +0100

    Migrated x509_get_subject to use of the garbage collector

    This also cleans up a messy call in pkcs11.c to
_openssl_get_subject, as discussed at FOSDEM.

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: James Yonan <james@...515...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig44D9F673E35F0F91C701CFCF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk92H+wACgkQDC186MBRfrp9jwCfW+tnBvlvYxP0ctT+MdbNbJqC
XAcAnRkPc7vURzk9yvTJdlkq3R7P/KHQ
=zkIp
-----END PGP SIGNATURE-----

--------------enig44D9F673E35F0F91C701CFCF--

