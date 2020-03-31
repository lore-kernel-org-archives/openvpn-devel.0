References: <20200330125719.766763-1-wardragon78@...277...>
 <CAKuzo_gCZ_GMf6m88xnR-BeDh9umtj+CVemrKA+d-phKnDJwBA@...278...>
 <44f9ff30-920a-6d0a-6f77-7de6111c04dc@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1f5fa79f-ad65-0a99-3d91-c7f86f522b2d@...1227...>
Date: Tue, 31 Mar 2020 11:23:17 +0200
MIME-Version: 1.0
In-Reply-To: <44f9ff30-920a-6d0a-6f77-7de6111c04dc@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7Pqu9qAfo1WAADS9UwCxZM1i9tUO1b1Mo"
Subject: Re: [Openvpn-devel] [PATCH] [PATCH v5 1/1] Insert client connection
 data into PAM environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Paolo <wardragon78@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Pqu9qAfo1WAADS9UwCxZM1i9tUO1b1Mo
Content-Type: multipart/mixed; boundary="S6yS54MwJKq5qXOvfpHhfgDyEQj1auLJp"

--S6yS54MwJKq5qXOvfpHhfgDyEQj1auLJp
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 31.03.20 um 09:34 schrieb Paolo:
> So,
> as you asked, now a make the complete patch from diff from master and my
> branch, making the change to remote lenght.
>=20

Your patch got mangled very badly for me:

>     -=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  || send_string(context-&gt;foregrou=
nd_fd,
>       common_name) =3D=3D -1)<br>
>       +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  || send_string(context-&gt;foregrou=
nd_fd,
>       common_name) =3D=3D -1<br>
>       +=C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=
=82 =C3=82 =C3=82 =C3=82 =C3=82 =C3=82  || send_string(context-&gt;foregrou=
nd_fd, remote)

Can you try to resend it with git send email or even as an attachment
that does not get reformatted would help.

Arne


--S6yS54MwJKq5qXOvfpHhfgDyEQj1auLJp--

--7Pqu9qAfo1WAADS9UwCxZM1i9tUO1b1Mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6DDAYACgkQFRhsZwKx
RFRBbxAAqSPZo2VGDvQ6MwRBfavqX9VF/UXcFxgK6nOoud1T6hHaNs9tZEQjYp0T
Ia4k+a1PPSMwRrJjm2Iui8/S38UjicW2dMKUATmcADzJ19nwNh/6tj545iEN29U4
w6rq2twzSwHg/b4DPqQjpltvgV34f0aGH4+tW0pJJzu9X9/NIRVN5k/z9I2b4joA
4aNI1issoWi/8DCGVlcPA0FCAsctAEtVpe2RHIJaR4BwVX+vieKBBISpiW7RV+rd
NVRfbuCkoe2m1zn9QbHHJejyV7d0JwydNvZgCRhuozjhiTt6sxmUFJD2irrZe8lL
4j69Jfpr5iQWgtYfebJQGGQadia9cswCyJr7R6BHLOM3HrWZYuniErb3JZdk5HP2
pAKcuo82nAbiV2z4Du+isD9/fxXmgPtler6TUUdK0VyoVZAs4Ijrl7S1mHs/wJb6
23fbl6VGW7+JfbMupnX3DrTOHLfHezpRH9wKMjzD85h480nek+GAh6MCBaCNn+vY
Y5GB1lYbDJmtWEKcCdCyJwNIEkstN1X35AiWVRP+19PT5GRJNUNCkgaiKaszFZyu
inxoEk7uHl6YE/VHLOb3reDG9K8GqvY7cgcIKUuuhpfLzh2ZxVZo9Lb71HwN3Gaf
rzyLeOXL6xFjp+W1+AfI0fheC2Il6Ms5V00fTy6n0PLu5u20pV8=
=a24q
-----END PGP SIGNATURE-----

--7Pqu9qAfo1WAADS9UwCxZM1i9tUO1b1Mo--

