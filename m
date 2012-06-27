Message-ID: <4FEB22BC.4010701@...1114...>
Date: Wed, 27 Jun 2012 17:11:56 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
	<1340719406-12157-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1340719406-12157-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC317DE1EEE4351354B99622D"
Subject: Re: [Openvpn-devel] [PATCH] build: plugins: set defaults using a
 complex logic
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
--------------enigC317DE1EEE4351354B99622D
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 26/06/12 16:03, Alon Bar-Lev wrote:
> pam cannot be compiled on OpenBSD and Windows.
> down-root cannot be compiled on Windows.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
>=20

Applied to master.


commit 5a57e201223f7265af0a56859b00aOn 26/06/12 16:03, Alon Bar-Lev wrote:
594b0d98f5b
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Tue Jun 26 17:03:26 2012 +0300

    build: plugins: set defaults based on platform
=20=20=20=20
    pam cannot be compiled on OpenBSD and Windows.
    down-root cannot be compiled on Windows.
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: Samuli Sepp=E4nen <samuli@...515...>
    Message-Id: 1340719406-12157-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6795
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigC317DE1EEE4351354B99622D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/rIr8ACgkQDC186MBRfroXywCaAtIsGCLFsUNLQtfDCXX3hB6U
YxUAn0GM82o5yxPRo2aNll57KJCrOHoa
=Vpig
-----END PGP SIGNATURE-----

--------------enigC317DE1EEE4351354B99622D--

