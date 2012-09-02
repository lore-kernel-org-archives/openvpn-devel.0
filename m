Message-ID: <5043B800.6000703@...1114...>
Date: Sun, 02 Sep 2012 21:48:16 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345197113-24636-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345197113-24636-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAF949119DFD2C39A9DD8166F"
Subject: Re: [Openvpn-devel] [PATCH] remove unused flag
	SSLF_NO_NAME_REMAPPING
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF949119DFD2C39A9DD8166F
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/08/12 11:51, Heiko Hund wrote:
> The flag was used with the --no-name-remapping option that was removed
> in commit 5e86fd93779482b90a191f929edebe414cd78a4f.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/ssl_common.h |    1 -
>  1 file changed, 1 deletion(-)

Applied to master.

commit 7f696549251d853a9f40a373501b86cc6e5301e3
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Fri Aug 17 11:51:53 2012 +0200

    remove unused flag SSLF_NO_NAME_REMAPPING

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1345197113-24636-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6986
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigAF949119DFD2C39A9DD8166F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDuAAACgkQDC186MBRfro6+ACdEJ3Q1Zw6unTaE+knIJl4ikqk
ohwAnRqQFgzF5d2C4UvPMbekD14kX4dc
=aAe6
-----END PGP SIGNATURE-----

--------------enigAF949119DFD2C39A9DD8166F--

