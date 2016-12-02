References: <10719981480674741@...2206...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a9810679-9b15-8d47-71df-b3b39c4a5b65@...2080...>
Date: Fri, 2 Dec 2016 12:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <10719981480674741@...2206...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7fGNS61tiTsok63BPojdCgVXcNEkhqeTf"
Subject: Re: [Openvpn-devel] Enable FIPS encryption
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: boxartst@...1411..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7fGNS61tiTsok63BPojdCgVXcNEkhqeTf
Content-Type: multipart/mixed; boundary="6XorAu5Nk27uM4eMGFGPLnFF4IfxKoba8";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: boxartst@...1411..., openvpn-devel@lists.sourceforge.net
Message-ID: <a9810679-9b15-8d47-71df-b3b39c4a5b65@...2080...>
Subject: Re: [Openvpn-devel] Enable FIPS encryption
References: <10719981480674741@...2206...>
In-Reply-To: <10719981480674741@...2206...>

--6XorAu5Nk27uM4eMGFGPLnFF4IfxKoba8
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/12/16 11:32, boxartst@...1411... wrote:
> Hi!
>=20
> I would like to know if it's possible to enable fips  enabled encryption =
on my vpn server?=20
> Here is a link to fips user guide https://www.openssl.org/docs/fips/UserG=
uide-2.0.pdf .
> It looks like I'd have to change source code and compile it myself to mak=
e it FIPS compliant.=20
> Any help or advice would be very much appreciated.=20
>=20
> Thanks,
> Artem


OpenVPN needs to be adopted to be useful in FIPS mode.  We are tracking
this issue in trac ticket #725.

http://community.openvpn.net/openvpn/ticket/725



--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--6XorAu5Nk27uM4eMGFGPLnFF4IfxKoba8--

--7fGNS61tiTsok63BPojdCgVXcNEkhqeTf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYQWD/AAoJEIbPlEyWcf3yFDkP/3KbpsquPLEffFfhsaotGWYB
oKQSjT43+UIzV6go8gy4GFzUUFY8NE9+UynXUw79WicdjzAoZ4Iu+bVrvZe/+zpC
tczs333uGjuShi2Q7cAbnzRRSyUjwK5QfKcF2tGhA6UwIP6nqXA4twbIPzB4wMJP
mFAtUdIj86tX5YNSjRPEwNqXJIT1lOwLe16V/Vd6E2bn7kqyP6dQsc5gz9zrpUiy
VPpVaZMljOeiPhy6NTySGxNKQws8fseBqvLBEc0YNNGy+xz0HVWBik3F19cGYEak
jXcZAoL04ovH3TJOaBPc6KNIzNUScBxLMXO5dxsUpvUKG/UHr++6BmRUD35u1IzU
SZmJCaevTB4qDMusfghOgWkEV+oKvSF6dAEHxJINwDKPyE4JSuBw8XOdQwO2RWdG
ylz4BoG7bI4aKgNG95KZj4CPGPAfU+Mv/YtIsklx6Oe8M3dbRGlEfNSKTqzc4x5o
+C5ibrnEfv/9nUJmzr05dH/uP/rALUndRsqSoFXTYURxNdHtRZes1TlTcDK7rhcV
dN/3O+E1ik3NyV5cc8WnQM6GLIdXUoXBL4yGbKmnRbk+ztubyhNd6h/YFesCYEgk
aToELdsgWbOgocNX/f4AaEMNioISx/2JX/6v6qMoCT8/ziM+em0IJQN5TE8+Ygxi
AESCwnnorynsC2ufetl3
=gNHQ
-----END PGP SIGNATURE-----

--7fGNS61tiTsok63BPojdCgVXcNEkhqeTf--

