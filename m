References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
	<b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
	<CAKuzo_iVrROZsuU+DhHfuu6m6jKutftqfqNB2WW5d4fV5YH7Pw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d804c70f-62b4-e50a-aa69-323d3631a21f@...2080...>
Date: Tue, 9 May 2017 20:23:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iVrROZsuU+DhHfuu6m6jKutftqfqNB2WW5d4fV5YH7Pw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3xHSSHAd03kW0XggvdHLs1dHUq6MgmXW8"
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
 memory on error
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3xHSSHAd03kW0XggvdHLs1dHUq6MgmXW8
Content-Type: multipart/mixed; boundary="cFWWwmRCm07mmpqpMAiMGXrDhLk6QVelS";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <d804c70f-62b4-e50a-aa69-323d3631a21f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Always clear username/password from
	memory on error
References: <1494327032-3035-1-git-send-email-steffan.karger@...1435...>
	<b2e1af67-2b5c-44ba-e8db-4d325d6e1e0b@...2080...>
	<CAKuzo_iVrROZsuU+DhHfuu6m6jKutftqfqNB2WW5d4fV5YH7Pw@...278...>
In-Reply-To: <CAKuzo_iVrROZsuU+DhHfuu6m6jKutftqfqNB2WW5d4fV5YH7Pw@...278...>

--cFWWwmRCm07mmpqpMAiMGXrDhLk6QVelS
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/05/17 20:08, Selva Nair wrote:
> Hi,
>=20
> On Tue, May 9, 2017 at 1:47 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>=20
>     That said, I think we should fix secure_memzero() to just return if t=
he
>     input pointer is NULL.  And even though most compilers do initialize
>     variables, I think it's good to be defensive here and initialize
>     `up` too.
>=20
>=20
> No, compiler will not initialize such non-static local variables. In
> fact in this case gcc will warn (with -Wall) that "up" may be used
> uninitalized because of code paths where "up" is not allocated as you
> pointed out.
>=20
> In that sense its better not to initialize such variables as
> initialization can hide errors.

I agree that getting the warning is useful for developers.  But I've
just seen way too many packagers ignoring these warnings (or even
removing -Wall) - and then ship binaries with undefined behaviour.  I
don't like that scenario at all.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--cFWWwmRCm07mmpqpMAiMGXrDhLk6QVelS--

--3xHSSHAd03kW0XggvdHLs1dHUq6MgmXW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEgkdAAoJEIbPlEyWcf3yFqUQAJ/3K046l8+Y4kmaHtmU3TtK
tBa5LF4JJD8M8sc0TwYjaulNSEq1eGEL3EM2oHtD7aeSujly4S5kzH3cRrT4zvFe
h7dCYl2H/+/TXnZdTUGEyY7OVM2jKzfHwpCAw6ooSoRFHvzQhtVp8TACIwztJBNA
J5LH030fgmyP8TRrjbPkzOVEWjQcCMBVtz7U3Kj/6aq0fZWc2v9nKl8/e1W6Kd/k
7crClwFkndN/Qeq9/n5WGdWXuD+7KdYrVkLOrdvnTSQLlJNZzxQ9iv8JebIjBolQ
nIzQcRTbTWgSWG5EILsu22O99lz4X0yCZaC46kP2w7Ax4a9faWZ91wKDh4TbJPIE
AZe0qk6Dwc3k3tbM83KGG6OLVGqdoIf12XOMkG+13Wo7CjK+vYWWtjITcdy2tqnB
j5VUyaFzG3WShJ3+L9bhP+BGxdPyGJ/H9n0OgqTLyVFV2xhTE9DQ06qCTvp8oAks
+Fjfckv4WfCpXQkc+NPkSdx1IahRMocjnCKke3xyJiPpByYR7Zu/E/Vh9Qktt/V6
gFnZKEo++dkLuCTAIScfg9aff6Q5DEPZy/cAIiogn56gUhNnu+O4J4/QdTuBCIQi
TC0woRE7MSj+3o+VC1pTnJw48g1KtzUz0ol4qx3N5SOzLu08ncyKFlSHjj7qOmHc
U6y8mXbzo7PoUbMz62Nc
=0n+0
-----END PGP SIGNATURE-----

--3xHSSHAd03kW0XggvdHLs1dHUq6MgmXW8--

