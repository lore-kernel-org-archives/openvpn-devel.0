Date: Wed, 25 Apr 2018 08:12:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180425061248.GN69387@...1296...>
References: <1524623120-23498-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ktcjVa9z86pLVIU/"
Content-Disposition: inline
In-Reply-To: <1524623120-23498-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH tap-windows6] Have the driver version
 display as major.minor.revision.build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--ktcjVa9z86pLVIU/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 24, 2018 at 10:25:20PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> The driver version (taken from the INF) and the file version of
> tap0901.sys file (from its resource) will now display like
> 9.22.1.601.
>=20
> The driver details tab will continue to show the text form of
> the version as "major.minor.revision (major/minor)".
> Eg., "9.22.1 (9/22)"
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>=20
> Not sure this should be submitted as a PR  or like this..

Not sure either (tap-windows6 has seen so little development that we
never defined a proper process, I think).=20=20

So I just ACK this here on the basis of "we did not know how to do it,=20
but this is what we wanted to achieve" - it *looks* reasonable.

So if Samuli can be convinced to build a driver with this merged and
a signature, I'm happy to give it a test run and see if everything is
happy...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ktcjVa9z86pLVIU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa4BxgAAoJEB2Cnv7KVigSYVEL/1tXxcy855Ixi33QDjpVqOpu
ruhMcM0d20orG8/Mgfnt2Qlak7Z1krfO+mkossqGHsygC2vP/6A55fYFqXeiRMBV
P7Dm9Meggy6v4zL7ShzFIQJULpvqxKZj5KVDZSPpTJrCqOiT4djs9UtNihDh9WNb
q0/WwFQDriMYtqQl+ACFqfeEogWVDhn+Z1v4X/D1/qWrmZO+G8JdPPbGtbHfEmA0
or4Cp9wrKTkRQhgfE3dtS9/fAMfEbsyg6TGx5sKVsrjhx0jGZ2WVMqRqJtzDbndV
KpyQuyZGtDCgtm0/gH1//cvy89GOplLIgJfOAHCqq9RNSpZkB5UY/1yJKQRgCgem
LwiTm9Pp7CmmYMQl6WoZTm6wLBI5Cfkl2HcHYBCq1obCN4LAp1Tuci06npjVvUkE
kB/yYV9VB6KtIdcrZjRQ5Iwr3Q3dPyhxmZt4hLvRsh6dv64up2erbnV5Wctd556I
Fmvu1GAi6+pDb8UG+GcBvrRNLg9jzWCfpPW6dmFrKA==
=FETS
-----END PGP SIGNATURE-----

--ktcjVa9z86pLVIU/--

