References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
Date: Tue, 23 Jun 2020 10:34:47 +0200
MIME-Version: 1.0
In-Reply-To: <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pujO7MPzXk9QxjSpzi8wnVpyzOycnftJp"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pujO7MPzXk9QxjSpzi8wnVpyzOycnftJp
Content-Type: multipart/mixed; boundary="8k2kxHWkB0mIzrFzG47slih6Pb0Q20tns"

--8k2kxHWkB0mIzrFzG47slih6Pb0Q20tns
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.06.20 um 06:16 schrieb Dmitry Melekhov:
> 22.06.2020 20:58, Selva Nair =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> +*WARNING*=C2=A0=C2=A0=C2=A0 This MAY break configurations where the cli=
ent uses
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ``--disable-occ`` feature where the ``--cipher`` has
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 not been explicitly configured on both client and
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 server side.=C2=A0 It is recommended to remove the
>> ``--disable-occ``
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 option*or*=C2=A0 explicitly add ``--cipher AES-256-GC=
M``
>> on the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client side if ``--disable-occ`` is strictly needed.
>=20
> Well, may be it is possible to add support for setting cipher in ccd
>=20
> as it was possible before 2.4.9 using patch from here
>=20
> https://community.openvpn.net/openvpn/ticket/845
>

I get that this might have been needed in 2.4.x with the first version
of NCP. But the NCP negoiation in 2.5.x should handle all use cases.

Help me understand why --cipher in ccd should be needed?

Arne


--8k2kxHWkB0mIzrFzG47slih6Pb0Q20tns--

--pujO7MPzXk9QxjSpzi8wnVpyzOycnftJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7xvqgACgkQFRhsZwKx
RFSqXhAAphoBzmj3X45EP5ehufrhD5zeXs6+UezXXWduAkAV+aZC9KmMxHy73fq7
21n0qy1p2yHqZvq7p0UjVJWiopaRX1B5Pm5RQNCaCfYxrkDrsXQPTEaPzoQh6s9q
+T/ApAOH0F/HNyCXdO4+z6jZsNLqVfDMeutrK34dM77n7IQIhDie1L7CVkl3N+Bz
2oBtDsCS25m8Iyft6T1br3CDAE2DgxQfrbBG6JI4Vudgi7ZrW0Nuplis4NuTD4CD
XAzuMW4UgjtdtNoJuIC9mVlSAu4JdEyIykof478BAlrwOrXb+19jhoB+v/Archp0
Cbe2mHNs8TaZOVwado4/wzGgmmgIcZ8LCvqW/fyB8PyJr1nHj+h5B4b9OxQukLzv
sdbRkyTngW7aPJvXe1LyQ5Nvkqs2hakEalp6UyDQ0rHZLuFT9HHclbt3z4HkbiQs
/qWZrkYB0kRmwu6wn6CbFnRDdg7tgBm08IU21HdY6U1Yo7Pv0FYcyJSPHtuKZsk1
RVgV2N+PRAJ4N50uDyWT/LmTobeToWDejSHwHaop91vxx4BzjK88+FUToZBztR95
f1r3AXWGnC6mcSVoLgPo69QIhD/RY36lzjEZEhUFTGOphrQSJEEQIUkc/QS9U3Wb
hD5SsZVGuibe/BYnDvL8DUvm37kUV6u8ml/gSfTXtdqsG0Hl1IM=
=QVqF
-----END PGP SIGNATURE-----

--pujO7MPzXk9QxjSpzi8wnVpyzOycnftJp--

