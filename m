References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
Date: Thu, 10 Sep 2020 14:16:24 +0200
MIME-Version: 1.0
In-Reply-To: <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CoXE2119Mlbb0EskeWErqKcB6XyfFMMSm"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CoXE2119Mlbb0EskeWErqKcB6XyfFMMSm
Content-Type: multipart/mixed; boundary="m29ekCgXKXsPZlcYiR4uOeCeuSj8YXEqi"

--m29ekCgXKXsPZlcYiR4uOeCeuSj8YXEqi
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 10.09.20 um 14:11 schrieb Juliusz Sosinowicz:
> Hi Arne,
>=20
> I understand your concern and apologize for the delay. We have been busy
> with the release of wolfSSL 4.5.0. I will make sure that the fixes
> necessary for OpenVPN support will be prioritized.
>=20
> Sincerely
> Juliusz

I think the best way forward is to include wolfSSL support into OpenVPN
master now and if we have proper a proper support of wolfSSL that is
kept up to from your side then it will be part of the next release. And
otherwise we remove the support before the next release. That should our
concerns of wanting to see ongoing support and also your concern of it
not being included.

Arne


--m29ekCgXKXsPZlcYiR4uOeCeuSj8YXEqi--

--CoXE2119Mlbb0EskeWErqKcB6XyfFMMSm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9aGRgACgkQFRhsZwKx
RFRDbBAApZ9J1PFp7WCrEOpiIzX6wsI0Fv1gQaJGHcsxlNavs7kUqRXCGFquPw2N
3w4TzuF2m+ypj4dZaqxAUt0JP47+eVnF0fPfBbb3cEr0msoHeJmp1t5x/tib73ox
cIae2OBbVfyEb9ZcOr3izIvRSOkUC3eaEOfPJ/7TjovaDN17mjcJm6qxULZhd4l4
L/ch5bgRhjbUn3weeLxZhoiB06lJR1bmDuMm0jVkjgB9HhQ2B9ZuHHJYmne7K6NF
6+CcdO5qKm/oKrjQhNlVSITIzZ2sJRolbHfGvvTbxiWAWH8Qedqv1Z7mlgTrrUB+
xfSWlAGbhM+gIf2k2zsE60/M8I6C1PdOuRvOkXLTSPyai6XkijLy/NAf3LdzayeP
5XE3EtfrgsCMAn5DnCMvXTXgrYQKLwuJ7fFmKuZdNA32BGB9qtWi5ZCZIS+ftwz+
YwqL3L9YtHD3p0wGLqAxUrqI5OV60y51pR5szmUK18STbai+4G0Ve2EbDyhOlBfj
okUIi4oeknqiq80lnEzo1V+5sX/WJebn4Ny9aV1cUj7y/kfsj+mM+U8NEAPTnBbm
MM8/ZL9EvPuTrKDCuLwBw/S2mlPqo6GhISt6DfNSVy5LZAgBoefIDtEhfh+PofZ3
PtKK6Fm5XM4GYavPrlNQNXuqqWi84qFK3Q/Jv30D7TKOrXN45AU=
=/QOl
-----END PGP SIGNATURE-----

--CoXE2119Mlbb0EskeWErqKcB6XyfFMMSm--

