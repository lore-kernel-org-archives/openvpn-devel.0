From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C5C6F7.1020903@...277...>
Date: Thu, 18 Feb 2016 14:28:23 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kF7a3aeHaWdu1m9E0s2Qga4XAgvwI1Lcu"
Subject: [Openvpn-devel] Has openvpn been fuzzed?
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
--kF7a3aeHaWdu1m9E0s2Qga4XAgvwI1Lcu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I had been fascinated by afl-fuzz for quite a couple months so far and
based on how efficient it is in finding bugs in open source projects,
I'd like to ask the OpenVPN community whether somebody here tried out
this tool on this project.

If not, you might be interested in my project that automates
recompilation of openvpn with afl-gcc:

https://github.com/d33tah/aflize

Just run "aflize openvpn" and you'll get build environment ready in minutes.

Let me know if you'd like any help fuzzing OpenVPN, I'd be happy to
assist you guys :)

Cheers,
d33tah


--kF7a3aeHaWdu1m9E0s2Qga4XAgvwI1Lcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxcb3AAoJEGlViymZXJRvrfwP/3wwXIcKVfIpn4NrurjSS6j0
OxnTJRC+zK1h8lJW4sUD6LqEvh2B0dvk/bFFdSVa/F1uUyDS5m/+31gfoIEDV5PL
LfWTunwzIKqKEEKHZJtq6x3AzbA2yeSWUzl7PBolrs/oqOiMY9hZaEmY62oI2KOt
CvoVLgAA1b+0R1XQOjelWOtjsknl49+5OXLuY8cGPbhnjuXikNHAg1Y6GedXdiqU
cVsz2i1mHEigmzgwJrHsXUVCBukbqHQkYeRkrQl05yJhIBoDti/A1cYHEPunyvfp
TkcM3yiOddnmjWUlkuV7/ELa26iHrCCPsuZZrKciWMgDCcTyX3W7Z8TF+GKx/Huf
ncFmSd5NTmitRZ6t+m6/q99rvMoIOqHvkL4SWniSxnPsExDvoxRgK0AToHv8fsnT
TQymsELjsZB2Rsio445EssE+NLaudDOgcV9eP43DV6LbuvnS8/6a/fboYgIw8k47
STK0u/UqdrXMzjX+V5RLfdD7AcjmOzlvGa/PbyzGHfl5Lg591Wwco2b/7v+mzIpD
3h1zgsnkiIpWgCH6bGOT79tWLg+jAFkdzpHHX3j+C7v2zOKEdarq00Nz0vI3Z/31
tXZ8Dr2k47XQwAkZcY0Qb+OcDgLP0XP2ugnG8evGUTO4cXc8U0e4pIzzIgfFOVbF
eJB700G9yRUMUEJjmQ0b
=rgEq
-----END PGP SIGNATURE-----

--kF7a3aeHaWdu1m9E0s2Qga4XAgvwI1Lcu--

