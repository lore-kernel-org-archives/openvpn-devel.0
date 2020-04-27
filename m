References: <20200227205443.27562-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <750d2eee-3e86-3aec-1a0f-a5c083d34bba@...1227...>
Date: Mon, 27 Apr 2020 04:25:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200227205443.27562-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SQUYElujFuRlPqJ5BCeqGdpFPYltyq0hV"
Subject: Re: [Openvpn-devel] [PATCH] build: Remove --disable-server from
 ./configure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQUYElujFuRlPqJ5BCeqGdpFPYltyq0hV
Content-Type: multipart/mixed; boundary="itJFJ7b2PY0ijBQZUzVINEPMgLiZTKcqO"

--itJFJ7b2PY0ijBQZUzVINEPMgLiZTKcqO
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.02.20 um 21:54 schrieb David Sommerseth:
> After some discussion among the core community developers [1,2], it was
> decided to remove the possibility to build openvpn as a pure client.
> This was alterted on the mailing list [3] that it was scheduled for
> removal unless anyone had strong arguments why it was needed.
>=20
> The general consensus was that we had not received any strong arguments
> to keep this possibility after approximately 5 months, so it was fine to
> remove this ./configure option.
>=20
> By removing this, we remove quite some entangled sections of #ifdef
> scattered all over the code base, making it more readable.
>=20
> One note:
> Inside the  options_postprocess_mutate_invariant() function,
> the #ifdef P2MP_SERVER and #ifdef _WIN32 blocks where slightly
> reworked to make the _WIN32 block more continous and avoiding having an
> empty if(options->mode =3D=3D MODE_SERVER) block.

There are three trivial conflicts when applying this patch and push.c
needs a small fix:


>          ret =3D process_incoming_push_request(c);
>      }
>      else
> -#endif
>=20=20
>      if (honor_received_options && buf_string_compare_advance(&buf, "PUSH=
_REPLY"))
>      {

This if needs to be moved to its else to become else if since the #endif
is now gone.

I also compared the fix with "unifdef -DP2MP_SERVER=3D1 -m *.c *.h" and
the results are almost identical (minus a few things unifdef did not get
right/autoconf stuff).



Acked-By: Arne Schwabe <arne@...1227...>


--itJFJ7b2PY0ijBQZUzVINEPMgLiZTKcqO--

--SQUYElujFuRlPqJ5BCeqGdpFPYltyq0hV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6mQq0ACgkQFRhsZwKx
RFSF1A//RoYNAhk45uoF5GW0hGFelIFv7mR8dmupkjDcuqdRCcYHJMCcBVezSGIf
EsQm6TIXo9fzYuMJhOJbnMSxzlH3B0+in/+EB9Q7H9lZ1NVcUhf/k9yz3SDj0TVI
RCVqghnekAYen5Ags6+E6Rt7FTrglq+D/S4beX+NV8wc/7zDj5WwSDQ5pIvjYLPQ
1TBbB+NSaTRq796FCkIUFo8BnPB2ydN0R4iYAK81aMItVZHtSoxk7vDSVLY2TjeQ
uTBXn0J5VO0q/kACuEe2JJFsFYhSmVSF3ep6aANPbGyQk5VVTujKBfkvXKHOHCcN
SJWXIH3fMB5N0U/yUJl61f1j8Vq+vJ7jot2VXSlZwFPU8esk3UMrlEqEbZ1sA1i5
qs9c+1O/gwxy882NBU3QyJKmGrE7L2Z/XbCtYopdKm3xVyf1i2BdZD/Hv9pCy57a
UUPy1imd6ErKT5wp28ELKRmmmMQltIyN/6XvRS5VzPMN7t9i8ZKV8sHfOVl1Yjwj
HiexoaUNZMmmuoUpX5T49Onu9zzLH/KPcZKcF4Yrk0AE26/uhHioCIoXszbviX+k
5U7Ow2Z3HHqYoFUhY+2WGuZKVX85CuLoggtZorGcCNgpKJPR5YY31QSQCgsuRtPh
dlCDEG3WSFF9zVARazwl5UVwu4q754N7ctf4ACGEUwSmFaqxcj4=
=qPnI
-----END PGP SIGNATURE-----

--SQUYElujFuRlPqJ5BCeqGdpFPYltyq0hV--

