Message-ID: <50B7D0C9.5070909@...1114...>
Date: Thu, 29 Nov 2012 22:16:57 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323D0B158@...1436...>
	<1353940389-31075-1-git-send-email-arne@...1227...>
In-Reply-To: <1353940389-31075-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6917959729803EEC2667FA20"
Subject: Re: [Openvpn-devel] [PATCH] Properly require --key even if
	defined(MANAGMENT_EXTERNAL_KEY)
Reply-To: openvpn-devel@lists.sourceforge.net
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
--------------enig6917959729803EEC2667FA20
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 26/11/12 15:33, Arne Schwabe wrote:
> When specifying --tls-client --cert ... without a --key (or --pkcs11) opt=
ion,
> OpenVPN should complain: "You must define private key file (--key)...". E=
nsure
> that this works even when compiling with MANAGMENT_EXTERNAL_KEY.
>=20
> Also fix the other instance where this logic is broken
>=20
> Orginal-Patch-by: Found by Joachim Schipper <joachim.schipper@...1435...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to master and beta/2.3

commit feca0900dd00577779ab02f2e52b41eb3dab935f (master)
commit 9447858c38c5cf51265c7eab3445d7d5fb4f7bba (beta/2.3)
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Nov 26 15:33:09 2012 +0100

    Properly require --key even if defined(MANAGMENT_EXTERNAL_KEY)
=20=20=20=20
    Orginal-Patch-by: Found by Joachim Schipper <joachim.schipper@...1783...=
.>
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1353940389-31075-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7143
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enig6917959729803EEC2667FA20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlC30MkACgkQDC186MBRfrrRggCglnQndtoD5nWo+qKLuyteB5TL
4SwAoJi5/rEl0BMf3ujl/KFQ/O3TF4ao
=LQ1Z
-----END PGP SIGNATURE-----

--------------enig6917959729803EEC2667FA20--

