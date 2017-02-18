References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
	<CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
	<20170217174223.GV93896@...1296...>
	<CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5d1e0392-2466-2ef2-677d-25d52188d1f9@...2080...>
Date: Sat, 18 Feb 2017 02:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lmbDhPKA40uMstfu4hCNvJDXIrS4oNXsF"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lmbDhPKA40uMstfu4hCNvJDXIrS4oNXsF
Content-Type: multipart/mixed; boundary="V2Qm7QuC5K9Gkc0WOwjm5BSUs24HHLF9j";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5d1e0392-2466-2ef2-677d-25d52188d1f9@...2080...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
	<CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
	<20170217174223.GV93896@...1296...>
	<CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>
In-Reply-To: <CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>

--V2Qm7QuC5K9Gkc0WOwjm5BSUs24HHLF9j
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 17/02/17 22:59, Emmanuel Deloget wrote:
> I'm not targetting 2.4 -- my work is done on the current master. Adding
> hundreds of lines to the current 2.4 for the purpose of supporting a libr=
ary
> which is not yet present on the user systems does not make much sense :)

Currently, master and release/2.4 are fairly close ... so it shouldn't
be too hard to cherry-pick stuff from master (which we usually prefer to
do).

With that said ... I know Fedora have OpenSSL v1.1 support on their wish
list for for OpenVPN [1] and I believe Arch Linux guys have also been
asking about this too.  So the more leading edge distros are moving
towards OpenSSL v1.1 as fast as possible

[1] <https://bugzilla.redhat.com/show_bug.cgi?id=3D1391544>

Fedora is considering (and have builds ready) to temporarily switch to
mbed TLS, despite not being as feature rich as OpenSSL ... just to avoid
holding anything back.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--V2Qm7QuC5K9Gkc0WOwjm5BSUs24HHLF9j--

--lmbDhPKA40uMstfu4hCNvJDXIrS4oNXsF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYp6jkAAoJEIbPlEyWcf3yka0P/3JJgA0xWaaqcOS6a1cxFo2P
OABuMmu5FD97kcL82OZyEXS8IOaIYfyIL88IPeGRTU1Ji67aUr0pOJdm4O8AU2o1
dM5VHWh8S4u0dFhPlhtrGLxI/ZP4DBDxaXsaJHxLpIhwCOZzngx0B7hKWxai82bL
B+EtDrphaLCcFf2WP/9cobM2LtV3GfFTWAsyHr+9F0gBPX9ynJRT1DIrYCVLgHQ0
r/KcoCqG8Vy4+8+k4gLaJwgj7j3VkFgkKq6j7N70yhhKAR22KaeCsbFbwRJHJAsD
S3ozzKeeQviAHzLltq7DUDhyXI2psG+iMFZji3N6e2ZIdBSQHM/3tHe2GuhCzA5R
gcI4xNw/fzustQFOegyaNCM0eMLzpMsWIOiZLDwqSCpqHz0+K5RsTkTG2fWVctWo
ZFLnvH570qYgiMaw6FTKzmU2F/6oELUZC0tjjHvjhot3us4ZNxml4+D12pe7Rug/
G+LNAb28DuJOZbd1aAYO5YYn/JbvhfH74Rr15WKeDZ2xIebGNT45ohnHYwq6T+kG
e0wN6Ixf6tY1mWP67Kc4qlsmIJyR/EjcL6fz7aHSaXFV621FhMBHYiXjglB6psLE
JhIWR+W4liNC7Xbb6dEK5FBMIhtkttbtx9O3GbJWb4KjF5Lg5r5L3mm//n4cWpK6
TbnHHZIa5TMe+ooBtsH3
=XgeN
-----END PGP SIGNATURE-----

--lmbDhPKA40uMstfu4hCNvJDXIrS4oNXsF--

