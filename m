Message-ID: <4FD09ADF.2060204@...1114...>
Date: Thu, 07 Jun 2012 14:13:19 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-5-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-5-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF8907A0B79E148C722FE9775"
Subject: Re: [Openvpn-devel] [PATCH 4/8] Explain that route-nopull also
 causes the client to ignore dhcp options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8907A0B79E148C722FE9775
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/06/12 15:03, Arne Schwabe wrote:
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/openvpn.8         |    3 ++-
>  src/openvpn/options.c |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Applied to master.


commit 97235cc7077630004e11d6d44862c3bb7e49a40e
Author: Arne Schwabe <arne@...1227...>
Date:   Sat Jun 2 15:03:39 2012 +0200

    Explain that route-nopull also causes the client to ignore dhcp options.
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1338642223-20324-5-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6649
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigF8907A0B79E148C722FE9775
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Qmt8ACgkQDC186MBRfrpq8ACdEOWCvMVtjl9OOnje57BsY5HG
41IAn2QYhw3m9eRtXiE6fjvzhlcJ+E21
=tVk8
-----END PGP SIGNATURE-----

--------------enigF8907A0B79E148C722FE9775--

