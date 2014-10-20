Message-ID: <5444CC1E.80906@...1114...>
Date: Mon, 20 Oct 2014 10:47:26 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20141009214049.GB4106@...1818...>	<5437B156.1020408@...1114...>	<20141012195919.GU3738@...1819...>
	<543D4C0E.1040400@...1114...>
In-Reply-To: <543D4C0E.1040400@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="jGKBhu47Uw3WRaEpV3SlArLKNIHBHhG5w"
Subject: Re: [Openvpn-devel] [PATCH] Fix temporary file leak
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jGKBhu47Uw3WRaEpV3SlArLKNIHBHhG5w
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/10/14 18:15, David Sommerseth wrote:
> On 12/10/14 21:59, Samuel Thibault wrote:
>> David Sommerseth, le Fri 10 Oct 2014 12:13:42 +0200, a =E9crit :
>>> I think it would be better to move the unlink() code from
>>> multi_client_connect_post() into multi_connection_established(), where
>>> these temp files are created.  This makes the code clearer and easier to
>>> understand.
>>
>> Right, how about this?
>>
>> Samuel
>=20
> Okay, so I messed up the push.  But it's fixed now, and it really got
> pushed out this time :)
>=20
> Your patch has been applied to the master branch.
>=20
> commit 7da9d40243e0743e2d050ceb6ae34e467dd58973
> Author: Samuel Thibault
> Date:   Thu Oct 9 23:40:49 2014 +0200
>=20
>      Ensure that client-connect files are always deleted
>=20
>      Signed-off-by: David Sommerseth <davids@...1347...>
>      Acked-by: David Sommerseth <davids@...1347...>
>      Message-Id: 20141012195919.GU3738@...1819...
>      URL:
> <http://thread.gmane.org/gmane.network.openvpn.devel/9104/focus=3D9118>


We decided to include this in the coming 2.3 release as well.  So the
patch can be found in the release/2.3 branch as commit 10cbaea91d7d3774
as well.


--=20
kind regards,

David Sommerseth


--jGKBhu47Uw3WRaEpV3SlArLKNIHBHhG5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlREzB4ACgkQDC186MBRfrrrbgCcCm9s4rmfglH/5E7PogTBtjnn
ZXcAoKm/1lwzLS4UHNybV/Zfd2nGBDds
=f27a
-----END PGP SIGNATURE-----

--jGKBhu47Uw3WRaEpV3SlArLKNIHBHhG5w--

