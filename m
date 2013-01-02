Message-ID: <50E484DB.7010504@...1114...>
Date: Wed, 02 Jan 2013 20:04:59 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <50D6F4EA.6050504@...1227...>
	<20121225124856.GT22465@...1296...>
In-Reply-To: <20121225124856.GT22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47EC54703A4B6854EB5BFEE7"
Subject: Re: [Openvpn-devel] Crash on duplicate PUSH_CONTROL message
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
--------------enig47EC54703A4B6854EB5BFEE7
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 25/12/12 13:48, Gert Doering wrote:
> Hi,
>=20
> On Sun, Dec 23, 2012 at 01:11:22PM +0100, Arne Schwabe wrote:
>> I fear we may have to delay the final release. While debugging a problem=
=20
>> with a user of my app I found a nasty bug which causes OpenVPN to crash=
=20
>> if two PUSH_CONTROL messages are received.
>=20
> The appended patch fixes this for me (Client on Linux/i386, but that=20
> should be OS and architecture agnostic).

Applied to master and beta/2.3


commit 1978db4b9657f0db134f1deaeb1e8400bf6a033e  (master)
commit 2e3b853dd1070435d60a1f11ff4364631c83d6a9  (beta/2.3)
Author: Gert Doering <gert@...1296...>
Date:   Tue Dec 25 13:41:50 2012 +0100

    Fix client crash on double PUSH_REPLY.
=20=20=20=20
    Introduce an extra bool variable c2.pulled_options_md5_init_done to
    keep track of md5_init state of pulled_options_state - avoid accessing
    uninitialized state when a second PUSH_REPLY comes in (which only happe=
ns
    under very particular circumstances).
=20=20=20=20
    Bug tracked down by Arne Schwabe <arne@...1796...>.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: 20121225124856.GT22465@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7216
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enig47EC54703A4B6854EB5BFEE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDkhPAACgkQDC186MBRfrpcggCeJ0D94k7NoOInhsW4aU6aYRTT
1S8An1gx5y6aTciE6E+oZBLU4AUQNueD
=k+uX
-----END PGP SIGNATURE-----

--------------enig47EC54703A4B6854EB5BFEE7--

