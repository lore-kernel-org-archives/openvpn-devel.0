Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <80fef363-2aab-b263-b23e-65b52c0fb253@...2080...>
References: <1484036287-12801-1-git-send-email-chipitsine@...277...>
	<c11afdfb-d3ac-b805-016b-c8cdcf61efb3@...2080...>
	<CAKuzo_hGrj5zhLpwqnwo7qf8hhyPBe1qswQa54RHs+EUFii8NA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
Date: Tue, 10 Jan 2017 21:33:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hGrj5zhLpwqnwo7qf8hhyPBe1qswQa54RHs+EUFii8NA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
 static analyzer variable "ret" is assigned a value that is redefined later
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
To: Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/01/17 20:50, Selva Nair wrote:
>=20
> On Tue, Jan 10, 2017 at 2:12 PM, David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>> wrote:
>=20
> The attached patch is cleaning up this a bit, avoiding some of the=20
> scoping and the not really useful 'bool ret' variable.
>=20
>=20
>=20
> In the patch  you correctly break out of the while() on when=20
> man-even-loop prematurely returns due to signal but do not return
> false on signal. This could potentially cause the current remote to
> be accepted if the UI sends a signal instead of ACCEPT in answer to
> the
>> REMOTE query.

Ahh!  Good catch.  I did consider this approach, but presumed that
James had the variable overwritten on purpose.  But I believe you are
right, I see this have a potential to backfire if overwritten.

I'll attach two patches to this mail thread.  The first one fixes this
issue, as suggested - but where I improve the comments and add a few
code style fixes as well.  The second patch just removes a redundant
#ifdef ENABLE_MANAGEMENT block, where these ce_managmenet_remote_*()
functions are used.


- --=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYdUUhAAoJEIbPlEyWcf3yxU8P/1jZy2IaUB1IgVQLQk+oqEqS
5FJb7gMYzpOxborF3y3O5vUhjboU4wNnL4wYbymarOyZ3V83fxlfZ1LHAnQh8cVZ
PCKvRMXFfnbwLk40Rf8Bkv2WQw5EjXUsfEREy/Pg7DdIcGkCl8ckumV6aOLkCTfv
71oObTAZMF9tQPDxDvgySJyt8A4sRYNEaJxowu0iguIVVgl+IVPp/wToV7txuD0c
kvjMee03NxtTh1HZgFqvBvfaCJ+1FZpvEf5DZ+WYwhFpWxgn1shw4XDYafgWpU9Z
v5cd//y7RY3o8m7NdgNnJH68/lSu9LrIQPhj9YARPFfrte5QTkk5E597Ws+7x12O
gCJlyHLTQKMlRNTLX6mtZHrY957xFdTlBuMsRNKF3s0bzLRP8b3L7UPYgtt4/UPz
5AETZGywCk4ij0dSsctJQcy1ejVqPXrEAw+hYli3tEJd5mpP6b0XUc5+0pcTJpfr
zR01okfOAW2uc7LCt/Upn7td1nVuyxvmNeJdrnqTF5ZNEpTDRcGHzZxzpXG5ECIT
vjFRY9+GmxJGFNVlYTlgUtZN3H1NuK2wGyP3pzuI0FKyFgiRMiGV8VUkFpOypXsA
Dd8NXd0MZW2C+R5W7bUwi6ma3UcIPGs61yHn6KfCFMJLen23fLY9AZFEtAaXTIE9
jFOSt6NkJuNVAkkrhzGP
=3DjXw0
-----END PGP SIGNATURE-----

