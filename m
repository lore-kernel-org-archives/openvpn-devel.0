References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
 <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <145d42e9-1a92-2e60-b494-f49f381ce662@...1227...>
Date: Thu, 23 Jul 2020 13:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wkc9qiDgYyFLiUk3XdGOj8WvAOqDZZ9vr"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wkc9qiDgYyFLiUk3XdGOj8WvAOqDZZ9vr
Content-Type: multipart/mixed; boundary="HNyDBYdyn7oo3UiXEQhR5OHKRLvUArOVI"

--HNyDBYdyn7oo3UiXEQhR5OHKRLvUArOVI
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>> +++ b/src/openvpn/options.c
>> @@ -536,7 +536,7 @@ static const char usage_message[] =3D
>>      "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
>>      "                  (default=3D%s).\n"
>>      "                  Set alg=3Dnone to disable encryption.\n"
>> -    "--ncp-ciphers list : List of ciphers that are allowed to be negoti=
ated.\n"
>> +    "--data-ciphers list : List of ciphers that are allowed to be negot=
iated.\n"
>>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>>      "                   nonce_secret_len=3Dnsl.  Set alg=3Dnone to disa=
ble PRNG.\n"
>> @@ -7866,7 +7866,8 @@ add_option(struct options *options,
>>          VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>>          options->ciphername =3D p[1];
>>      }
>> -    else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
>> +    else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
>> +            && p[1] && !p[2])
>=20
> I do agree to using --data-ciphers instead of --ncp-ciphers, that is far =
more
> user-friendly naming of this feature.  NCP is a more technical
> "under-the-hood" terminology which users don't really need to relate to, =
where
> --data-ciphers better explains what it is used for.
>=20
> But I do reject NOT adding a deprecation path for --ncp-ciphers.  We shou=
ld
> support --ncp-ciphers for 1-2 major releases, but after that it should be
> removed.  We have too many options and we certainly should avoid duplicat=
ing
> options with the exact same functionality.

This was a deliberate decision. We really want to people to move towards
ncp and putting another hurdle with having an option that works better
on but gives a warning and a option that does not work on 2.4 does not
help here. If we decide that really aliases are a no-go in OpenVPN then
I would rather drop data-ciphers and stay with ncp-ciphers forever for
this reason.

Arne


--HNyDBYdyn7oo3UiXEQhR5OHKRLvUArOVI--

--wkc9qiDgYyFLiUk3XdGOj8WvAOqDZZ9vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8ZdksACgkQFRhsZwKx
RFSG8Q//Y/Sv0QcRyuEmHix3OIvpOKDaYhLY6ftWNM7lKoGi5XXD2Xts0RibG4gJ
ZlFvx2PVaKcldauSunPJpSgsXZR0KsZtb/VucgDF0igMrTyqSKyMhhnI+Mu8A1NJ
wuMQyWOxrbQ612ohCh8mfQMhceQLs4kVMejDHzJ3YBzUAFo/ymlSG4M2MUIoo7eC
vqM8QLnF4+6PV6qsl/3QSrU7QTp+UiX7QfBX8qzs/7CN/8Xhx6WuIIP4D90xSq2m
FVOIFVc22OuwIhrEvL0eQknXAkBxb8f5bOKWne7ChZet9qWZWxM5dTViDDtP0JYq
U945V3yeyPg6KhAPHdwwaAgVwaWsHD4rHpvhVqWe5hrVUZiTxljgb4qM9xf9aGVe
zsipPqXNV8DH5oJex77XMVwApp0CsFbh73Xq+xSi9U9f4VwrkLSNB5PsN6wA0Xey
4ryKfrMkDuJMcflHTZiXqEB3UqRfM56NbMFOujYRvkufGZQC3CLBAKk5Hd/yJoLb
/f5OhxNBLfi0GdPZpxwuOlYmuFaJI/sEfPC+jc24PxRZbIXympVTj9skU2CyGy3W
CraNOoSTK9Ryjg/05DT10Kdk7O3bV270I9z61lm0GG4fooBW0e6kndZJE0uvDfwp
uvgS7mKzpYzbgLQpMoUhpBjc3IYS9NkU2SaprUNI5T2+rXVRqGY=
=IGYW
-----END PGP SIGNATURE-----

--wkc9qiDgYyFLiUk3XdGOj8WvAOqDZZ9vr--

