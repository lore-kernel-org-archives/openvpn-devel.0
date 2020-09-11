References: <20200911085907.26004-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a9d24370-8221-986e-cb93-4bac3fe14602@...1227...>
Date: Fri, 11 Sep 2020 11:10:11 +0200
MIME-Version: 1.0
In-Reply-To: <20200911085907.26004-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LZxlAZqZ00sbSfzgEEfkhc2dTj0pyCuWF"
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of 'route remote_host' for
 IPv6 transport case.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LZxlAZqZ00sbSfzgEEfkhc2dTj0pyCuWF
Content-Type: multipart/mixed; boundary="SijhS2L2KPmRL4z0ZzBdhLzzbtkJ8yHH7"

--SijhS2L2KPmRL4z0ZzBdhLzzbtkJ8yHH7
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.09.20 um 10:59 schrieb Gert Doering:
> If we connect to a VPN server over IPv6, and the config has a
> route like this:
>=20
>   route remote_host default net_gateway
>=20
> OpenVPN would try to install a route to "255.255.255.255", which
> is obviously bogus.
>=20
> The bug is twofold: init_route_list() should not set RTSA_REMOTE_HOST
> for an "IPV4_INVALID_ADDR" remote_host (wrong condition, this is not
> a pointer but an integer, and "invalid" is "-1" numerically here),
> and init_route() must not ignore "status =3D false" returns from
> get_special_addr().
>=20
> I have just added the "if (!status)" check, not done refactoring for
> init_route() to see whether I could make it "more pretty".
>=20
>
Looks good.

Acked-By: Arne Schwabe <arne@...1227...>


--SijhS2L2KPmRL4z0ZzBdhLzzbtkJ8yHH7--

--LZxlAZqZ00sbSfzgEEfkhc2dTj0pyCuWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9bPvMACgkQFRhsZwKx
RFRuMg//ZN8vwGXvZ9eum87KcxnnwdnBeiewaXxbs8oPQK8/rUXK/h4ImSD0kyOE
2Mc6WLRtiKI9/P6+UECIeDwICNMrUrMKg52XI0flv7loa3zjooUL+KEmIcwAPJpv
WMJkLZx8vV9ypV5GfJpj2M3RI2uvLM+8C/krcapbwK6gfb3QqDzN3ElJgKwILe/q
ymSiaY97meZ+G//Ri3wVcf7BofvpC3/hnikfVEanHVVl/7pUfSJviXX4f5JhdqwU
+ihYA+fcZ6SJH80zzM8orNCkqG/X/UcOwLDJyfQNK2TBsQl9f/d2f9Pwui2yyqIY
YzeJnaxBDuzjGDoq2PHVZ3EWuASebcVJGHKux0L2vyQn15igPeiHihW2CZprl+Jj
yfgH65VUPLBxuER5xL+6ZNdTbFcNppS2JuFmVAzbJX+i6XSP5eesf33p5P9rhZkB
OnY8ssrKc27zH0S+S3II6+Q3jxTq4W+cG2Q9Pikgz9Aq26ErCEPIHWlSDuEtWfRW
PkhY73fsmZL/Xihi9TG38TlRrOwMYlawNXZ8d5i0s5NWP3N9nb5AciaZET0pZR2n
HjKaN4YfS74ioT39l7DQ1dPHJujTx8G/MHIc5PeNZ+UehNEgKvf8YAcHMHxseC3t
zllKl9p6JrK1UbDd2JYvyfRMUl98hqkunM2p5FzGYMEkkxNHBug=
=SD93
-----END PGP SIGNATURE-----

--LZxlAZqZ00sbSfzgEEfkhc2dTj0pyCuWF--

