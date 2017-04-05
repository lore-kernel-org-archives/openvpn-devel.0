References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<de982e46-7014-13a0-44e9-5d888233e299@...277...>
	<fa12f155-3f85-5d2a-4350-7c7528bc22dc@...277...>
	<ce9df1b0-bf09-2e80-2b7f-3708a980cfd2@...277...>
	<944679a7-deca-bb18-27e3-18eacfbdb93b@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9ffd2b9d-2b29-d50c-19cd-33541b3d01bf@...2080...>
Date: Thu, 6 Apr 2017 01:29:23 +0200
MIME-Version: 1.0
In-Reply-To: <944679a7-deca-bb18-27e3-18eacfbdb93b@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3PQFiBIIIg4wKNg3jfHSL65Gl5NtLaaQb"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3PQFiBIIIg4wKNg3jfHSL65Gl5NtLaaQb
Content-Type: multipart/mixed; boundary="W78aJ1CJoQOJaj1pIa7Nf6N9OpT1euriX";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9ffd2b9d-2b29-d50c-19cd-33541b3d01bf@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<de982e46-7014-13a0-44e9-5d888233e299@...277...>
	<fa12f155-3f85-5d2a-4350-7c7528bc22dc@...277...>
	<ce9df1b0-bf09-2e80-2b7f-3708a980cfd2@...277...>
	<944679a7-deca-bb18-27e3-18eacfbdb93b@...277...>
In-Reply-To: <944679a7-deca-bb18-27e3-18eacfbdb93b@...277...>

--W78aJ1CJoQOJaj1pIa7Nf6N9OpT1euriX
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 06/04/17 00:30, debbie10t wrote:
>=20
> One final clarification:
>=20
> As a user, I would prefer to see an early 2fa re-connect than one in
> the final few minutes, especially if I am already accustomed to a one
> hour cut off. Such that, I do 45 mins of work and get cut off is more
> annoying then doing 15 mins and get cut off.

This doesn't make much sense to me, to be honest.

At least all those 2FA approaches I've used (both hardware and software
tokens) usually have a life time of 30 seconds for each token.  So
unless the user types username and the new OTP code and password within
a reasonable time, the connection should be closed regardless.  Whenever
this renegotiation happens, it doesn't matter if 2FA is used or not - as
the 2FA code is most likely outdated already.

That said, doing a re-connect enforcing users to type in another 2FA is
also less than ideal - which can in a short term scope be avoided by
adding --auth-gen-token to the server config.  Which should preserve a
reasonably well security level on the session anyway.

And in regards to the --reneg-sec discussion ... whether it happens
after 3363 seconds or 3599 seconds doesn't really matter much for the
end-user.  Regardless of 2FA or not.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--W78aJ1CJoQOJaj1pIa7Nf6N9OpT1euriX--

--3PQFiBIIIg4wKNg3jfHSL65Gl5NtLaaQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5X3TAAoJEIbPlEyWcf3yws0QAIb1myKJyd3NDmd97gg8QtTj
1sBvmqLst/gc5CPRcTRBQIp15kPe0CnPxlFPD/bB9whrPwRJ9oETNNIZ7YOYPGJr
bPCrfal2xw6N0bOCh2bltxhbYIpvkQtYslE+mpVN9jorKWrLBNhHcJY29CKLTzjm
jrboutZBN5Vnp+fmc/93EowBqhw41viMJ0H8AsBbE9kFQ5xTgDYFkXUyVPXdnQxy
YJC+69w6SXoSY8nPv+vGmoeGgCUZG3CPaukw7UWvhXZEl8iMWyQjVFRqzJ3ujaFh
6g8bWjvCURFkFqJU6QbrhfyRmZrjL7xDSVrsw0M+aWsS4m00UCTwA8cXSCptVthF
6bnasdSpGO7t/KEBBN7WKtlLRqeebCpe9D9smBUZaLIFpRVBdA8BtvrANA7QqebV
B95JrFXfqHbw6/qi95pvQ4mDHBT++hUGruFwQjQCXzH/z7i5OxlRWI/50127Fih1
biLf2OweKGROaPQi0Wr8GOhfSCWjjCYAAMIIvwYI20U5HuSIFsxo0WubV+X/STwV
PlsQ4EaJqojOGkiN0v/HzcOyNvNJBy45mbczbuXFhw8a3w1AQfxTT1riKue5Hda3
ypvIVedqKjeRLtn8wyRy3VS99UIf38+iYqc+l5siK6BbBUj9WOptmF6YbSpjGL5r
Lhkbgg4zRpE2jT9Ijshu
=UHuU
-----END PGP SIGNATURE-----

--3PQFiBIIIg4wKNg3jfHSL65Gl5NtLaaQb--

