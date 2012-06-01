Message-ID: <4FC8E5A2.9080702@...1114...>
Date: Fri, 01 Jun 2012 17:54:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120601151507.GE400@...1296...>
In-Reply-To: <20120601151507.GE400@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA1D9E4E9095017D7AE7847A1"
Subject: Re: [Openvpn-devel] t_client.sh iproute2 fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1D9E4E9095017D7AE7847A1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/06/12 17:15, Gert Doering wrote:
> Hi,
>=20
> testing with David on Linux today uncovered differences between "ip
> -6 route show" on Gentoo (only shows the active routing table) and
> FC14 (also shows the ipv6 route cache).  The route cache is not=20
> interesting, but distorts our tests, as it depends on what else
> was going on on the machine instead of "explicit route/ifconfig
> settings by OpenVPN".  So work around this.
>=20
> Also, include the proposed change from Alon to test for iproute2=20
> existance with "-n".  More clean that way is.


ACK.  Applied to master branch.


commit 722027a2798b46cab8be69a830eff1b4ba678739
Author: Gert Doering <gert@...1296...>
Date:   Fri Jun 1 18:13:09 2012 +0300

    t_client.sh iproute2 script fixes

    Test for existance of "iproute2" with "-n" (Alon)

    Work around "ip -6 route show" behaviour on FC14 where some parts of
    the IPv6 route cache would be displayed, which has no relevance to
    OpenVPN but breaks before/after comparison.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 20120601151507.GE400@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6637
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigA1D9E4E9095017D7AE7847A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I5aIACgkQDC186MBRfrofMgCeKVCxAyE8qMRg5GReqZsAiz4A
st4Anin8AoNMW8OSe01HHSgDbExvHWzh
=NWP4
-----END PGP SIGNATURE-----

--------------enigA1D9E4E9095017D7AE7847A1--

