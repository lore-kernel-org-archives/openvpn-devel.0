Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
Date: Thu, 7 Sep 2017 15:02:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170907081340.GG70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cpfl0OkGe3vnh34alApXperDF4BsfqLv8"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cpfl0OkGe3vnh34alApXperDF4BsfqLv8
Content-Type: multipart/mixed; boundary="4PTPhAnkMHXVtC55pffJPp0K4Q7pL33AD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?=
 <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>
Message-ID: <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
In-Reply-To: <20170907081340.GG70062@...1296...>

--4PTPhAnkMHXVtC55pffJPp0K4Q7pL33AD
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 10:13, Gert Doering wrote:
> Hi,
>=20
> On Thu, Sep 07, 2017 at 11:04:01AM +0300, Samuli Sepp=E4nen wrote:
>> "Note that units which are configured for Restart=3D and which reach the
>> start limit are not attempted to be restarted anymore; however, they may
>> still be restarted manually at a later point, from which point on, the
>> restart logic is again activated."
>=20
> Which is not what I hoped for... "turn it off and leave it so" is non
> helpful (it might be a transient error preventing the startup).

I'm confused.  What is it you want?

* try restarting in an endless loop?
* try restarting X times and then stop trying?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--4PTPhAnkMHXVtC55pffJPp0K4Q7pL33AD--

--cpfl0OkGe3vnh34alApXperDF4BsfqLv8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsUNcAAoJEIbPlEyWcf3y3/QQAI/qWhyLan4F1IbV0acj5RRu
T/cG22jwtDmvYvqXPypBN8jGGYuVdGCV1RXi4fA33n5jHKFJvf/RwnLdzyfjoNkA
jGaoKAS0R95PNAtLAXKitdmE0+o5E/kkTYVvfQkyJJHJ1ANmh6DDQH/ktJWSJSqW
LgtN0nTUeKdJBgNts988/aMm3WIUZzdT8ZnUfWPOzrnRjbZ+ZCeUFVxVpkx1NKyM
VHdfUJUtJph01DWGfqydoVuEisjDH6402253bfU46gtf7ni+j4vzGUJSs7cRAwr9
XfaCm266omPnsKTOxY2D1eeHzuJoWrwckRpwOpelZbvf7ddRXHTv5CLoD3DgZFEn
jGQBsAy3gFOwA4qTARd3Cl7itXUonX2pbQxg/XO1BuuSWWh2BJQoKGtrSNic9bZR
7ogwl3kLxcY8F5V640pVKxkDLbDE5w+Dn1XCxTvXhsRJZGZGbt1fTa+CotX5uyBp
5HZ7QrENrpXvmQySUXuj+elETObAtOvof3apMBsFl8CKrEbsO4vPfQb/9lkOPGAl
+plHe0pl+9pJI+YgEL5u4F7AmkizRPcy8rJvGJBFo7Uy+4fTEI8/5eV5rtkVeCvF
LctvKKtPs5LTfF9NpWDdX8p9EqCLo24gcvZTy76CSbHNEKwq1tD24t5Z2Ay0VDzo
Eu4GOL3Hk219GrCdIs7W
=/ZU9
-----END PGP SIGNATURE-----

--cpfl0OkGe3vnh34alApXperDF4BsfqLv8--

