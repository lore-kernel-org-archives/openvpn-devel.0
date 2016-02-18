References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...> <20160218170312.GV24952@...1296...>
From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C5FA72.9040607@...277...>
Date: Thu, 18 Feb 2016 18:08:02 +0100
MIME-Version: 1.0
In-Reply-To: <20160218170312.GV24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T6ROdHkc9J7BxTX5i4p0lOw87vsMeL5GU"
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T6ROdHkc9J7BxTX5i4p0lOw87vsMeL5GU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

W dniu 18.02.2016 o 18:03, Gert Doering pisze:
> Hi,
>=20
> On Thu, Feb 18, 2016 at 05:15:50PM +0100, Jacek Wielemborek wrote:
>> The thing is that in order to fuzz it most efficiently, it would be good
>> to modify the server to use stdin/stdout (or dev null) for network I/O
>> and terminate after handling a single connection. Also, we would need to
>> disable any checksums, compression or encryption.
>=20
> OpenVPN can be called from inetd, so it can sort of handle "an already
> connected socket on stdin/stdout".
>=20
> "sort of" because the backend refuses most normal options in this case
> (it can only handle tap interfaces, and no --ifconfig, because the
> assumption is that this only makes sense if you attach to a pre-configured
> bridge) - but for fuzzing the network side, this should work.
>=20
> Of course, if you take out checksumming, encryption and tls-auth, you
> take away two layers of hardening against funny packets... - but I'm still
> fairly confident that the worst thing our code will do is ASSERT() on
> you :-)
>=20
> gert

Well the attacker could send a funny packet with a valid checksum,
encrypted and authenticated, right? This is just to make AFL's genetic
algorithm work well.

The inetd mode sounds like a perfect start.


--T6ROdHkc9J7BxTX5i4p0lOw87vsMeL5GU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxfpyAAoJEGlViymZXJRvmdIP/3TK+y9Ozw0+h27rRtVdkn3i
jxuksRbVsY4IV2M4nQxcL9DHVS+4y/NrTbJPCIuiOvCljT0a3n8KbfixSV0n0UfT
PCJgcIjMbcmBgfC5SUvUgjYlZjSAOxhYu2onp7NQG1P5r3cqCnv8651i+Y6+bv/n
n9EtU/Z/pVoNJYoW+stf06UmxTz9ijntimEhyvSexr0M0uiC6BXPf32sVPOWUxjq
TluPg7FCOiYvLgUoEAuEDxqE0OiBJ5OcXL8vXdMr+hEAUWVmQtxt+JxFiyKIn+4s
SZEt4Z4LIH9VaSir1PAnuGqwSxACfzVtgkUr/jwf3WCpIR40yc3VBxuSsCbKch1Q
ckAj9R1k5FMVfMT7nJuS2VkvlEjNVKPZOs0yiNNSqiZcrueHAQyzcKhcUZyfDJ0e
Qaf7QGDq/hpk9n/sKdNggg5Sx7FebvI1dbpCrh8e89wZ/bN+7TC2AolH40KF1PuS
imYbPBl1JC26rEpBTfoyJvYKKhSPcLd0Lc5817NQ8ZXtii28OeENsHCrx3TrKGo6
RILpAu3fDVGVPdsCzr0yMjSg832TW7OLf4KYFveUHKDA0HCKiScBbKIgtFja+Rvd
A36cCVzZ1Y+K0yDldqz2bIC1B3eX8Ddg31eCz91MZ96gQ5J/GdeKsxGA5JBRHjhK
LYiXXn21rO9MoA3oWSdg
=O947
-----END PGP SIGNATURE-----

--T6ROdHkc9J7BxTX5i4p0lOw87vsMeL5GU--

