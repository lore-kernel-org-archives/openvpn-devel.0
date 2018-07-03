References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
 <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
 <95d437e1-73db-99bb-0aed-11335956db47@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <1276c291-2a0d-7de4-a775-fc66184d3f0f@...2181...>
Date: Tue, 3 Jul 2018 16:32:51 +0800
MIME-Version: 1.0
In-Reply-To: <95d437e1-73db-99bb-0aed-11335956db47@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZOm11arABrc14pxbOHVHjUeWnZeSMlB9g"
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, Selva Nair <selva.nair@...277...>, "Jonathan K. Bullard" <jkbullard@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZOm11arABrc14pxbOHVHjUeWnZeSMlB9g
Content-Type: multipart/mixed; boundary="tPtiRKo2IXkWrUeejJzKB5Nft3KUGals0";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>,
 Selva Nair <selva.nair@...277...>, "Jonathan K. Bullard"
 <jkbullard@...277...>
Message-ID: <1276c291-2a0d-7de4-a775-fc66184d3f0f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
 <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
 <95d437e1-73db-99bb-0aed-11335956db47@...2080...>
In-Reply-To: <95d437e1-73db-99bb-0aed-11335956db47@...2080...>

--tPtiRKo2IXkWrUeejJzKB5Nft3KUGals0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/07/18 16:23, David Sommerseth wrote:
> TL;DR: Reduce the possibility to run scripts to an absolute minimum (if at
> all).  If having this possibility run them with as few privileges as poss=
ible,
> and scripts to run is preferred to be configured outside of the OpenVPN
> configuration file.
>=20
> The latter argument of configuring scripts outside of the configuration f=
ile
> is simply trying to end up with a single configuration file which would be
> functional on all devices.  A configuration file with Windows scripts won=
't
> work on a non-Windows box and vice versa - some configuration files might=
 not
> even work across Linux distributions even.  So let the OpenVPN configurat=
ion
> files be as generic as possible, focusing on getting a connection to a re=
mote
> server.  And configure the rest outside of the OpenVPN configuration prof=
ile.
>=20

I have previously proposed to use an udev-compatible mechanism to run
scripts.
In this scenario OpenVPN only needs to trigger "signals" and then
whoever is listening (i.e. udev/hotplug) will take care of handling
them. This could even be DBus driven.

However, this can work on Linux. Anybody knows of a similar mechanism
for Windows and macOS?


Cheers,


--=20
Antonio Quartulli


--tPtiRKo2IXkWrUeejJzKB5Nft3KUGals0--

--ZOm11arABrc14pxbOHVHjUeWnZeSMlB9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls7NLcACgkQB6U8WA7y
zXRoHg//QQpw4rh6E0vkCbDGgC6IL1vnY1of9OjH3wGq/mM2x7hr+MjJGXugy7DN
bytqfsHqtXE0fikk4t9OO7De6K/Dh6um/4WGalDxKV82qLAZ/OCZY19ik4+M767S
2Tu8FTSp1llDUIAQHCbsYegEK/Obqbi5pYrRwdqOzg8OZTh8duKhea5G3xe2xPK+
Eq1kcTW4iCMAGnvlLDk6Kppy5sUIqEtB9qtqdRGQVaE/yJ0Rnsw1EwF8Z1WN0L3w
jnoj0+BxxRpTSIzq9BTcMBF+lgNhCw5BHAmhNlCiw11sUlDMP18eCjA4pyuvDQex
Hz8CxK4iB5NSVOEnexqawsrDLKdfD4drQLCm2856F8DDnYwqSg1fNTXlm6KNLS5w
PeaGj5Z3okIep+oHRZqUT1PQUB5pEuCkHmbiwN/yHzlrAls0Duzf0761aoz+Pnx5
YGh2CWo+ozjYPXMEaeH7mZZ1AwV3rq4kcjS4105c2sD68P/hGZpKJozXPAWrVLNx
ZlYbEoZgJwHYNw0W0XZZ0jAvy7Y4OjH12fUjy3uadPXebOO/mcxmepj8LuSBy9/o
UDRPFaUgAy0pnpRXf6/nNYu5I4QfI7LFf39QDq3leHRVtr70563mvaCGWJcvdqKr
GdqzL9I+LDr+Tj9RgyGqqsKCQwcWbn/4x+oUqzUsxXcj8T5/D9o=
=sy5k
-----END PGP SIGNATURE-----

--ZOm11arABrc14pxbOHVHjUeWnZeSMlB9g--

