Date: Thu, 25 Aug 2022 22:33:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwfcgJal2d7iqMc4@...1296...>
References: <20220722134902.22092-1-frank@...2641...>
 <202207221509.26MF98lA032041@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FwDPFHCG+7RZe1LM"
Content-Disposition: inline
In-Reply-To: <202207221509.26MF98lA032041@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: t_client: Allow to force
 FAIL on prerequisite fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--FwDPFHCG+7RZe1LM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 22, 2022 at 05:09:08PM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> "makes sense" - in a buildbot (or any other CI) environment, do not=20
> silently skip missing prereqs, but fail hard.
>=20
> Tested with "make check" ;-) - with and without TCLIENT_SKIP_RC=3D1
> and RUN_SUDO=3Ddoas / RUN_SUDO=3Dfalse, etc.
>=20
> Your patch has been applied to the master branch.
>=20
> commit 79932b94513303567fdd5d1c4e0abb79e6642b6e
> Author: Frank Lichtenheld
> Date:   Fri Jul 22 15:49:02 2022 +0200
>=20
>      t_client: Allow to force FAIL on prerequisite fails

Because it makes sense, applied to release/2.5 as well now...

commit 26b04fce5a17f8a8670c005d66e9260dbdc88cfe
Author: Frank Lichtenheld <frank@...2641...>
Date:   Fri Jul 22 15:49:02 2022 +0200

    t_client: Allow to force FAIL on prerequisite fails
=20=20=20=20
    (cherry picked from commit 79932b94513303567fdd5d1c4e0abb79e6642b6e)

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FwDPFHCG+7RZe1LM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjB9yAAAoJEB2Cnv7KVigSUkEL/0wiAxniHfVat+Cj4dOduX9b
DQe9qfgcAp8mZKJcZ8ehgfWtMbvzcPwprSBEo3wwnXFjqRdMGN6BDHWFB7KwXLs+
adUqSLZ5iDBrqP/PC6eoBfvAir/8XG9CwVyYKj1YLZ7XeOFRYSbTq+N87PrKsPJQ
B6MwFmNe8Jnb26RUx6sJOe0ioq0YwAOd/bZRlD8iYw/cxXjIxOYYU4GNf9JH+yHQ
nH2dLwF5n562lpWR+vamjXcNXEULhsOq31Ym6lIOtluZEH4J3JEI4V2M6ObgGPEr
Qk5R0lIYQTp7dA4pXLPzRmQ/3MsExe15UE5y8z6aaK+eHB9DPcPALsZu5dPOqDyV
pI1UgbQrOOEflKUXBVjwGXqcv6krSPmjDeRDB6uTKVhdFm1Qsdks4qUVsJBhEzXn
aXCJwy30z77Ztw8uouCSWVDm5GfWCpnM0pcZG8SVw8uX2Gg+BjdZtZ6kn+CkLpdr
OoxSEaEMJCrGqqwkGVxcMJTAV8snxQPRV0mRUlG7rA==
=y0Lh
-----END PGP SIGNATURE-----

--FwDPFHCG+7RZe1LM--

