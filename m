Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <dc62944a-cf90-8792-4f42-4a11f7ca5e6c@...2080...>
References: <3fdeb614-4be9-8843-7992-2f1937402644@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f33609b6-de8b-985d-aee4-9d18a2d58517@...2080...>
Date: Wed, 18 Jan 2017 20:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <3fdeb614-4be9-8843-7992-2f1937402644@...277...>
Subject: Re: [Openvpn-devel] [openvpn-devel] --auth RSA-SHA512 vs --auth
 SHA512
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: debbie10t <debbie10t@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/01/17 18:19, debbie10t wrote:
> Hi,
>=20
> I have following config:
>=20
>=20
> ** Server Win10 (as per default generally) v2.4.0 with --auth
> *RSA-SHA512* --ncp-disable
>=20
> Log file shows:
>=20
> Wed Jan 18 17:04:34 2017 us=3D914797 Outgoing Control Channel=20
> Authentication: Using 512 bit message hash '*SHA512*' for HMAC=20
> authentication Wed Jan 18 17:04:34 2017 us=3D914797 Incoming Control
> Channel Authentication: Using 512 bit message hash '*SHA512*' for
> HMAC authentication
>=20
>=20
> ** Client Linux (as per default generally) v2.4.0 with --auth
> *RSA-SHA512*
>=20
> Log file shows:
>=20
> Wed Jan 18 17:05:00 2017 us=3D778089 Outgoing Control Channel=20
> Authentication: Using 512 bit message hash '*SHA512*' for HMAC=20
> authentication Wed Jan 18 17:05:00 2017 us=3D778182 Incoming Control
> Channel Authentication: Using 512 bit message hash '*SHA512*' for
> HMAC authentication
>=20
> The connection works but ..
>=20
> Because there is another digest called SHA512 why does the log=20
> *not* reflect the config correctly ? eg: hash '*RSA-SHA512*'
>=20
> (This had me very confused for sometime today)

I am on thin ice here, as I've not dug much into the naming schemes of
the various algorithms.

But ... I am fairly confident the hashing reference in the log refers
purely to the hashing algorithm, which most commonly is MD* or  SHA*
variants (there are a few exceptions).

And as I understand the code, the RSA-* stuff is just ignored, as that
is not used by by HMAC functions in our code.  So using --auth SHA512
would provide the same result.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYf79HAAoJEIbPlEyWcf3yGm4P/RxyydWvK/kWuMFxOS7aGjx8
HhTB1eDep41eQTNyN6PJFExq3Be4B4Meo30tPqEbDuUGhZuvPYQb/04UET8vYgku
1XxqXA8OoTlk6cKU+hrj/ISClAAR3yd1ma2cfAMj5+ltS4mGzz8pPyKXxvIM7d++
gYiQyNb7Nu/oYN+TWDM0JZdIHWC9pUByugUoHmqhnBI79pQGjMfbtvdGFDFV70n4
jtXXJ6WIGunrW65zLRKGxuVd4K7cc9Aic259CcsVvIiarryEEtQt1ZbJBOm2O05v
J5C+vynO1Ixcvq6wbVdmsnBrsjtK9BylVHB7oll3GX4axOn1S9AjC6DWDztsGbhL
zzzKioIhv2dmB2OgufUXr6jMxWgWkvtcw4FspyzrUh1LbqaSd2iUiSnieB5fd7C4
z78zKznNGBQaqvRtH38aMRBH6vNrYZVM2bE05C7G5Vn0/xsPzrNt52FMMuKfgDMf
eftK1JwbMjicLmbONmVDb2mEZewW/l0d8YkaFc74k1OXU5Kr+YP+jRSyHmHfLh6m
eT+qgX/aUuUhWD98v1AiG1C6SqK9f1AaZuFh6BzpMVHmXUXaGAnrO5fgj1aJmnnI
WLbqwSYY4ejAkubr0f2+dmcic2JTIhAwKF8wObGSrfE9kLgO5GM4TRMiUHwJplDD
cdepFIgOVDQQhxA17EqD
=3DbXK1
-----END PGP SIGNATURE-----

