Message-ID: <55966876.5020501@...1114...>
Date: Fri, 03 Jul 2015 12:48:22 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <55950ACC.1000909@...1147...> <55963A07.8010504@...515...>
In-Reply-To: <55963A07.8010504@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VlEFIeUuKam9XNKvhTfKktiJICAdJbRF6"
Subject: Re: [Openvpn-devel] [PATCH] Add TFTP and WPAD DHCP options
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VlEFIeUuKam9XNKvhTfKktiJICAdJbRF6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/07/15 09:30, Samuli Sepp=E4nen wrote:
>=20
>> Attached is the patch to add the TFTP and WPAD DHCP options. The patch
>> is based on openvpn 2.3.7 as I did not know how to do a windows mingw
>> build of the git version ...
> One way to build a git version on openvpn-build is this:
>=20
> $ git clone <url>
> $ mv openvpn openvpn-2.3_git
> $ cd openvpn
> $ autoreconf -vi
> $ cd ..
> $ tar -zcf openvpn-2.3_git.tar.gz openvpn-2.3_git

Just a stupid question ... instead of the 'tar' command, why not just
run 'make dist' ?

--=20
kind regards,

David Sommerseth


--VlEFIeUuKam9XNKvhTfKktiJICAdJbRF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWWaHYACgkQDC186MBRfrr5NgCeMnfHqHonlkAMRCaeR5Epbd7d
zR0AniP1BuX6T2msnHHLXVzcGjTZ+OsY
=yYsX
-----END PGP SIGNATURE-----

--VlEFIeUuKam9XNKvhTfKktiJICAdJbRF6--

