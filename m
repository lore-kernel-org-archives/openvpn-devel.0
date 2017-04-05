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
	<CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4f6776e3-3b9b-fae4-339c-6f28b6a24b1e@...2080...>
Date: Thu, 6 Apr 2017 00:26:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nhed19xPm717FOOOvsHsjm0cF5EDVLFp7"
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nhed19xPm717FOOOvsHsjm0cF5EDVLFp7
Content-Type: multipart/mixed; boundary="J3nhtUeuQWSuAo7o2JUcq6H8xQ7RXm0L2";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <4f6776e3-3b9b-fae4-339c-6f28b6a24b1e@...2080...>
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
	<CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
In-Reply-To: <CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>

--J3nhtUeuQWSuAo7o2JUcq6H8xQ7RXm0L2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 23:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> hello!
>=20
> just curious how renegotiation is handled in "https" ?
> is it "an abbrevated ssl handshake" (RFC 2246) or ... ?

The HTTPS and OpenVPN protocol is not comparable in this regard at all.
AFAIR, OpenVPN does not make use of the TLS renegotiation possibility at
all.  So a renegotiation in OpenVPN actually results in a completely new
and fresh TLS session, not related to previous TLS sessions at all.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> 2017-04-06 2:39 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>=20
>     On 05/04/17 23:13, debbie10t wrote:
>     > I don't believe there is any need to specify "max" because that wou=
ld be
>     > --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec
>=20
>     I think you, probably without being aware of it, are agreeing to what
>     the current proposal is:
>=20
>       --reneg-sec max
>         A renegotiation happens within 'max' seconds, but with a 10%-ish
>         randomness
>=20
>       --reneg-sec min max
>         A renegotiation happens within 'min' and 'max' seconds, fully
>         controllable
>=20
>     So using --reneg-sec 3600 3600, effectively removes the randomness.
>=20
>=20
>     --
>     kind regards,
>=20
>     David Sommerseth
>     OpenVPN Technologies, Inc


--J3nhtUeuQWSuAo7o2JUcq6H8xQ7RXm0L2--

--Nhed19xPm717FOOOvsHsjm0cF5EDVLFp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5W8eAAoJEIbPlEyWcf3ywssP/1qradGdds31ooRojexibF2I
Ntbk6ALBN22gMn7EEDPo4ep1a2u1NlKGXiAhf/+9crpIfmRQcNHZMoXBPj5TH9tP
RBrvl1SdD0Tea5bDqfHJqDeSnS0b4qUVGXCM+3wYWPwBAL+txltUgupST7yc923g
2FK2UcnSZHkprzPIHIZtToJoxJmXty6cc3n0MtUX9ADW7Awbdj4rZQ2S96f7Psfl
uVsIr/BIoqOqXuztKzOvNeyBQ/vMmHgneMbkRAxot8HqOPQXB/sc0hRip7wWxrZO
phJ+z55oqCrN0eozxef68+fqMThvWnAVEsfq+QbGmdJO3j9H0+O5zF9aVspTOO5+
3/A9aXl1W3MVoykZPFo1mbU8ndocGpDLeq46KbFvn6TRlxb9ZWd1LBRlKpdKT6su
O2tnMlxCcCeuyM6a8Gk7JWwo2A3/ZOQmsAyWSvQn2L/EAUKusact7R8sel+LpUam
LqbRd9r0pVN8e9JsHovC63iw8Jdr/5ahPm+JCbz/rdsmsBR0wGDlaMLbunQ+kJQD
xsTJS9aedixA4wtLXdQd8iLldJPmGIwO6tD9ygkgk+jQHKtxhW/VJktlU49Ql4hP
t0mqVGIoIwsnW6mx8AnOYAO3TWOqbPcptkai5P3L8n8T/4gO5eX3MoRmhq7GVOGt
luXHSGRkKUtJIFS3SqoW
=Pveu
-----END PGP SIGNATURE-----

--Nhed19xPm717FOOOvsHsjm0cF5EDVLFp7--

