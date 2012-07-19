Message-ID: <500866A7.3010604@...1114...>
Date: Thu, 19 Jul 2012 21:57:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1342013929-10940-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1342013929-10940-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF70E2B941AF261658C2475C4"
Subject: Re: [Openvpn-devel] [PATCH] remove unused show_connection_list
 debug function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF70E2B941AF261658C2475C4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/07/12 15:38, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/init.c |   25 -------------------------
>  1 file changed, 25 deletions(-)
>=20

ACK.  Applied to master.

commit af417baa93f4ebcc545486cbd9635fbc602ba148
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Wed Jul 11 15:38:49 2012 +0200

    remove unused show_connection_list debug function
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1342013929-10940-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6842
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigF70E2B941AF261658C2475C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAIZqcACgkQDC186MBRfrouoQCfdW36hxZrOqosgs/h9DcmzQc4
60cAnRz7Wlzg6g/ASWeJQ+M1OdDy8mIo
=Nb6F
-----END PGP SIGNATURE-----

--------------enigF70E2B941AF261658C2475C4--

