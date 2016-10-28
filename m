References: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
	<1477660582-8056-1-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <258a50fa-8d5b-d938-37ee-8f4e1d1dff26@...2080...>
Date: Fri, 28 Oct 2016 15:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <1477660582-8056-1-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="RT1qeJ8lB4UBibeXe5uJ6pAXh04LkUfUp"
Subject: Re: [Openvpn-devel] [PATCH applied] Limit --reneg-bytes to 64MB
 when using small block ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RT1qeJ8lB4UBibeXe5uJ6pAXh04LkUfUp
Content-Type: multipart/mixed; boundary="NEGWjRHwFOeXaueJrEPk8OPgSqCKXgO3J";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <258a50fa-8d5b-d938-37ee-8f4e1d1dff26@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Limit --reneg-bytes to 64MB when
	using small block ciphers
References: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
	<1477660582-8056-1-git-send-email-davids@...515...>
In-Reply-To: <1477660582-8056-1-git-send-email-davids@...515...>

--NEGWjRHwFOeXaueJrEPk8OPgSqCKXgO3J
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 28/10/16 15:16, David Sommerseth wrote:
> ACK.
>=20
> Your patch has been applied to the  branch

This was pushed to the release/2.3 branch.

> commit a91ddc99a524014ec79560d873721e8fa81a5631
> Author: Steffan Karger
> Date:   Fri Oct 28 14:10:07 2016 +0200
>=20
>      Limit --reneg-bytes to 64MB when using small block ciphers
>=20
>      Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>      Acked-by: David Sommerseth <davids@...515...>
>      Message-Id: <1477656607-7440-1-git-send-email-steffan.karger@...1784...=
...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg12799.html
>      Signed-off-by: David Sommerseth <davids@...515...>
>=20

--=20
kind regards,

David Sommerseth


--NEGWjRHwFOeXaueJrEPk8OPgSqCKXgO3J--

--RT1qeJ8lB4UBibeXe5uJ6pAXh04LkUfUp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYE1MfAAoJEIbPlEyWcf3ytecP/0fO7lq+X/rqv0vBm6xTlaTM
g/Z8DvWWrN0e33WcZuCpsZROP0TWCKMcZ6XmF89FQ51JDN/YWCb+LChspI4Jrf0P
xI65TO+8SLVBbzmf7sLo/j6lv2nLymR9xH4Fk2cjNugbDMhhE4JbkkHInV4ph6sm
ziC6vtVYydObiNtUFID0j30dwBKrg+EbAvv635mhIIMUbRDrwoi+hFkpNCEM/W8x
aIFUy6xS/RTVZG9BjsW35RmULray1FlQGb9OhAZhk/pLlGuzPRlOWvnkj4BaD2pY
liZMnRNgkgp1CgjAsm9h4KHeOUqe0qpTP5O0OoLSLEbh4RzqxHO2119G7KqNw90T
E8ncwdfofSsc86xdeWV3qK9Jm/tlO+hn/+HNK8spoiKn4HWuxK0sJs4sT8Fqm/r7
1D74aB7UENTlQ+12HdkiehbBcsI3r+dzjo3CuI1TlxRoVMo+r6C3nWgeDy77Erkk
03/FYts9PlsnPZ6ItjxMrBIcjIhSS4TdA4bIYKTKwBIkMjPSKhMrwTpGC0IxpKgj
e02h2LvTCfLx1M+aw0AmfVhGEgxW4L2tsi0iDoMYG2ikG+GkE1epMqUYY3GvBWou
fi8c8NfBxSCe+1zipgcMOsKV3YpMZeLktscJplV847DFrJj3efubjC+u3nKYZs+M
iYeViTr+sTFmipaYKSyC
=Xl9R
-----END PGP SIGNATURE-----

--RT1qeJ8lB4UBibeXe5uJ6pAXh04LkUfUp--

