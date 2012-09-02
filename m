Message-ID: <5043B7FA.7070602@...1114...>
Date: Sun, 02 Sep 2012 21:48:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345141883-9889-1-git-send-email-gert@...1296...>
	<1345141883-9889-2-git-send-email-gert@...1296...>
In-Reply-To: <1345141883-9889-2-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB36D82BEDA5152DEE9E07214"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Put actual OpenVPN command line on
 top of corresponding log file.
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
--------------enigB36D82BEDA5152DEE9E07214
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/08/12 20:31, Gert Doering wrote:
> This is useful if a test fails, and the tester wants to run the very
> same OpenVPN call with the very same arguments interactively to
> pinpoint and fix the problem.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  tests/t_client.sh.in |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

ACK.  Applied to master

commit cc43956c649a1557a814d52ab422d44939b2383e
Author: Gert Doering <gert@...1296...>
Date:   Thu Aug 16 20:31:22 2012 +0200

    Put actual OpenVPN command line on top of corresponding log file.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1345141883-9889-2-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6984
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigB36D82BEDA5152DEE9E07214
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDt/oACgkQDC186MBRfrpzaQCgpYvMTK34A81/Eo8CvIWl7m+T
PxAAnR7hOrzjVvMf6HrSNLFqo1SLkJ/D
=D4It
-----END PGP SIGNATURE-----

--------------enigB36D82BEDA5152DEE9E07214--

