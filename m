From: Arne Schwabe <arne@...1227...>
References: <20200908111511.9271-1-gert@...1296...>
 <8f5ce86d-f11c-4858-26c6-abc21200368c@...2080...>
 <20200908163523.GE75094@...1296...>
 <762075ad-7c4f-48e5-0887-d5a4083a9bf7@...1227...>
 <eAWhYvj75Zizi0tQw1j-aAO6OQYYZZhQFc8scdog5dIVs9au2ZcRGqVZN0QkmlmxPwasBDCV7wWROCzi0d5h1A1YKwGHOmOO5hfXL3e823o=@protonmail.com>
Message-ID: <a1e8e907-537a-1455-88c5-1a25cca17527@...1227...>
Date: Tue, 8 Sep 2020 19:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <eAWhYvj75Zizi0tQw1j-aAO6OQYYZZhQFc8scdog5dIVs9au2ZcRGqVZN0QkmlmxPwasBDCV7wWROCzi0d5h1A1YKwGHOmOO5hfXL3e823o=@protonmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zPPk1vFb49q7OPJhA4xVPsQ4sl5i9tYqU"
Subject: Re: [Openvpn-devel] [PATCH] Document that --push-remove is
 generally more suitable than --push-reset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zPPk1vFb49q7OPJhA4xVPsQ4sl5i9tYqU
Content-Type: multipart/mixed; boundary="0vq2dZYGQLhazvDz3kbGDSVkjOWejGIEO"

--0vq2dZYGQLhazvDz3kbGDSVkjOWejGIEO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 08.09.20 um 19:04 schrieb Andr=C3=A9:
> Hi,
>=20
> My vote would be to deprecate --push-reset
> (same for --route-nopull)
>

Route-nopull is still a very useful option that has no good replacement.
I regularly use it when the server should not mess up my routing table.

Arne


--0vq2dZYGQLhazvDz3kbGDSVkjOWejGIEO--

--zPPk1vFb49q7OPJhA4xVPsQ4sl5i9tYqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9XwrgACgkQFRhsZwKx
RFSy+g//YzdjgLKXcT8xOfwA+fdPFPE8HcOBqakQZRLGjky95SzV1BR1PvS2JQwN
oNFtED8TPPN+Mk3Qq6Wp72JZZ/WXH031UUBzk09Fxt0EOOo49r+1rk/HrNtGntF8
NcWyQhjPE631JkGjgPcUds+k4J2P7TwET9H8yLBmIMhlK1k1BlXimzP/XeG/e566
k0UIsrdFHvLXuq5jFl5M42rIHxyLnWM0P/dqQbLPbL70Xu2XAa0AV/Vt17Jovkzw
nlWK/s6COZ5ioqhr9UHBjhpMXysAGc3XtIOZp0DoMYJFZqytU6qSLmeEOHj8Yxxa
WsbvjtEPkJHOi1mw5Dhw1nohtSly6oGE6iPAa7I3tJir/YXysnQwZnBQal7lsjzt
tO3mrkR+n88rExcUmgeEF17z6us19rU5ldQ/A7MRMapTEWSfg6hiZKnC1BBEYPRa
x8/t+vgXOkeHXDMSJjVWr5gkgltji8zzCRXHYs5P8RQ06hAvOk2CwR5K9yvc2nYf
YLkPaeQivOLPYNayr7cJ6eL1j073aZYwTcEKmomNYvbCA1yqzM5t64bDCX6I76oO
bZovSYqyQdzyWPlx7XeLPXlazshhzmFJI7n42p/XSBXZgW/uzVzQ5xhe7C8mCR4R
HGzRTmPN2Py+6TDtGloAOjQiaXDQzG3vK3K8dvP/T4OqtsLt98Q=
=f1o7
-----END PGP SIGNATURE-----

--zPPk1vFb49q7OPJhA4xVPsQ4sl5i9tYqU--

