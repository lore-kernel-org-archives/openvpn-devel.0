Message-ID: <507C4138.1020100@...1114...>
Date: Mon, 15 Oct 2012 19:00:40 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAAUdgR8VZjaO0-thFPVoQkbZ1DNG3rx+gtYYLqyfocp3yns==w@...278...>
In-Reply-To: <CAAUdgR8VZjaO0-thFPVoQkbZ1DNG3rx+gtYYLqyfocp3yns==w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C1A4E634C5FB86B44D51087"
Subject: Re: [Openvpn-devel] [PATCH] Fix v3 plugins to support returning
 values back to OpenVPN.
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
--------------enig9C1A4E634C5FB86B44D51087
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/10/12 20:47, Kenneth Rose wrote:
> There's a small implementation issue with the V3 plugin API
> implementation.  V3 plugins cannot return data back to OpenVPN using
> openvpn_plugin_args_func_return since
> openvpn_plugin_args_func_return.return_list is always NULL.
>=20
> This patch makes the behaviour identical to the V2 API (return_list is
> again a proper out parameter).
>=20
> Signed-off-by: Kenneth Rose <ken+openvpn@...1776...>
> ---
>  src/openvpn/plugin.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20

Thanks a lot for catching this one!  I've ran some test code to verify this=
 fix as well, and it looks good so ...

ACK.  Applied to master and beta/2.3 branches.


commit e92255f58bcfaec157c3ef59e01c40cbd04b1d43 (master)
commit aa1a1d91ca1266342762460f86427a577b51908f (beta/2.3)
Author: Kenneth Rose <ken+openvpn@...1776...>
Date:   Mon Oct 1 14:47:02 2012 -0400

    Fix v3 plugins to support returning values back to OpenVPN.
=20=20=20=20=20=20=20=20
    Signed-off-by: Kenneth Rose <ken+openvpn@...1776...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: CAAUdgR8VZjaO0-thFPVoQkbZ1DNG3rx+gtYYLqyfocp3yns=3D=3Dw@...493...=
278...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7083
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig9C1A4E634C5FB86B44D51087
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlB8QTgACgkQDC186MBRfro6LwCeM5/LAv+eG3N10GaU6TRZtEZp
X8sAn3suLzSHh9whEbXdRuSb41xZ/Erp
=UQ0W
-----END PGP SIGNATURE-----

--------------enig9C1A4E634C5FB86B44D51087--

