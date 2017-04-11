References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
Date: Tue, 11 Apr 2017 23:56:42 +0200
MIME-Version: 1.0
In-Reply-To: <429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1pukBSToujfwjjLgXQ7O6wG5VsSiO7GmS"
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1pukBSToujfwjjLgXQ7O6wG5VsSiO7GmS
Content-Type: multipart/mixed; boundary="j8QwmFtwSUUWbIno9Ne3fIoFMjMDVSWKd";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <050f70e9-1558-a354-ea36-8b786f0af086@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
References: <20170411173133.18060-1-davids@...515...>
	<429bda10-5a65-785f-661e-f4ae2708349f@...1435...>
In-Reply-To: <429bda10-5a65-785f-661e-f4ae2708349f@...1435...>

--j8QwmFtwSUUWbIno9Ne3fIoFMjMDVSWKd
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/04/17 23:20, Steffan Karger wrote:
> Hi,
>=20
> On 11-04-17 19:31, David Sommerseth wrote:
>> As RHEL 5 has reached EOL, we no longer need to support OpenSSL v0.9.8.
>> This also makes it possible to remove a few workaronds which was
>> needed earlier, as well as some left overs from v0.9.6.
>>
>> This also makes ./configure really stop running unless a new enough
>> OpenSSL library is found.
>>
>> Compile tested on RHEL7.3 and RHEL6.7 (mock chroot build), both shipping
>> openssl-1.0.1e.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  configure.ac                                                  |  6 +++-=
--
>>  doc/openvpn.8                                                 |  1 -
>>  .../keying-material-exporter-demo/keyingmaterialexporter.c    |  3 +--
>>  sample/sample-plugins/log/log_v3.c                            |  3 +--
>>  src/openvpn/ssl_openssl.c                                     |  3 ---
>>  src/openvpn/ssl_openssl.h                                     | 11 ----=
-------
>>  src/openvpn/ssl_verify_openssl.c                              |  6 ++--=
--
>>  7 files changed, 7 insertions(+), 26 deletions(-)
>>
[...snip...]
>=20
> For master: ACK.
>=20
> For release/2.4: I wonder whether we need to keep 0.9.8 support, as
> SLES11 still ships with 0.9.8h, and has general support until 31 Mar 2019.

While it is James who insisted on RHEL being the oldest supported distro
many years ago, I have no issues with keeping SLES *or* RHEL as the
oldest supported distro, in regards to package dependencies.

Do we know if we have a large group of SLES 11 users?  Initially I
thought it was related to OpenVPN-NL ... until I recalled that
OPenVPN-NL should be built against mbed TLS :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--j8QwmFtwSUUWbIno9Ne3fIoFMjMDVSWKd--

--1pukBSToujfwjjLgXQ7O6wG5VsSiO7GmS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY7VEaAAoJEIbPlEyWcf3yD5oP/3CPbtXzJBSbvf4WTYCVCDeC
knO7ONQ/5TQjFN3VScdXgkEnIwuQ/6QOegPyUQj3whddB4DDHYOPoZo2UTXxlzJm
4wZChJkLoa6eRW2gyp4BnZP30xyj465+YpVI9f8z2G8KMOggYRTR6oMXKg5Y17U2
DFugEABCUBe45jWJ5TazT8rMGBEnbPh4jojcrZIFah1mGTgKh64O7N9ZqJ6ZW6xS
X+ih3Zv7YbfyCcJLvIdovUB8AzOGI4tQpN3kQcfIRJ7fO1llBKmxjovmo54mWX5m
KT364oUompQMbmHyxOFmmfUE8HnpUpKKyJk8VlPzQFy9CD2fyz6DsAZgnobCt5/U
t2dWDnnuduXitzHasyJKuT+irN43PelZXasWeFB3zAPXv8/y6m3106f9UuLW2pWY
H/zmIagP4BpMg5lrFzcs1NatrZiQY/KZD3fKumILXqSwwuuBHrg2J9x7HDUkG+x8
Op6C1OZ7ce2dXfQ+1G2DRocBjunwoeDEYQn6TDtBOx6QMhxkWXTkwJh2yH+pufwh
4IxPOKLxTPhxKG4YzQ+hlHIb8WKMp6fS5iB42iJoMWEOWSWWm2U+uVlVcI+pQ9uH
ml/cPX7ptBjZe73mKXM77KuutGsiigN22sxMA93BDNM3NSTh7XmxKZbBTkFhrq2O
PrFZsJXWaiR/Jei7vJF2
=qDoY
-----END PGP SIGNATURE-----

--1pukBSToujfwjjLgXQ7O6wG5VsSiO7GmS--

