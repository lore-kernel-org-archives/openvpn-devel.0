Message-ID: <5043B7FD.40204@...1114...>
Date: Sun, 02 Sep 2012 21:48:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345141883-9889-1-git-send-email-gert@...1296...>
	<1345141883-9889-3-git-send-email-gert@...1296...>
In-Reply-To: <1345141883-9889-3-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6E934A125E722CBF23CB69CA"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Reduce --version string detail
 about IPv6 to just "[IPv6]".
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
--------------enig6E934A125E722CBF23CB69CA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/08/12 20:31, Gert Doering wrote:
> For 2.3 release, we do not need to have more details, as there is no
> separate patch set anymore, and both IPv6 transport and IPv6 payload
> (PF_INET6) have been fully integrated.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

ACK.  Applied to master.

Author: Gert Doering <gert@...1296...>
Date:   Thu Aug 16 20:31:23 2012 +0200

    Reduce --version string detail about IPv6 to just "[IPv6]".

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1345141883-9889-3-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6985
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig6E934A125E722CBF23CB69CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDt/0ACgkQDC186MBRfrou8QCfbK0HyXXYh3vBhlSo5zg+XZ6b
SxYAoJbAOnAUZS9js0UAmK9k0iar+Q+Y
=dyGW
-----END PGP SIGNATURE-----

--------------enig6E934A125E722CBF23CB69CA--

