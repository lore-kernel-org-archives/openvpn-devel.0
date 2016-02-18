References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C5EE36.5080906@...277...>
Date: Thu, 18 Feb 2016 17:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jabccI8Ued8qvQT71Vs1GxX4mpC59xSeF"
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jabccI8Ued8qvQT71Vs1GxX4mpC59xSeF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

W dniu 18.02.2016 o 17:01, Steffan Karger pisze:
> Hi d33tah,
>=20
> On Thu, Feb 18, 2016 at 2:28 PM, Jacek Wielemborek <d33tah@...277...> wro=
te:
>> I had been fascinated by afl-fuzz for quite a couple months so far and
>> based on how efficient it is in finding bugs in open source projects,
>> I'd like to ask the OpenVPN community whether somebody here tried out
>> this tool on this project.
>>
>> If not, you might be interested in my project that automates
>> recompilation of openvpn with afl-gcc:
>>
>> https://github.com/d33tah/aflize
>>
>> Just run "aflize openvpn" and you'll get build environment ready in minu=
tes.
>>
>> Let me know if you'd like any help fuzzing OpenVPN, I'd be happy to
>> assist you guys :)
>=20
> Thank you.  This has been on my todo-list for ages now, but never got
> around to doing something with it.
>=20
> I'm not aware of any openvpn fuzzing with tools like afl.  OpenVPN
> does have an internal, simple, fuzzer for network traffic, which
> randomly flips bits.  Look for 'gremlin' in the source.
>=20
> -Steffan

I'd have to know more about this gremlin to be able to tell whether it
could help in fuzzing OpenVPN with AFL. Definitely doing more than just
randomly flipping bits would help - AFL would use a genetic algorithm
that would watch for changes in code coverage based on input mutations.

The thing is that in order to fuzz it most efficiently, it would be good
to modify the server to use stdin/stdout (or dev null) for network I/O
and terminate after handling a single connection. Also, we would need to
disable any checksums, compression or encryption.

How difficult would that be?


--jabccI8Ued8qvQT71Vs1GxX4mpC59xSeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxe42AAoJEGlViymZXJRvt4MQAIfLUHt4LgCBY2oMVy00cOPg
3mldO+QGnp+hhPFeuDOWQGM8Ic3NMSF8OhaoWnDxWoFhZjAbxpd6Tx3qts2CZjEt
M7H2E+JyEy6yl82oCgC/AcvfJreNBWgU9OTORiSkvtOX/0qtXn9gwinmCsPsH9WN
OnCOOXOc5RXAorsc/gEVhMkGFSJBib7LWAVSgkoQGdpRlikPVNFGHoCDpNfzn98e
b+Dl0WX69M8fK7uXpH+8kqNSL1zDsx101j3HE++EweNhtv8dcYeh9fu7HzGXZf2S
wMnsWp/cQLZ5CdSTjotDDrfb+h+DHOd+Z4OtRU9ZpDX+HPQCQtAHBzmgV754hcrK
K1dUYkHJDq01fBJYFRIf6HSHRtYsEBNO1dK9BdHEbSJxeuG8/E/AY7/R0eWM7p/j
1qSJJ6JIlcdALWiTrHoi5eW+agINtdpMxxoJgf8MpOiazMQdfBL3sK3H5GskMsdL
L9AVAjmy6NBqgSGqumtkgF7EJ3gxdyUSBvgZKbI73onputSRQ4bjLCqt38n9keOr
ym+ag/o+c79Hjmn0GnVw/med33WQmrjRsiQ75cPxDqMjGWOSmUcFSIDnG9xgeuQD
cfCBGAx55cLr6Lw5mR17cXPKWZ6p78GXzsvOLKGXydhPAdWUDDhcx3IbVabrHjxx
0SbIcsXqORpFAseusOvu
=OSBA
-----END PGP SIGNATURE-----

--jabccI8Ued8qvQT71Vs1GxX4mpC59xSeF--

