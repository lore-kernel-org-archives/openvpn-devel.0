Message-ID: <5188CDD1.1010305@...1114...>
Date: Tue, 07 May 2013 11:48:01 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1367759408-16770-1-git-send-email-gert@...1296...>
	<1367826941-22412-1-git-send-email-gert@...1296...>
In-Reply-To: <1367826941-22412-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2QIDXFGCLGAVCFISNVFIL"
Subject: [Openvpn-devel] [PATCH applied] Re: Use constrain_int() instead of
 MIN()+syshead.c compat definition - v2.
Reply-To: openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QIDXFGCLGAVCFISNVFIL
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


Your patch has been applied to the master branch.

commit bd25aa66b76b82f335abbb7377c278a44da194ac
Author: Gert Doering
Date:   Mon May 6 09:55:41 2013 +0200

     Use constrain_int() instead of MIN()+syshead.c compat definition - v2.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...1347...>
     Message-Id: 1367826941-22412-1-git-send-email-gert@...1296...
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7586
     Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


------enig2QIDXFGCLGAVCFISNVFIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGIzdEACgkQDC186MBRfrodHACcDuYnhFWcT9LEsKtSGzp8CDFH
dY8AnRLYVPDFODsErzlg5Qx4aTRpghol
=JHXJ
-----END PGP SIGNATURE-----

------enig2QIDXFGCLGAVCFISNVFIL--

