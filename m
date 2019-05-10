References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1c92fa00-1ec0-e063-3fc1-8ebbaf63e9a4@...1227...>
Date: Fri, 10 May 2019 14:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-4-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iDmcoM8GCWqr92kFw2KIjJitymwRuDWUB"
Subject: Re: [Openvpn-devel] [PATCH v3 3/7] tun.c: use new networking API to
 handle tun interface on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDmcoM8GCWqr92kFw2KIjJitymwRuDWUB
Content-Type: multipart/mixed; boundary="lgqVGFdAGPYR5xq9tV4KX6Ka2bMyzvsdl";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <1c92fa00-1ec0-e063-3fc1-8ebbaf63e9a4@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 3/7] tun.c: use new networking API to
 handle tun interface on Linux
References: <20181219050118.6568-1-a@...2181...>
 <20181219050118.6568-4-a@...2181...>
In-Reply-To: <20181219050118.6568-4-a@...2181...>

--lgqVGFdAGPYR5xq9tV4KX6Ka2bMyzvsdl
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> By switching to the networking API (for Linux) openvpn will
> now use any of the available implementations to handle the tun
> interface.
>=20
> At the moment only iproute2 and sitnl (NetLink) is implemented.
>=20

Acked-By: Arne Schwabe <arne@...1227...>

Arne


--lgqVGFdAGPYR5xq9tV4KX6Ka2bMyzvsdl--

--iDmcoM8GCWqr92kFw2KIjJitymwRuDWUB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlzVaxsACgkQFRhsZwKx
RFRagQ//UE1soQLynJo5GtOetbXEyKZ4EfRpfR8jOjH/OciXXYg1HXA4JFNwRNZn
oyW/+X+j//IHuKTDK/ZCakvSURr89GuoybID9vCFxBLKylHx5ITKNYAqsuGP9z0m
pM7M25kAuvXgCsSv2qJMrwDNlq0+mgEPmYAwE1el8/GPLuDCtuA0TH5xGYg4acf8
Tj57wCX9/JO1zgmUC3MgfXZKSn0ehBWsujpZ//mQ0W3FG9MDd9l00idcObSVcli0
SAL2sIaR0OxDBK9FOhSNua9291xipuBk/MM6Jh25jtsB7KG3tja8ea/1cat7vwar
Ha2y6K1u3JwLNTL0RYci56WCGnJCs0eyuPAGn8ZonXpmQjvV7fOrKvFu1KMFgYFZ
l/lToOCx1/E1fO6ooy2PHqb4w3rdjmPbfU5rwLTVEUTFLDZBKdMH8xUyHUg2DPRr
W5S/KJcv3C8y0vo5CL58sW8BhSDuE///zjoWtbNszfASBsWr/XF568FIse5wrprO
kbLFVfP/G0m65cQSjRSw2tOMoVNyKudhzr9wk0aGIO3OiqXHrBrrph5eE+5fFni/
DZzkROatEDPyUvmj2hLxI8LTuGla7ByN/QTCBLRYYHriEe1K0BPGIsJc1cOQpibo
kDikTZkBC3IkumVreBnjjtHxd1L/w7xs0XpSHP6oizAmZzZTf9A=
=QR1Z
-----END PGP SIGNATURE-----

--iDmcoM8GCWqr92kFw2KIjJitymwRuDWUB--

