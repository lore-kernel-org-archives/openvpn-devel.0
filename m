Date: Sun, 15 Jan 2023 17:06:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y8QkoL2FzhhUl8LY@...1296...>
References: <20230113235754.1942385-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xi5cdMdxlTj0X8O0"
Content-Disposition: inline
In-Reply-To: <20230113235754.1942385-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Define and use macros for route
 addition status code
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

--xi5cdMdxlTj0X8O0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 13, 2023 at 06:57:53PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Instead of 0, 1, 2 use RTA_ERROR, RTA_SUCCESS, RTA_EEXIST
>   as the return code of route addition functions.
>=20
> - Also fix a logging error: status -> (status =3D=3D RTA_SUCCESS)
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>

Thanks for that.  The patch looks good, and should go into 2.6.0
(so we have an easier-to-understand codebase to base future patches on),
but I have one request...

>              status =3D add_route_service(r, tt);
> -            msg(D_ROUTE, "Route addition via service %s", (status =3D=3D=
 1) ? "succeeded" : "failed");
> +            msg(D_ROUTE, "Route addition via service %s", (status =3D=3D=
 RTA_SUCCESS) ? "succeeded" : "failed");

We have an informal "soft" line length limit of 80 characters, and "hard"
of ~100, if something just looks bad if adding wrapping.  These lines
do lend themselve to a very logical wrap

+            msg(D_ROUTE, "Route addition via service %s",=20
+                (status =3D=3D RTA_SUCCESS) ? "succeeded" : "failed");

which will keep them under 80 characters, and, I think, also improve
readability.

With other core team members I would just do a quick ask on IRC and
rewrap on-the-fly, but I won't do that without permission.

Can you re-send a v2?


That said, there is something else...


On Fri, Jan 13, 2023 at 06:57:53PM -0500, selva.nair@...277... wrote:
>      {
>          openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask,=
 gateway);
>      }
> -    status =3D management_android_control(management, "ROUTE", out);
> +    status =3D management_android_control(management, "ROUTE", out) ? RT=
A_SUCCESS : RTA_ERROR;

So android gets a 3-state directly on the function return...

> @@ -1694,7 +1699,8 @@ add_route(struct route_ipv4 *r,
>      }
>=20=20
>      argv_msg(D_ROUTE, &argv);
> -    status =3D openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route =
add command failed");
> +    bool ret =3D openvpn_execve_check(&argv, es, 0, "ERROR: Solaris rout=
e add command failed");
> +    status =3D ret ? RTA_SUCCESS : RTA_ERROR;

... while the execve() platforms get an extra return code variable...

I'm fine with both approaches, but if we touch all these places at the same
time, let's decide for one approach :-) - given the line length, using the
"bool ret" approach for Android too sounds like a good choice.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xi5cdMdxlTj0X8O0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjxCSgAAoJEB2Cnv7KVigSN8EMAJV5yJH8pHDwtEA8jxpCnDln
YPF0Q8PTar3t2HyCX++NAx5OGyaMaKHXHUqxQpGbKUA1wsOBhkgtnyB9BFDPpan5
ifRSK2YmkP1JQzDU5BkE+xMIfsCZysMkZ2OcusiOxyTd0Cz9wRELhvad7n2s4pWM
42raB5ktMxkspH+03sUK/NyxBLQvvsVNn+DFZqeP7FFcAJjGr4nqoidCtCah9DcP
/7lfTDKRljKPpCNkZogyPVTc+aP7H558/UvN9eMicNLZ6+lHn+EQYfOLmzf/guq2
AgB1kbF8XKCDtG03Q4aKDpYZ54qE3XP0KLHccK1Zt8GwYL+T9KyCLc3SV6MtNwjs
7Ag7Qo4DdtW+SjEwJu+rvVLLQtSFS9Qh7WvQKbVHL9oz8VRPntJzbFe67Ic7Cb78
c+dSQKBwBq3q48T6zvyyPm5qVhSfbfIY/oJarRn8BpTuetB0LzQuKHUc/qN304oP
GXVhUD0oiVdh0ZEum6dWfit1g3WmjE9x9jKB3nTLYg==
=VNbp
-----END PGP SIGNATURE-----

--xi5cdMdxlTj0X8O0--

