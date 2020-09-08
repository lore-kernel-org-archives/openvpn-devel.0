References: <20200908111511.9271-1-gert@...1296...>
 <8f5ce86d-f11c-4858-26c6-abc21200368c@...2080...>
 <20200908163523.GE75094@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <762075ad-7c4f-48e5-0887-d5a4083a9bf7@...1227...>
Date: Tue, 8 Sep 2020 18:41:10 +0200
MIME-Version: 1.0
In-Reply-To: <20200908163523.GE75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Dyc6S2FtrfLXawUa6lLVYtAbp5K9V4QtU"
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
To: Gert Doering <gert@...1296...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dyc6S2FtrfLXawUa6lLVYtAbp5K9V4QtU
Content-Type: multipart/mixed; boundary="rcfklTRXsWy4FW1vEAhU3zS78EiBdIwPV"

--rcfklTRXsWy4FW1vEAhU3zS78EiBdIwPV
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 08.09.20 um 18:35 schrieb Gert Doering:
> Hi,
>=20
> On Tue, Sep 08, 2020 at 03:11:40PM +0200, David Sommerseth wrote:
>> It would be good if --push-reset would actually not remove certain criti=
cal
>> options, but this is anyhow a good heads-up for our users.
>=20
> Well, that ticket sat there 10 years (!!) waiting for someone to go
> and implement it...  6 years it sat on your lap, 4 years on mine (or so),
> so it looks like this is not going to happen any time soon.

It also feels like a feature from a different area when pushed options
were few and not as essential to OpenVPN. It would remove/deprecate that
feature instead of trying to figure out how it should now.

Arne


--rcfklTRXsWy4FW1vEAhU3zS78EiBdIwPV--

--Dyc6S2FtrfLXawUa6lLVYtAbp5K9V4QtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9XtCYACgkQFRhsZwKx
RFTUEg//SZXudDxY6dQNr5hLpTg6T0UbFmhTPMXgEkeXfuQ6o3soRE3cvCzdvKlx
MtIBGpFjwkYrD8HZPhzxgKMimV/Wq3HjzfMi2hJ9502IFlRVynFTaaEg1VZ278rD
LbPL5BQJ/o7BPg7SEj/w0nXOxjXH7W7mLTsEMFOLbI4B5RuXYi9RbGrYCx6b/Ir8
ScJDjoWJXZPrOaoupA3hxrmtM4l2gW/pQSSugza8i8xjE4ZIbYef4ozWd6p5PuYo
w2RQEnhzdwHuzcFvbMHWZ3XNO8DoCGtttWqHeX8lRyfUr2BGW2XqJ4GJVOrqKkKH
zavifC04Ht6s2wTKaIVozRmSrFTNDfA2CTrNdXo9RcHoOXxpHa8m++OiBnZrKvAZ
/bNVEjS9KLjAhR5A4xReWKaqphHQ1SyTeE9RzchqlLVCichFgFubGMRF72aIE+sS
SY205GKs4KdUUGZQuirfhO2es5dI8Te9h6wjaLPA1CygcbwP8ka559en/JrOmi2y
Gn0T79zh3aaHo/1TUpL+4M80MP+8PivXn+GRODRw8aTGTTErSwh5MiBsK94CYjXE
wN5At1LRPRHvt0wMH5tmuGKQgdRtKKTP9OiTzGvGgw0XBp8dXw+evhRpGfs9SHaN
9Kys5Jln29EmqijeidCbgvaHUp/O6888ygEon//8TXIYjy2RBo0=
=EpN7
-----END PGP SIGNATURE-----

--Dyc6S2FtrfLXawUa6lLVYtAbp5K9V4QtU--

