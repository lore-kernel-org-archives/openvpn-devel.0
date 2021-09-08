References: <20210818213354.687736-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9d0a59f1-17df-cf3b-0744-1873f280b936@...2080...>
Date: Wed, 8 Sep 2021 18:47:55 +0200
MIME-Version: 1.0
In-Reply-To: <20210818213354.687736-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1Li9jFGb9j0M87UXL7IKv7ttruEbP7Zsm"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Detect unusable ciphers on patched
 OpenSSL of RHEL/Centos
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Li9jFGb9j0M87UXL7IKv7ttruEbP7Zsm
Content-Type: multipart/mixed; boundary="m96myqZ7sqjEE5xGEGgwCvb67sjH7E2ET";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...1227...>
Message-ID: <9d0a59f1-17df-cf3b-0744-1873f280b936@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Detect unusable ciphers on patched
 OpenSSL of RHEL/Centos
References: <20210818213354.687736-1-arne@...1227...>
In-Reply-To: <20210818213354.687736-1-arne@...1227...>

--m96myqZ7sqjEE5xGEGgwCvb67sjH7E2ET
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 18/08/2021 23:33, Arne Schwabe wrote:
> OpenSSL on RHEL 8 and CentOS 8 system when these system are put into
> FIPS mode need extra code to figure out if a specific cipher algorithm
> is usable on these system. This is particularly problem in data-ciphers
> as the errors might occur much later when a client connects and as these
> cipher are not caught during config initialisation.
>=20
> This also prepares for adding Chacha20-Poly1305 when available to
> data-ciphers by making the detection logic used to check if
> cipher_kt_get returns non-NULL work on these systems.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   src/openvpn/crypto.c         |  6 ++++++
>   src/openvpn/crypto_openssl.c | 10 ++++++++++
>   2 files changed, 16 insertions(+)
>=20

I've Looked at the code, built it on a RHEL-8.4 box with FIPS enabled=20
and tested the binary with FIPS both enabled and disabled.  It works=20
smoothly there.

The OPENSSL_FIPS macro is defined in=20
/usr/include/openssl/opensslconf-x86_64.h. So is handled outside of=20
OpenVPN, and without that macro we don't need to be concerned about the=20
FIPS_mode() function.

As mentioned in the community developer meeting today, there are some=20
concerns about the recently released OpenSSL 3.0 and FIPS - but lets=20
tackle that further down the road once we have distributions with the=20
latest OpenSSL library more easily available.

The bottom line is ...

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--m96myqZ7sqjEE5xGEGgwCvb67sjH7E2ET--

--1Li9jFGb9j0M87UXL7IKv7ttruEbP7Zsm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmE46TsACgkQhs+UTJZx
/fIzNhAAgg+cWWYsmjHV7TS6MxmetmW/lz+j2PuuZRau0Tf1HmuTJ18TLyDExkRQ
CpLe5Eot2edo2PbEl2CxmFRR6WEF1wXlCU8IbJO//UXen5L67FAUAg6P309vmtFB
/U9n2dDmVUA/2/hUMPLdNEcGNwOp5CFM0ZchCnUhITAWvB4Ol0DCVEx7QGTSFTV5
RqZQ1ig/Za38ig9+u0LLknqaQj9GHwjUF9GVYj+QC1BHzwFF+hTsl9HnDTUZGk2w
g0884z/P6cKfNlR/T8FDioAUb0e6iNh5k61bdaJMpUXx64zMpXkssgGA6/D7KE9+
+28VTmumP0dKYonep3g7cU5dx6vpmi6bKSYbmmMwQmLUl2fsWa9DDjRyuFIx0YKn
Vn6UmRVnXa4+y4uZ9bECwFkdb47xld3ZGHWXnp2OCfr2aU8fpcz257xccDJydzE5
DBLJz8APBh5sWtOwQskxMnn+4KB1/ADfXkx+FkbHg/eVPi4ojpJ6/p+9t9w8b/20
aYRNvhCUIHIVRGaGtneoKZkFMfptWxVcW3LYwAtam/EOGCf+GPldiyq9AcLCLKZE
8Dzf9/mNx+MPs7OtkG04PWujo2pFMolO7os3jC/+d7VTfXaEIl8JQpgwWCWXbPvb
voDQLe5WaKy5lhCHrj2Q7o3xUGV+uyT/g9gRil3A0kWq5g4sxdQ=
=ju2R
-----END PGP SIGNATURE-----

--1Li9jFGb9j0M87UXL7IKv7ttruEbP7Zsm--

