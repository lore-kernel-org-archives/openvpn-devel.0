References: <56936C78.3020505@...515...>
	<5693BE57.2020505@...2080...>
	<20160111152253.GX24952@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5693FD9F.3030302@...2080...>
Date: Mon, 11 Jan 2016 20:08:15 +0100
MIME-Version: 1.0
In-Reply-To: <20160111152253.GX24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dBPH8gLiURHcd5i5Vs9NHQwwlQSwh5KoN"
Subject: Re: [Openvpn-devel] Disabling auth_pam plugin by default in
 openvpn-build?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dBPH8gLiURHcd5i5Vs9NHQwwlQSwh5KoN
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/01/16 16:22, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jan 11, 2016 at 03:38:15PM +0100, David Sommerseth wrote:
>> You'll most likely upset quite some Linux distro maintainers.
>> Especially if such a change is not properly communicated.
>>
>> I know at least RPM packaging will start failing when it detects that
>> files expected to be installed by 'make install' is missing.  Other
>> packaging systems may behave differently.
>=20
> I would be very surprised to see "standard" distro maintainers use the=20
> openvpn-build script set - as it's totally unneeded unless you do
> cross-building...

Duh!  That's what happens when you quickly read and reply before running
to do something else ... Had I just looked at the patch first, not just
presumed we were talking about changing the defaults in configure.ac.

Never mind, sorry 'bout the noise.  For openvpn-build I have no
preferences either way.


--=20
kind regards,

David Sommerseth


--dBPH8gLiURHcd5i5Vs9NHQwwlQSwh5KoN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlaT/Z8ACgkQDC186MBRfrrhTgCfSjzM4Dmn9UF4C6XurbM2ellK
3ycAoJpjz4e8tJFFidyQ+BdSKqqth99r
=uV9t
-----END PGP SIGNATURE-----

--dBPH8gLiURHcd5i5Vs9NHQwwlQSwh5KoN--

