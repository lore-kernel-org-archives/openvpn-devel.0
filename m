Message-ID: <504F7E0B.6090603@...1114...>
Date: Tue, 11 Sep 2012 20:08:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1347287973-12398-1-git-send-email-arne@...1227...>
In-Reply-To: <1347287973-12398-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE5BAC9DBDD369AE6B0DC215"
Subject: Re: [Openvpn-devel] [PATCH] Add checks for external-key-managements
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
--------------enigEE5BAC9DBDD369AE6B0DC215
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 10/09/12 16:39, Arne Schwabe wrote:
> Commit 4806cc102655f1a829d656f6deb83e5953c5eab2 fixed only part of
> the problem. Since it removed the filename either the magic filename
> has to be resurrected or all checks against priv_key_file need to
> take to check for MF_EXTERNAL_KEY as well. This patch implements the
> extra checks
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

ACK.  Applied to master.

commit 6dad4f8e924086333d32122432f316a17ae67987
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Sep 10 16:39:33 2012 +0200

    Add checks for external-key-managements
=20=20=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1347287973-12398-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7046
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigEE5BAC9DBDD369AE6B0DC215
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBPfgsACgkQDC186MBRfroO0gCfQSDbCfsvlIKUZg4EFahL0ikJ
E9oAnAu3/Mp7m1Ig1jYe0cnS2OMLLTqP
=JGo5
-----END PGP SIGNATURE-----

--------------enigEE5BAC9DBDD369AE6B0DC215--

