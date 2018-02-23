References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
 <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
 <084aa45a-6ca8-33c8-2ba8-7839e3e59219@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <bcb03881-4bf1-31b0-375c-415f352522d7@...2181...>
Date: Fri, 23 Feb 2018 20:09:22 +0800
MIME-Version: 1.0
In-Reply-To: <084aa45a-6ca8-33c8-2ba8-7839e3e59219@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tJLdn722sL8e7lhTbfvuGcRLj7cLJCYqW"
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in
 mbed 2.7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tJLdn722sL8e7lhTbfvuGcRLj7cLJCYqW
Content-Type: multipart/mixed; boundary="F6A1xy4yyl8Z7CiDkC3nPKhoGD3w6UAiM";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bcb03881-4bf1-31b0-375c-415f352522d7@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: don't use API deprecated in mbed
 2.7
References: <1518006166-14285-1-git-send-email-steffan.karger@...1435...>
 <2c05c5bf-5b7c-5965-2cb9-48b9647df45c@...2181...>
 <084aa45a-6ca8-33c8-2ba8-7839e3e59219@...1435...>
In-Reply-To: <084aa45a-6ca8-33c8-2ba8-7839e3e59219@...1435...>

--F6A1xy4yyl8Z7CiDkC3nPKhoGD3w6UAiM
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/02/18 20:02, Steffan Karger wrote:
> Since reducing dependencies usually reduces maintenance burden, I prefer
> this solution.

You're right here. Ok, let's keep md_full() then

>=20
>>> +        {
>>> +            msg(M_WARN, "WARNING: failed to personalise random");
>>> +        }
>>> +
>>
>> Since we now have a reason for the failure, may it make sense to print a
>> proper description based on the return value? (even though I think
>> mbedtls_sha256_ret() can't really return something different from 0)
>=20
> md_full returns true/false, but you're right we can improve error
> reporting.  Are you satisfied if I add an mbed_ok() wrapper *inside*
> md_full() to print the internal mbed error?  I think that should be
> sufficient information.

Yeah, that would be nice. Thanks


I guess this patch fine as it is then. The mbed_ok() can be introduced
with another patch.

Acked-by: Antonio Quartulli <a@...2181...>


Cheers,

--=20
Antonio Quartulli


--F6A1xy4yyl8Z7CiDkC3nPKhoGD3w6UAiM--

--tJLdn722sL8e7lhTbfvuGcRLj7cLJCYqW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqQBHIACgkQB6U8WA7y
zXT3/w/+JXe3hNR8YDU5krVAtAHCBTiN5dcE0pVfoABB2P+NcSKu/Rbwfw1B71Ah
m+dZmHi5RoF6HHUHgPD7A8aK8FlkDlH1t0QhyWlEMzh7PNJo8rQUf2Hi47fmpDH5
PJ0YtGdV8avIh7ZwHmWV8d+j1rc6LJi/M59Ufk3Kkk7z/dsa2ZzW/CYkh2QeS+P1
h1YnfroVXrMK2B6uADtN0SbUekgMGuweR84e9ywpR2U8u5Gl7aWOnXSjS6rPJKHU
aW32xMJQK51JVxx62+sQo1P78KQ5Quko8j1w/cH7s0O/6KpPb0yMlNPjuiGJ+Q/F
lt+u4FzCH3w1IjyY3Pc0VuAjFLUfCyWGJU4RK9NfYv5SfQBTwuuA8REiuLOBSgmG
DxrDroWq1B/ByCgKbdKPtdFFNLX+Au8YrDQQmmZ6IuRPLNz2hoAWRgx96tj7YNt4
HKuhEucbDWdJP6MKKouhHOflGf+pv8jWWw8HAR6jihDLge5B4uPl9yh6a6uvwuYj
7RweLHAIj8wJcBldaOzYTjwWKbidMIJ3kqRgiWGUmBsXNbKRust5IbnQIJx3c76o
UoIv+ibdvbSgV4y8B/hoXBEKMtxbMV5+lGYIuo/Grpxn0L9Fh3X/7zvQOUfmZ+rr
D223Vt+xWtyNCwzbSAYHdp5hpu620R/24tFZdRmWVEJO1yq+Cgk=
=kUnW
-----END PGP SIGNATURE-----

--tJLdn722sL8e7lhTbfvuGcRLj7cLJCYqW--

