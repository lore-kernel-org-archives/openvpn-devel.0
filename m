References: <E1hGico-0000de-16@...2508...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <30cb0306-9884-6599-3a1e-7983167720ba@...1227...>
Date: Tue, 7 May 2019 13:04:44 +0200
MIME-Version: 1.0
In-Reply-To: <E1hGico-0000de-16@...2508...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sRp3gzQWmYDm6PY5N3QoowKMQIGn4nK32"
Subject: Re: [Openvpn-devel] [PATCH] tests: remove dependency on base64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger <steffan.karger@...1435...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sRp3gzQWmYDm6PY5N3QoowKMQIGn4nK32
Content-Type: multipart/mixed; boundary="0S5mp5xSfHegSW8nzJleuhrwj3vKvd89G";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Steffan Karger <steffan.karger@...2507...>,
 openvpn-devel@lists.sourceforge.net
Cc: Steffan Karger <steffan.karger@...1435...>
Message-ID: <30cb0306-9884-6599-3a1e-7983167720ba@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] tests: remove dependency on base64
References: <E1hGico-0000de-16@...2508...>
In-Reply-To: <E1hGico-0000de-16@...2508...>

--0S5mp5xSfHegSW8nzJleuhrwj3vKvd89G
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 17.04.19 um 13:00 schrieb Steffan Karger:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> Triggered by the report from Ilya, that if base64 is missing, the tests
> would still report success:
>=20
>   Testing tls-crypt-v2 key generation (max length metadata)..../t_lpback.=
sh: base64: not found
>   OK
>   PASS: t_lpback.sh
>=20
> The easiest way to fix that, is to remove the dependency on base64 (which
> is it's current form wouldn't work on OSX anyway, because their base64
> doesn't understand "-w0").


OS X base64 understands -b0 which is the same as w0. But for example
FreeBSD does not have base64 at all, so I agree with this change.

openssl base64 -A  might also be an alternative but that "breaks" mbed
TLS build.

ACK on the basis that is actually improves things until Gert comes along
with a super obscure UNIX without seq.

Acked-By: Arne Schwabe <arne@...1227...>



--0S5mp5xSfHegSW8nzJleuhrwj3vKvd89G--

--sRp3gzQWmYDm6PY5N3QoowKMQIGn4nK32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzRZnkACgkQFRhsZwKx
RFQE1RAAsAVLuzdpHBsJ6QrXh+5HOfmE/6iKkGHOgpsSANGYsY5GZ+z3DKcXZCtq
VkV74wYXqgvIp3hDZE68h2MSgQwQGnmZ0lvbWI7jEukygikBOPqZecOb+Nf5BIBe
RIzbeNnIGJYKbB97k3DYghatF1+oyxOrFpdKPslfbTuPfeAtq8lK7iXmQFvMyEsI
S4vrvO9E7wCLf/DFaIclDCuERiZXIG2RxBCFrzj0o1SK6TlhTG9XIAk4yINi83Sb
wVITMIQ+ocEqj7Fqjhw47TDKf4H5hSzDR+MVXaze/blObCp1LfqdWShvJePbiA/a
rn0Wy3ewfKXT/ld7+N3fliIrEJR/FtJSswc4jXXmNCFa4qIPxoTe8ffqgwefNjTr
M2li82fPehzMci1gpcqJE5l9dVblB97S2MsGHhiTzkPxahsm7XBH1CLWLiQmHCmN
hUIJQ6q96PtKe1EAU55JWNPA9TOgES63oE5QqBnqocX/q0NX1Ua67skcP7VGm05D
0Nvk8vCcgE8xbfQnA8fPVGv5gaXeMsFVXniTuRBkv7H0//PxYts2YidbSr9/I4sn
CR/EnNxWLHDwsMn+FPQbsqpHhIpAhaxQBSGA1AFfeAkFcGXeieENN/2eRhXIs9SP
Tj6r9Ohjx8cNfAl9Wjar0PkUPTT++r26xr2HkKZgN4+L07MQo2o=
=7oMk
-----END PGP SIGNATURE-----

--sRp3gzQWmYDm6PY5N3QoowKMQIGn4nK32--

