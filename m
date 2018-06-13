References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-5-a@...2181...> <20180613112912.GQ57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5b26aca2-24ee-7af8-5f47-02ff4080b404@...2181...>
Date: Wed, 13 Jun 2018 19:42:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180613112912.GQ57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gt0CdR0J9cyg0o037Fh1R006nrnEDPEhV"
Subject: Re: [Openvpn-devel] [PATCH 3/3] tun: get rid of tt->did_ifconfig
 member
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gt0CdR0J9cyg0o037Fh1R006nrnEDPEhV
Content-Type: multipart/mixed; boundary="ROWu49yk5lOEzvPqwjdfytvridoBSMYNV";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <5b26aca2-24ee-7af8-5f47-02ff4080b404@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] tun: get rid of tt->did_ifconfig
 member
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-5-a@...2181...> <20180613112912.GQ57262@...1296...>
In-Reply-To: <20180613112912.GQ57262@...1296...>

--ROWu49yk5lOEzvPqwjdfytvridoBSMYNV
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 13/06/18 19:29, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jun 13, 2018 at 04:12:18PM +0800, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> tt->did_ifconfig is currently only read by the Linux platform, but
>> it is currently iuselessly set also by every other system.
>                   ^
> If you're respinning v2 of this set, there is a small typo here :-)

Thanks for spotting this.

>=20
> Otherwise, ACK.  Thanks.
>=20

will resend the entire patchset as v2.

Cheers,

--=20
Antonio Quartulli


--ROWu49yk5lOEzvPqwjdfytvridoBSMYNV--

--gt0CdR0J9cyg0o037Fh1R006nrnEDPEhV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlshAzIACgkQB6U8WA7y
zXTyig//X+tJFDInlhCZY8vijR2zuHJFv/ytP2Idmq80m+Gg3aTnv4ItZWyi4+Gb
NdoiJM6OD7ZdMckkaccUdOXqPtPvxNL3LUdMfRzati15TUBvZzQwnp+mIC5otX/z
rNhY2Q2dXY6vtVz2IIhb/mgSi9Y/xA+gi20U7YJtUscSOiFVDb2K2OiUqNFUJ0UX
eVIFtjnNFiCvg8sfU2Blix1SGEwKOGvBEgeMC066o/4maeNFMad2LKwhi7/i0T94
QLBIxu0yj+qgRpQPck8wOdivxVsMf1gZ4w5I8bWxj0RrsR3vDjYZeG5Znl/utyaN
GxlKq+dV/YRXFUrpLTpp/S4tWTFNqPqOiojLQz0mseIO1KRvJONYIZtdAAC1FT/X
OjFAZI5imKUSpEO/32TL21HtuvFxbmntzHYhe+9j9305TNarK04mrcIw7ApP5Ss2
m7CuldJT+mrydx0EHtXAgkAGEuPe3uvuluZ5qJewIlEss1R3aN/4XGrkbeMkcYAf
HVFmKUDT/4wFFiPa1S5dTLv0EoN5tp6Jo9RVQZo2UJm+xCsb7R8kKpM769r3XyLL
Gjg70H9CMiMK4N0f8Yva6Xlc89hMX5wlwBGcki+V/Xxo5zUqpBIclu/aA/JZQoF1
Ud3MNzJ7BbdkQSFCtrIDJidXNyiRd4RpxinzMGsekpwlB2zNhE0=
=plAQ
-----END PGP SIGNATURE-----

--gt0CdR0J9cyg0o037Fh1R006nrnEDPEhV--

