References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
Date: Mon, 29 Aug 2016 21:55:49 +0200
MIME-Version: 1.0
In-Reply-To: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ssWIjOTSlGB8OqVda1dDLd5cIFM69wr6v"
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization
 format using a patched pkcs11-helper?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ssWIjOTSlGB8OqVda1dDLd5cIFM69wr6v
Content-Type: multipart/mixed; boundary="fL9WBtARFFiCDOBLvXI7McFOjN3SoiMmM"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization format
	using a patched pkcs11-helper?
References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
In-Reply-To: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>

--fL9WBtARFFiCDOBLvXI7McFOjN3SoiMmM
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 29/08/16 15:02, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Right now our Windows installers use the official pkcs11-helper
> release from the OpenSC project. Unfortunately this means that
> output of "--show-pkcs11-ids" and input of "--pkcs11-id" are
> non-standard, as reported here:
>=20
> <https://community.openvpn.net/openvpn/ticket/491>
>=20
> In Fedora this problem has been fixed with a custom patch
>=20
> <https://github.com/OpenSC/pkcs11-helper/pull/4>=20
> <http://pkgs.fedoraproject.org/cgit/rpms/pkcs11-helper.git/>
>=20
> Debian and Ubuntu have _not_ are not patching this issue:
>=20
> <http://http.debian.net/debian/pool/main/p/pkcs11-helper/pkcs11-helper_1.=
11-5.debian.tar.xz>
>
>=20
<http://archive.ubuntu.com/ubuntu/pool/main/p/pkcs11-helper/pkcs11-helper_1=
.11-5.debian.tar.xz>
>=20
> Do _we_ want to move to start using a patch pkcs11-helper version?

There have been some proposals to ditch pkcs11-helper and rather use a
newer and more compliant library instead (p11-kit).  I think this
makes more sense, to be honest.  There are more issues with
pkcs11-helper which upstream seems less interested in resolving, among
others challenges with systemd and the PIN code [1].  So as things
start to pile up, I think it's better to move on to something else.

Of course, someone needs to do this job.  JJK sponsored me with a
PKCS#11 token at last hackathon + since that time I've gotten myself
both a Yubikey Neo and a NitroKey so I believe I have what's needed to
begin to dive into this rabbit hole ... I just need to get this
prioritized on my TODO list.  Unless someone else wants to give it a
try, if so let me know and we'll see if I can help out somehow.

With that in mind, if shipping a patched pkcs11-helper in Windows
makes your life easier I'd consider doing this.  But step carefully,
avoid getting in a situation where you suddenly have to maintain these
patches yourself.  Rather try to see what Fedora does and see if that
can be re-used as much as possible.


--=20
kind regards,

David Sommerseth


--fL9WBtARFFiCDOBLvXI7McFOjN3SoiMmM--

--ssWIjOTSlGB8OqVda1dDLd5cIFM69wr6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxJNFAAoJEIbPlEyWcf3yNz8P/iAaToATyZcTDtJVu/hnUzaZ
apC8Tr5uHS42aQPyz1mFEu6D35sSSYVPStB2un2VAEfa/6Unq4NUmc3y0fZxZbU9
a4i5CACOAJH/Gmmi/hbyiP48L7wjaa8WvN2d38cSigC0qhtbxvZLyYO66myKd9iZ
aRUPdYCrM64p2i88O5bTgGwjt2seHybshVjJDbKVzhAMtCECpyOsrikHuHC+d4ZG
p4ZY9tp0AL4+FTvJ4p5sbXLvQ0AppLv+ZUuG/lPq/ez5CfkBvt9yJJBAZLVDZWD2
ggwViHFdE8TDouppZ/aGdsTb0MXMqnieGeO46js4cr236C0tEe2XXNtNoBMMWpbR
B6heS5gcN1hEppZ5Ce7j5IzdIa1366ton1lQRq4dB7MZEVHA4s0i34oUziD92ncz
mTfk/b39Pz5KJ6uOGBGTyQGIloAn413QfRC5E1B5UXQyREtZNp/WXHkoexIED5DY
xGSAUyXHiz1yU6zitBkirVO9rUbY/CohbCUfEs5iYNc1zAS+n349hAcfQ5vKK5ET
QPKOxbmZbf0GgLnBdigi1y8dE86p8WIpymGRbjmgEQ02h1gzFvHMVPj/I2QF64tc
cNtHXviXTH0Oeeg7SkCET3VGxpc29xa0bi7xA2nH0tfyI7pDe9WmJmKFTTWdayJz
FcJAncIwE4uslRuliMs6
=rUHb
-----END PGP SIGNATURE-----

--ssWIjOTSlGB8OqVda1dDLd5cIFM69wr6v--

