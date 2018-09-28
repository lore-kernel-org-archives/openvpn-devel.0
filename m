Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180926134458.20920-1-arne@...1227...>
 <8a3508d0-c11c-2ec3-4602-ee83c24c7a4b@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <65e8b211-9aaf-3f63-55c7-ed814c5aad94@...2080...>
Date: Fri, 28 Sep 2018 12:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <8a3508d0-c11c-2ec3-4602-ee83c24c7a4b@...68...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="tmCEwNthvaVyumIoqfVi7PSngqZYIG27y"
Subject: Re: [Openvpn-devel] [PATCH] Add support for tls-ciphersuites for
 TLS 1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tmCEwNthvaVyumIoqfVi7PSngqZYIG27y
Content-Type: multipart/mixed; boundary="C485WtuzsJR69xEYV7IfaBgF41hYdQTzI";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <65e8b211-9aaf-3f63-55c7-ed814c5aad94@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add support for tls-ciphersuites for TLS
 1.3
References: <20180926134458.20920-1-arne@...1227...>
 <8a3508d0-c11c-2ec3-4602-ee83c24c7a4b@...68...>
In-Reply-To: <8a3508d0-c11c-2ec3-4602-ee83c24c7a4b@...68...>

--C485WtuzsJR69xEYV7IfaBgF41hYdQTzI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 27/09/18 22:20, Matthias Andree wrote:
[...]
>> +  msg(M_WARN, "mbed TLS does not support setting tls-ciphersuites. Igno=
ring TLS 1.3 cipher list: %s", ciphers);
>> +}
>> +
>=20
> Is the blank between mbed and TLS right?

Looks so, when seeing what they do on the official web pages:

<https://tls.mbed.org/>

Seems pretty consistent there.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--C485WtuzsJR69xEYV7IfaBgF41hYdQTzI--

--tmCEwNthvaVyumIoqfVi7PSngqZYIG27y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbrf8RAAoJEIbPlEyWcf3y43EQAMaOHP0OXhKo9Opfa3vXuFkS
3HFMNEMBgk5+3n+4b4P/y47KBwZPoThSqJocaZAvyIupCyJQWfLpSykVeSl6b5DQ
fQKZPj78Jpgmsd9lyCKiwFlrLcKxAy6QWYXumIbd6IIETT/96/RVzobrDwapTXVT
bDyusj/re3k9j4/KSTpVowpC4E1j/RcavZL3axnqEbqbd4m8fQeVpZTMvUuS+0dS
j8+CfoeM910UStwAc807inFIKJXNh7X5ctOr3b3SFgtHVG6c7VDhGo/cdDvOd91W
6TxSP6G8haVMaz00x+695BmbpvzSGN1q4Xat9NH0m2NJee89HoloClujV7lIm+WP
IAWMV53+XVfVjg2/hSxEFcsSkI+cFLxCbFyzQY8d/c0+GTtGjTyS/6VdBCcY+4oZ
yB5+J7npLG0vIzdaUttlBC1Ub/uhTGfQ58ddFZYKvAPuSgOSVQ5ift1Uzn7O4/US
vTTVBMaWqyFymCv0SVbtO/xw48CU4ky+sUs1s+KbVDVPefILBDxM9suqe+3frN0r
SbxBY85KRPjvUaj3AHsYY+HPWr6qSkrPZ9XBrUNJ9IymPsDDhGFSsH/X+qMnGTL7
WZGq27zIZXaQACDDyY3pNiq2TpGAMhebmz8VtsZWoz0C4umNs+hxN6zDAIXsJqXz
CijWNl2P2upwUWfQze7C
=cg3j
-----END PGP SIGNATURE-----

--tmCEwNthvaVyumIoqfVi7PSngqZYIG27y--

