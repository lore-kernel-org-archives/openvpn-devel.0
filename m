References: <4B3OgL3j077iDP_MhneRo1v3CxM7prwXD2RgkpFEKEK5OUPBRPTsT2E6lJDmOzUw2Vf_T5FtOtUUnMzBh06X0L7z3zl00BgZP_a01CXQkh0=@protonmail.com>
 <ed2ca789-8501-f54b-3fe1-03039d456b93@...1227...>
 <CAKuzo_gF00xHdDK++Bj-KpBEeVHb9meq=tAEu=FMfnTovjqE7Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <dbfda552-b771-cf31-26b2-4917e5b246e7@...1227...>
Date: Fri, 24 Jul 2020 12:00:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gF00xHdDK++Bj-KpBEeVHb9meq=tAEu=FMfnTovjqE7Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ugR0nRtgoNIM8FfbjPoxto9KVw0BsVsOg"
Subject: Re: [Openvpn-devel] Regarding deprecation of --route-nopull
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: =?UTF-8?B?QW5kcsOp?= <pippin1st+devel@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ugR0nRtgoNIM8FfbjPoxto9KVw0BsVsOg
Content-Type: multipart/mixed; boundary="RIcXgLditvyvqYyaOvdzsm8uOreBFi2Hc"

--RIcXgLditvyvqYyaOvdzsm8uOreBFi2Hc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>> Also route-pull works in both OpenVPN 2.x and 3.x
>> clients while pull-filter is currently 2.x only.
>=20
> Actually pull-filter cannot be compared with route-nopull as the
> former is customizable. The real question is whether there is any
> compelling reason to use it other than lack of alternatives in 2.3 and
> older. I didn't know 3.x does not support pull-filter. Why? It's easy
> to code (at least I know that for sure) so that can't be the reason.

The compelling reason for route-nopull is that it will catch all route
related options even if OpenVPN adds a new one in a future version. It
is a simple way of saying I don't want my routes to be modified.


To emulate pull-filter with pull-filter you need to block this list:

redirect-private
redirect-gateway
block-ipv6
client-nat
route
route-ipv6
route-gateway
route-metric
ip-win32
dhcp-option
dhcp-renew
register-dns
tap-sleep
block-outside-dns

but not block

route-gateway
route-dealy

And without looking at the source code you will be hard pressed to come
up with the same list.

Arne


--RIcXgLditvyvqYyaOvdzsm8uOreBFi2Hc--

--ugR0nRtgoNIM8FfbjPoxto9KVw0BsVsOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8asUAACgkQFRhsZwKx
RFSzIg//S00BuDHIZLIKxSiSmd2nUK6x/bONlKhXBdkwdPjpWcNfqzZ+5ojOzVuE
Foomm/YT+Zszb11Izy17ZEA3WhhXfMBtNhG/KPF40KlEVjFTgMMrbyFuvXppttf3
42FkiwqWxOACNMYUrxYzRMwwks3td9I0Lw7B4BibX3iBj4L6lWMaDQsjXKz1WhJX
W0+C9kA/j1wzNfo2eN6MbyGDyyR1QfVF0oAAHrtW08OpQteqothNBfzNMD0UBuQU
MmYPhBQMy5lSqc/Mn4ScHddni1/n/QhZD1U6G8HJPM1Y29mCsO1cPg4xlu13QYqP
aLYjFrELVNm4ArLuBUnyzneD9NFkCi+48K2CulhhGIux/7YZJ8UdwbecSBb2KfYl
g/MesZmCMj/4m3fQ/J6PwubpuNwl7Os/U+OMerYF4oCkjv47J6gU+RE5gTPj45UG
shnDssq0pdbpUazXnufLLwCu6lLPksuVldk71eCWQluk3avEWN0DUmbyI1f1fk3P
X66AYYPfWMFsy/9YFz3Cy3wX2X54wrcRAq1fCOXIeeksLYEGvj+bmA2+yn70AoK0
mhNHnd/T5qaSuANGdcWT7BHBvphww772mejINT2BDKuPG5kdf6VypmcdCfpheghg
u3DqMF+dklOuAirfTBI+juZ9EMiLgrH4vZWPMPlkLg4A86FWSM8=
=ftnn
-----END PGP SIGNATURE-----

--ugR0nRtgoNIM8FfbjPoxto9KVw0BsVsOg--

