References: <20201001154658.9798-1-davids@...515...>
 <346aa358-47be-2563-a75c-3ef81b3a5e8f@...1227...>
 <CAFHpkQFaeM4pWsvyHC+ysSwL7OJLVW1fMzk7VxYAnCLJi6GOiw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <44ca11e5-5da3-ce15-8b87-779bc4207f5c@...1227...>
Date: Fri, 2 Oct 2020 12:11:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFaeM4pWsvyHC+ysSwL7OJLVW1fMzk7VxYAnCLJi6GOiw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sYtktbGiArQkdUIFgQc7vs1FEdSTC0tZ0"
Subject: Re: [Openvpn-devel] [PATCH] compat/lz4: Update to v1.9.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sYtktbGiArQkdUIFgQc7vs1FEdSTC0tZ0
Content-Type: multipart/mixed; boundary="BMPRp3O9Wl3i4ZOncEZK5nN0W44jZsLJ0"

--BMPRp3O9Wl3i4ZOncEZK5nN0W44jZsLJ0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 02.10.20 um 12:03 schrieb =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD:
>=20
>=20
> =D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 13:51, Arne Schwa=
be <arne@...1227...
> <mailto:arne@...1227...>>:
>=20
>     Am 01.10.20 um 17:46 schrieb David Sommerseth:
>     > It's a long while since the bundled lz4 library has received an
>     update.
>     > It pulls in a lot of various fixes and enhancements, some of the
>     changes
>     > fixes compiler warnings and hardens the code a bit too.
>     >
>=20
>     Ack for release/2.5. I double checked that the file is identical (mod=
ulo
>     compat defines) to the upsteam.
>=20
>     I think that this file is outdated so much shows that we do not really
>     care about compression so much. Also since we included it, lz4 librar=
ies
>     have been available on all major distribution and not having lz4 is n=
ot
>     as problematic as before. For master I would like to see this
>     compat-lz4.* removed instead of being updated. For the 2.5.0 release =
it
>     is too late to remove, so okay for that.
>=20
>=20
>=20
> windows build process uses bundled lz4. if we simply remove it, windows
> build silently switch to "no lz4 enabled ... and that is ok"

I think we can find a better solution to include lz4 in the windows
build then putting the dependency in our repository.

Arne


--BMPRp3O9Wl3i4ZOncEZK5nN0W44jZsLJ0--

--sYtktbGiArQkdUIFgQc7vs1FEdSTC0tZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl92/MoACgkQFRhsZwKx
RFSVJw//e2ozMkEBXEMsxj51+WTYdOJd02C/4a03JoIewwBlYqYBSRQ72sBRE2zk
q2t0lmDlO1oQzVkkGUCJdwxC1g1lJIvej1MTeUz8eF5Eq3WVngmP9eW31emX9vrR
avnByeYIkD/5vot0GvjbQKYigXUROiRbE1xJbz7JwAom6g/hmNif1aBR/y8XLdn5
e1czBOnPPKPiclp9Hf+fRdhN3VEEr/eXl9WZmp/biA6TrciUR4MnAzFMuwuhXaOG
LnWyVg6eOnT8Yh4VEkarfAeGE7eo84Ae30wV0/szWD6I9s7kfUrjm/6hwHgu/HUe
a78gWAkKByqE4NLckHIrPCAhpaBqM/jA/MlBD5j+E4+SYRy4bfnYhgCjuAI0Y7Cl
tPd7ddYn7eoU7Nt2358B813RADqY15MfpH2k5qrxqdaUIHY6xUi3biK5YFFO6mDp
f+xVrVEuOWRbsucsXndZr+9z2mBGsXy+VrgXhODo6zAY+L2iLcv9+GD2LIVtyIag
Uxbc7+cv80hLiEzAZvA89cQq8MJYlU0m4TBwHNGLT1YVXLLVpt/Phuuobn0q2j/U
OzkgVyTJomPiTE9EX3xaNxABJT2e3iAI4yPVq5f2I58dI5N01xQKjqWVmLvfWqYt
deO0AnuTcGiC0QJedlIUQOlT3+/wjKVCKGTV63XulE1HTZQeTZE=
=WBqi
-----END PGP SIGNATURE-----

--sYtktbGiArQkdUIFgQc7vs1FEdSTC0tZ0--

