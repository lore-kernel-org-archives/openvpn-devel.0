References: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
	<9b1ae30e-ee1a-a798-4bfa-fe0ba5c272de@...68...>
	<20161222102432.GE78624@...1296...>
	<c055d6f5-21ff-e4b0-20e8-fcd48ef349b0@...68...>
	<20161222182355.GG78624@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <6f251ee2-ff54-0ab2-72f2-2895e8c0461d@...1856...>
Date: Thu, 22 Dec 2016 19:35:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161222182355.GG78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CreVxwmLAJ0kiiuaHQCAEJ7W7d0Bku6wg"
Subject: Re: [Openvpn-devel] CFT: OpenVPN 2.4 port update (upstream rc2) for
 FreeBSD, now with TUNNELBLICK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CreVxwmLAJ0kiiuaHQCAEJ7W7d0Bku6wg
Content-Type: multipart/mixed; boundary="rTcxOqKlRriTjmxXW4NgIpNfegAdkUKGE"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <6f251ee2-ff54-0ab2-72f2-2895e8c0461d@...1856...>
Subject: Re: [Openvpn-devel] CFT: OpenVPN 2.4 port update (upstream rc2) for
	FreeBSD, now with TUNNELBLICK
References: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
	<9b1ae30e-ee1a-a798-4bfa-fe0ba5c272de@...68...>
	<20161222102432.GE78624@...1296...>
	<c055d6f5-21ff-e4b0-20e8-fcd48ef349b0@...68...>
	<20161222182355.GG78624@...1296...>
In-Reply-To: <20161222182355.GG78624@...1296...>

--rTcxOqKlRriTjmxXW4NgIpNfegAdkUKGE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22-12-16 19:23, Gert Doering wrote:
> On Thu, Dec 22, 2016 at 07:01:32PM +0100, Matthias Andree wrote:
>> I haven't seen anything mentioned by a Jonathan recently, and see
>> nothing in the openvpn-devel archives, but yes it is about optionally
>> obfuscating OpenVPN traffic on the wire, adding an undocumented
>> --scramble option, and taken from here:
>> <https://github.com/opnsense/ports/commit/173db0315>.
>=20
> Sorry, my fault.  That was Jonathan K. Bullard on openvpn-*users*, who
> is maintaining Tunnelblick, and he mentioned that his builds do contain
> an obfuscation patch.  So it seems to be the same thing.
>=20
> Jonathan's mail is here:
>=20
> http://www.mail-archive.com/openvpn-users@lists.sourceforge.net/msg03396.=
html
>=20
> (he calls it the "openvpn_xorpatch")

Also, check out what he writes on
https://tunnelblick.net/cOpenvpn_xorpatch.html about the original OPN patch:

"However, a Tunnelblick developer has reviewed the patch, found some
problems, and modified it in Tunnelblick to resolve those problems. The
problems that were found and fixed involved insufficient parameter
validation, null pointer dereferences, division by zero errors, and a
buffer overflow."

So might be worth checking out which patch you're using.

-Steffan



--rTcxOqKlRriTjmxXW4NgIpNfegAdkUKGE--

--CreVxwmLAJ0kiiuaHQCAEJ7W7d0Bku6wg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYXBziAAoJEJgCyj0AftKIl/wIAM41R+VXdm/k0TmQ8V8Z/14V
E4oJblgVUS6SllqPF0IA85sbGnxzS3oVaEQ0n9WUuCwtOo/ZeZUpkD0XNmLCqmSI
ObylZPSLvZ60H6GBRhYexqOWH8Bl+CA0aPgKwGU65pNoCblf0iQ6D3jD5jlDdehv
eXgWF6UDFlZUx9YOGETum4npP1HULhOfCjh+5BEiNgIH0lpT4Bw08kQ8uYLLMSPg
3morUo7iSwqWNC4qeLRT52ZX1fSQOxHqUzzN9s1AxiMraTyF6ppn1NaEyMDKKwTO
25XBl5ddvsEAB2Lj3murnmi8OQEJXrke1+kGh5PhJY7kMeGYpIu/2kq+37/oEsk=
=+wHt
-----END PGP SIGNATURE-----

--CreVxwmLAJ0kiiuaHQCAEJ7W7d0Bku6wg--

