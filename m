Date: Fri, 20 Jan 2023 09:22:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8pPXMgXwiNqzvbm@...1296...>
References: <20230113235754.1942385-1-selva.nair@...277...>
 <20230113235754.1942385-2-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9OP2bQTPhyf3belz"
Content-Disposition: inline
In-Reply-To: <20230113235754.1942385-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Cleanup route error and debug
 logging on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--9OP2bQTPhyf3belz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 13, 2023 at 06:57:54PM -0500, selva.nair@...277... wrote:
> Use a unified logging format for various route-methods

This generally looks good, but I could't get Lev to test it, because
the patch does not apply anymore - v2 of the RTA_ macro patch brought
"bool ret =3D ..." change which conflicts with this one.

Can you rebase, and resend?

thanks,

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9OP2bQTPhyf3belz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjyk9cAAoJEB2Cnv7KVigSYGsL/3jxcs1zeXSo01Gx1Rh2xBYm
xVyuP4w7ELMvoxc9ykU3wcebEcuyKRSJZcG+XwM6cNh4qUo1pfoYiapItZxa1kQb
r8ahbWwTzoAOHjKrdQAoLNYm48TO8s+4tA/WP/VKSu9X1iE7vig742BBNZoGY7wl
MYHkFYbCkj4I4SFb44dZZh/ywYPQ6AnHwtKriFIJw/8NoISWt3HjQp+CeUt7ShSY
Xn03hgzqeJDXEZ93YaODmjCafjhmS6hV3TuARTixHHR9AYpvo+q/w+SmCq/sKXYR
nM2KbDxbf32p9I70NW7HBUyIScB598dLN938XVGAGsPzIi1DkpquMiwtU2HOtMRV
A/3iujBoUkT+wn3CZ/Obe7kRAqu3YCRgR0/rvN0+ECXa+poJALEKkDOlCQAfmgGW
pA2lbRfpXPec6oFB9eOJxtDSuqnvU++mlDbf4WQQofS+eTwqN82sY8Yr+VF1p63U
AjH0UMw1/0IfjCMCIy2zZxgyO3OvAhbkHSvwobu9DQ==
=uhm5
-----END PGP SIGNATURE-----

--9OP2bQTPhyf3belz--

