References: <20170718132030.19820-1-a@...2181...>
	<20170718134612.10695-1-a@...2181...>
	<20170718211600.GB70062@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <79c4dbc8-46ee-c351-bf8b-b172b8505fc3@...2181...>
Date: Wed, 19 Jul 2017 10:23:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170718211600.GB70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LkfFeKRQx5dn0QvpqfE79gHCVIIedAN6h"
Subject: Re: [Openvpn-devel] [PATCH v2] route: improve error message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LkfFeKRQx5dn0QvpqfE79gHCVIIedAN6h
Content-Type: multipart/mixed; boundary="hMjVHL63KRG6mApQLRxvpGPW9sJcMaMCt";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <79c4dbc8-46ee-c351-bf8b-b172b8505fc3@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] route: improve error message
References: <20170718132030.19820-1-a@...2181...>
 <20170718134612.10695-1-a@...2181...>
 <20170718211600.GB70062@...1296...>
In-Reply-To: <20170718211600.GB70062@...1296...>

--hMjVHL63KRG6mApQLRxvpGPW9sJcMaMCt
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 19/07/17 05:16, Gert Doering wrote:
> Hi,
>=20
> On Tue, Jul 18, 2017 at 09:46:12PM +0800, Antonio Quartulli wrote:
>> - fix typ0 in message: NLSMG -> NLMSG
>> - use strerror() to print a human readable message
>=20
> Thanks.  What about "not printing an error for ENETUNREACH", if
> that's the new "no error, but there is no such route"?

I wanted to rework that in another patch, but yeah, I'll provide v3
including everything.

Cheers,

--=20
Antonio Quartulli


--hMjVHL63KRG6mApQLRxvpGPW9sJcMaMCt--

--LkfFeKRQx5dn0QvpqfE79gHCVIIedAN6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlluwrMACgkQ0+HICM1s
oFBUrw/+Lmu+4I+tWxqnGORd20qiUfUVOZ8BKTtO61Uk9h4hQBOR8da9I+2/HUfc
jLH4kx4gThYB8z1SI5thKenfotFAnVlTah0skVCZ3jD6aWHK9L4A22eEZYw0AKLD
UtuYRECX0IThh88CF+j/lVbhmaI/gAG+nUWoTPChP0tRqWt1mi5mAPeKMKnTCZzE
eF2AADmrd/WYnFKBIBObl8JBOO1ERgcmWwv/L1DdpIGeDDSNpJlWyZ2g1/kpMZoO
TDWoxIicd9xEFVbA4RiMU1SAC576Tlrk7YD3vjzCS8XBkbuwhO3lIsHD9OWqMNvR
9wr6KUOAFTMVVhbjquf9P/hnWtdg7QSxtjgA1WQgi6o7N2MU4WkNrLpHn8E+v0EO
uPJ/e5ieV32X3iGI13SPV/qyDW7tmn/USN9j9hYjbu+1ZHw0/Vbwe0p9VoveQQQQ
5acch40pSo1Xc/s8v6ktNSeGvUV3TV2yfUDKe/T9Qw4VOq0uV5TCzU1rmo2wkEf0
omi5sb8VXfZhDN7Hs9PrZURq3p6DhU19J8mZT4Fnq2OmtCf637B0MDtstOmky41e
0jVJlCVaL+7k/yLw5UU55QWKJ+spHHJqk0G88NsR1rksS+ivY9AVlTgNbym7mrwB
MjX9U6wrvSuqvNFAlfUstJdzHmJ8LfTpdA4k9YPuWeDfKAxl5bk=
=rhvR
-----END PGP SIGNATURE-----

--LkfFeKRQx5dn0QvpqfE79gHCVIIedAN6h--

