Message-ID: <508923FC.4050301@...1114...>
Date: Thu, 25 Oct 2012 13:35:24 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1350470774-12511-1-git-send-email-arne@...1227...>
In-Reply-To: <1350470774-12511-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CF15350023376E3C0EAB6D3"
Subject: Re: [Openvpn-devel] [PATCH] Options parsing demands unnecessary
 configuration if PKCS11 is used
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
--------------enig9CF15350023376E3C0EAB6D3
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 17/10/12 12:46, Arne Schwabe wrote:
> In the old patch the if incorrectly closed the outer if condition.  (clos=
es ticket #231)
> ---
>  src/openvpn/options.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20

ACK.  Applied to master and beta/2.3 branches.

commit 70a07339f8d323d69cdcf8d59da1f331d39e4d0a (master)
commit ad0cc02234e17ab1f43488c4393059ea1c9d8f95 (beta/2.3)

Author: Arne Schwabe <arne@...1227...>
Date:   Wed Oct 17 12:46:14 2012 +0200

    Options parsing demands unnecessary configuration if PKCS11 is used
=20=20=20=20
    In the old patch the if incorrectly closed the outer if condition.
    (closes ticket #231)
=20=20=20=20
    Trac-ticket: 231
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1350470774-12511-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7095
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig9CF15350023376E3C0EAB6D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCJI/4ACgkQDC186MBRfrrPUgCdFzD2ztPp23yi0vO9vlZTGvgO
DMcAn2Zq8jtsCM8w7+A70Z2YH6BQgWXp
=PkS9
-----END PGP SIGNATURE-----

--------------enig9CF15350023376E3C0EAB6D3--

